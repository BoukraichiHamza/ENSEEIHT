!  $Id: TestLU.f90 460 2013-03-05 09:01:48Z abuttari $
!      ------------------------------------
!      Programme principal permettant
!      de tester la factorisation LU SANS pivotage d'une
!      matrice pleine 
!      ------------------------------------

program mainlu
  implicit none
  interface
     subroutine init(a, acopie, xexact, b, bcopie, x, y, r, lda, n)
       integer, intent(out) :: lda,n
       double precision, dimension(:,:), allocatable, intent(out) :: a, acopie
       double precision, dimension(:), allocatable, intent(out)   :: &
            xexact, b, bcopie, x, y, r
     end subroutine init
  end interface

  ! Dimension principale (taille de la structure de donnée allouee en memoire)
  integer :: lda 
  ! Dimension reelle du systeme a factoriser (on factorise A(1:n,1:n))
  integer :: n
  ! Matrice a factoriser
  double precision, dimension(:,:), allocatable :: a, acopie
  ! Solution exacte, second membre, solution calculee du systeme et residu
  double precision, dimension(:), allocatable   :: xexact, b, x, & 
       r, bcopie
  ! Vecteur temporaire
  double precision, dimension(:), allocatable   :: y
  ! Scalaire local
  integer :: ierr
  ! EXTERNAL
  ! external norme
  double precision :: NORME
  !
  ! --------------------------------------------
  !  Initialisation matrice A et second membre b
  !      -- definir A et Xexact puis calculer b = A xexact
  !         (faire une copie de A --> Acopie et b --> bcopie)
  !         allouer x, y et r 

  call init(a, acopie, xexact, b, bcopie, x, y, r, lda, n)
  ! -------------------------
  ! Factorisation de Gauss ( A = L U ) et calcul du determinant
  ! -------------------------
  write(6,*) '    '
  write(6,*) ' ............................... '
  write(6,*) ' FACTORISATION LU A ECRIRE       '
  write(6,*) ' ............................... '
  call facto(a, lda, n, ierr) 
  write(6,*) '    '
  ! ----------------------
  ! Algorithme de descente     ( L y = b)
  ! ----------------------
  call descente ( a, lda, n, b, y)
  ! ----------------------
  ! Algorithme de remontee     ( U x = y )
  ! ----------------------
  call remontee ( a, lda, n, y, x)

  !------------------------------------------
  ! Analyse de l'erreur :
  !   Calcul/affichage du residu || b - A x || et 
  !           du residu equilibre   || b - A x || / || |A||x| + |b| || 
  !   Calcul et affichage de || x - xexact || / || xexact ||
  !------------------------------------------

  write(6,*) '    '
  write(6,*) ' ............................... '
  write(6,*) ' ROUTINE ANALYSE ERREUR A ECRIRE '
  write(6,*) ' ............................... '
  call analyse_erreur (acopie,lda,n,bcopie,x,r,xexact)
  write(6,*) '    '

  deallocate (a, acopie, b, bcopie, x, r, y, xexact)
  stop
end program mainlu
!--------------------------------------------------------------
!--------------------------------------------------------------


!**************************************************
! Subroutines utilisées par le programme principal
!
!
!**************************************************
subroutine init(m,mcopie,xexact,b,bcopie, &
     x,y,r,ldm,n)
  implicit none
  ! -------------------------------------------------------------
  ! Objectif:
  ! - Tous les tableaux/matrices passes en arguments 
  ! sont alloues dans la routine.
  ! - Initialisation, de la matrice M, de la solution x 
  ! et du vecteur b tel que b = M x
  ! M est une matrice de dimension principale ldm avec 
  ! n colonnes. 
  ! Deux classes de matrices sont proposees:
  !  Classe I/ 
  !      -Les matrices d'ordre pair sont diagonales dominantes
  !      -Les matrices d'ordre impair ont de petites valeurs 
  !         sur la diagonale et peuvent conduire à une perte 
  !         de precision dans la solution
  !  Classe II/  
  !      -12 matrices utilisant le generateur de LAPACK
  ! Soit x / x(i) = dble(i) on construit alors b = M x
  ! Une copie de M (-->Mcopie) et de b (--> bcopie) est effectuee
  ! --------------------------------------------------------------
  interface
     subroutine matgen(imat, a, n, info)
       real(kind(1.d0)), allocatable :: a(:,:)
       integer :: imat, n, info
     end subroutine matgen
  end interface
  !
  !  Parametres :
  !  ----------
  integer, intent(out)           :: ldm,n
  double precision, allocatable, intent(out)  ::  &
       m(:,:), mcopie(:,:), xexact(:), &
       b(:), bcopie(:), x(:), y(:), r(:) 
  ! Dimension maximale du systeme
  integer, parameter :: ldmmax=5000
  !
  !  Variables locales :
  !  -----------------
  integer :: i,j, ierr, classmat, imat
  logical :: pair
  !
  !  Fonctions intrinseques
  intrinsic dble, min
  !      -- taille du probleme

  classmat = 1 
  ldm = -1
  n   = 0   
  do while ( (n.GT.ldm) .or. (ldm.ge.ldmmax) )
     write(6,*) ' Entrer la taille de la matrice lda (< ',  &
          ldmmax, ' ) ?'
     read(5,*)  ldm
     write(6,*) ' Entrer la dimension reelle n   (< ', ldm, ' ) ?'
     read(5,*)  n
     !
     write(6,*) ' Entrer la classe de matrice ', &
          ' (1 sinon 2 (generateur LAPACK))  ?'
     read(5,*)  classmat
  end do
     !
  if (classmat.eq.1) then
     !     -------------------------------
     !     Utilisation du generateur local
     !     -------------------------------
     !
     allocate(m(ldm,n), stat=ierr)
     if (ierr > 0) then
        write(6,*) ' Probleme allocation memoire :', &
             ' reduire n=', n
        stop
     endif
     !
     pair=(mod(n,2) .eq. 0)
     !      -- Initialisation de la matrice M
     !      Les matrices d'indice pair sont diagonales dominantes
     !      les matrices d'indice impair ont de petites valeurs 
     !      sur la diagonale.
     if (pair)  then 
        do i = 1,n
           do j=1,n
              m(i,j) = dble(1)
           end do
           m(i,i) = dble(n+100)
        end do
     else
        do i = 1,n
           do j=1,n
              m(i,j) = dble(i)*dble(j)
           end do
           m(i,i) = dble(i)*sqrt(epsilon(m(i,i))) 
       end do
     endif
  else
     !     -------------------------------------------------------------------
     !     Utilisation du generateur de matrices pour valider les codes LAPACK
     !     -------------------------------------------------------------------
     imat = 0
     do while ( (imat.le.0) .or. (imat.gt.12) )
        write(6,*) ' Generateur de matrices de LAPACK '
        write(6,*) ' Entrer le numero de la matrice entre 1 et 12 ?'
        read(5,*)  imat
     end do
     !      -- Initialisation de la matrice M
     ldm = n
     call matgen(imat, m, n, ierr)
     if (ierr.ne.0) then
        write(6,*) " Erreur dans le gnerateur LAPACK (matgen)"
        stop
     endif
  endif
  !
  !      -- allocation des structures de données
  allocate (mcopie(ldm,n), b(n), bcopie(n), x(n),  &
       r(n), y(n), xexact(n), stat=ierr)
  
  if (ierr > 0) then
     write(6,*) ' Probleme allocation memoire :', &
          ' reduire n=', n
     stop
  endif
  !     Copie de la matrice
  mcopie = m
  !      -- Initialisation de la solution exacte dans xexact
  do i=1,n
     xexact(i)   = dble(i)
  end do
  !
  !      -- Calcul de b / b = A xexact
  do i = 1, n
     b(i) = dble(0)
     do j=1,n
        b(i) = b(i) + m(i,j) * xexact(j)
     enddo
  enddo
  !      Sauvegarde de b
  bcopie = b

  !      -- impression des donnees
  if (n.le.10) then
     write (6,*) ' Matrice initiale A = '
     do i = 1,min(n,6)
        write(6,'(A,I3,6(E14.5))') ' ... Ligne ', i, m(i,1:min(n,6))
     end do
     write (6,'(A,6(E14.5))') ' xexact =', xexact(1:min(n,6))
     write (6,'(A,6(E14.5))') ' b      =', b(1:min(n,6))
  endif

  return
end subroutine init
!
!
!**************************************************
subroutine facto(m, ldm, n,  ierr)
  implicit none
  ! ------------------------------------------------------
  ! Objectifs: Factorisation LU sans pivotage
  ! 1/ Calculer L / M = L U
  !    La matrice M est de dimension principale ldm.
  !    On factorise le bloc M(1:n, 1:n) 
  !    par l'algorithme de factorisation LU sans pivotage 
  !    comme presenté en cours.
  !
  ! 2/ Le determinant sera aussi calcule 
  !
  !   En entrée la matrice M est écrasée en sortie
  !   par les facteurs L et U.
  !
  !   IERR > 0 si un pivot trop petit
  !                   a été rencontré durant factorisation 
  ! ------------------------------------------------------
  !
  !  Parametres :
  !  ----------
  integer, intent(in)             :: ldm,n
  double precision, intent(inout) :: m(ldm,n)   ! matrice
  integer, intent(out)            :: ierr
  !
  !  Variables locales :
  !  -----------------
  !      Indices de boucle
  integer :: i,j,k
  
  intrinsic epsilon
  double precision :: tol
  double precision :: det
  double precision :: anciendet
  double precision :: detm
  integer :: detexp
  intrinsic fraction
  intrinsic radix
  intrinsic exponent

    tol = epsilon(tol);
  ierr = 0
  do k = 1, n-1
    if (abs(m(k,k)) < tol) then
      ierr = 1
      stop
    end if
    
    m(k+1:n,k) = m(k+1:n,k) / m(k,k)
    
    do j = k+1,n
      do i = k+1,n
        m(i,j) = m(i,j) - m(i,k)*m(k,j)
      end do
    end do
  end do
        
  !Calcul du determinant!
  detm = 1
  detexp =0
  anciendet = 1
  do k=1,n
        anciendet = anciendet*m(k,k) 
        detm = detm*m(k,k)
        detexp = detexp + exponent(detm)
        detm = fraction(detm)
  end do
  det = detm * dble(radix(detm))**detexp
  !      -- impression des donnees :
  !       -- determinant
  write(6,*) " =============================================="
  write(6,*) " Fin de la FACTORISATION " 
  write(6,*) " ========================" 
  write(6,*) "Ancien Determinant ", anciendet
  write(6,*) "Detmantisse =", detm
  write(6,*) "Detexposant =", detexp
  write(6,'(A,6(E14.5))') 'Det m =', det
  if (n.le.6) then
     write (6,*) ' ... Matrice factorisee par ligne :  '
     do i = 1,n 
        write(6,'(6(E14.5))')  m(i,1:n)
     end do
  endif
  write(6,*) " =============================================="

  return
end subroutine facto

!**************************************************
subroutine descente (m,ldm,n,b,x)
  implicit none
  ! -----------------------------------------------------------
  ! Objectif:
  ! Resoudre L x = b avec 
  ! L la partie triangulaire inferieure de la matrice M,
  ! de dimension principale ldm et de n colonnes.
  ! Algorithme avec report:
  !   cet algorithme a assez naturellement tendance
  !   à modifier le second membre ce qui n'est 
  !   ni une bonne propriete ni
  !   indispensable comme le montre l'implementation fournie ici
  ! -------------------------------------------------------------
  ! 
  !  Parametres :
  !  ----------
  integer, intent(in)           :: ldm,n
  double precision, intent(in)  :: m(ldm,n)
  !      attention assez naturellement on va 
  !      lors du report modifier b 
  !         ( MAIS uniquement si on est peu attentif !)
  double precision, intent(in)  :: b(n)
  double precision, intent(out) :: x(n)
  !
  !  Variables locales :
  !  -----------------
  !      Indices de boucle
  integer :: i,j
  !
  !       Algorithme avec report sans modification de b
  !
  x  = b ! on ne modifiera que x
  do i = 1, n
     ! calcul du x(i)
     x(i) = x(i)  ! L a des 1 sur la diagonale (non stockes dans M!)
     ! report de la connaissance de x(i) sur es second membres.
     ! pour eviter de modifier b on note 
     ! qu'a chaque etape i, les parties
     ! modifiees de b et calculees de x forment une partition de {1,..,n}
     do j = i+1, n
        !            --- avec modification de b:
        !            --- b(j) = b(j) - M(j,i) * x(i)  
        !            sans modification de b:
        x(j) = x(j) - M(j,i) * x(i)
     end do
  end do
  !       write (6,*) " En sortie de la descente Ly = b: "
  !       write (6,'(A,6(E14.5))') '    b      =', b(1:min(n,6))
  !       write (6,'(A,6(E14.5))') '    y      =', x(1:min(n,6))

  return
end subroutine descente
!
!**************************************************
subroutine remontee (m,ldm,n,b,x)
  implicit none
  ! ------------------------------------------------------
  ! Objectif:
  ! Resoudre U  x = b avec 
  ! U la partie triangulaire superieure de la matrice M,
  ! de dimension principale ldm et de n colonnes.
  ! Algorithme sans report.
  ! ------------------------------------------------------
  ! 
  !  Parametres :
  !  ----------
  integer, intent(in)           :: ldm,n
  double precision, intent(in)  :: m(ldm,n), b(n)
  double precision, intent(out) :: x(n)
  !
  !  Variables locales :
  !  -----------------
  !      Indices de boucle
  integer :: i,j
  !      Algorithme sans report.
  do i = n, 1, -1
     x(i)  = b(i)
     ! on reporte la connaissance des x(j) pour j> i
     ! et on va chercher M(i,j) dans la triangulaire inferieure
     do j = i+1, n
        x(i) = x(i) - m(i,j) * x(j)
     end do
     x(i) = x(i) / m(i,i)
  end do
  !       write (6,*) " En sortie de la remontee Ux = y: "
  !       write (6,'(A,6(E14.5))') '    y      =', b(1:min(n,6))
  !       write (6,'(A,6(E14.5))') '    x      =', x(1:min(n,6))
  return
end subroutine remontee

!**************************************************
subroutine analyse_erreur(m,ldm,n,b,x,r,xexact)
  implicit none
  ! ------------------------------------------------------------
  ! Objectif:
  ! Analyse de l'erreur :
  !   Calcul et affichage de || b - M x || / || |M||x| + |b| ||
  !   Calcul et affichage de || x - xexact || / || xexact ||
  ! M etant une matrice carree de
  ! dimension principale ldm et de n colonnes. 
  ! -------------------------------------------------------------
  !
  !  Parametres :
  !  ----------
  integer, intent(in)           :: ldm,n
  double precision, intent(in)  :: m(ldm,n), x(n), b(n)
  double precision, intent(out) :: r(n)
  double precision, intent(in)  :: xexact(n)

  !
  !  Variables locales :
  !  -----------------
  !      Indices de boucles
  integer :: i, j
  integer :: ierr 
  double precision :: err
  double precision :: norme
  double precision :: req
  double precision :: rabs(n)
 

 ! Calcul de b -mx!
  do i=1,n
        r(i) = b(i)
        rabs(i) = abs(b(i))
        do j = 1,n
                r(i) = r(i) - m(i,j)*x(j)
                rabs(i) = rabs(i) + abs(m(i,j)*x(j))
        end do
  end do
 

  !Calcul du residu équilibre!
  req = norme(r,n)/norme(rabs,n)


  !Calcul de l'erreur relative!
  err =norme(x-xexact,n)/ norme(xexact,n)


  write(6,*) "  "
  write(6,*) " =============================================="
  write(6,*) " Analyse d'ERREUR "
  write(6,'(A,6(E14.5))') 'err =', err
  write(6,'(A,6(E14.5))') 'residu equilibre =', req
  write(6,*) " ================ "
  write(6,'(A,6(E14.5))') '  xexact   =', xexact(1:min(n,6))
  write(6,'(A,6(E14.5))') '  xcalcule =', x(1:min(n,6))
  write(6,*) " =============================================="

  return
end subroutine analyse_erreur

!**************************************************
double precision function norme ( x, n)
  implicit none
  ! ---------------------------------------
  ! Objectif: NORME = || x || , with 2 norm
  ! ----------------------------------------
  integer, intent(in)           :: n
  double precision, intent(in)  :: x(n)
  !
  !  Variables locales :
  !  -----------------
  !      Indices de boucles
  integer :: i
  !
  !  Fonctions intrinseques
  intrinsic sqrt, dble

  norme = dble(0)
  do i=1, n
     norme = norme + x(i) *x(i)
  enddo
  norme = sqrt(norme)

  return
end function norme

