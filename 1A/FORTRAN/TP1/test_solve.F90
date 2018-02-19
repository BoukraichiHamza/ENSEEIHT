!---------------------------------------------------------------------------------------
!Procédure (left/right)_looking_solve(L,x,b,n)
!Sémantique : effectue la résolution sans/avec reports du système triangulaire Lx = b
!Entrées :  - L, matrice de taille nxn de réels double précision
           !- b, second membre, vecteur de taille n
           ! -n, entier.
!Sortie : x, vecteur de taille n.
!Préconditions : - L est initialisée et aucun terme de sa diagonale n'est nul.
                !- n>0.
!Postconditions : x contient la solution de Lx = b.
!---------------------------------------------------------------------------------------
!Left(sans report)

subroutine left_looking_solve(L,x,b,n)

  implicit none
  integer, intent(in) ::n
  double precision, intent(in),dimension(n,n) :: L
  double precision, intent(in),dimension(n) :: b
  double precision, intent(out), dimension(n) :: x
  integer :: i,j

  x=b
 do j = 1,n
        do i = 1,j-1
                x(j) = x(j) - L(j,i)*x(i)
        end do
        x(j) = x(j)/L(j,j)
end do
return
end subroutine left_looking_solve





!---------------------------------------------------------------------------------------
!right(avec report)

subroutine right_looking_solve(L,x,b,n)

  implicit none
  integer, intent(in) ::n
  double precision, intent(in),dimension(n,n) :: L
  double precision, intent(in),dimension(n) :: b
  double precision, intent(out), dimension(n) :: x
  integer :: i,j

  x=b
 do j = 1,n
        x(j) = x(j)/L(j,j)
        do i = j+1,n
                x(i) = x(i) - L(i,j)*x(j)
        end do
        
end do
return
end subroutine right_looking_solve




!---------------------------------------------------------------------------------------
!Fonction realtive error (L,x,b,n)
!Calcule l'erreur relative
!Entrée : - L, matrice de taille n*n 
         !-x, solution calculée, vecteur de taille n.
         !-b, second membre
         !-n, entier
!Retour : un nombre réel double précision
!Précondition : n>0.
!Postcondition : aucune.

double precision function relative_error (L,x,b,n) 
  implicit none
  integer, intent(in) ::n
  double precision, intent(in),dimension(n,n) :: L
  double precision, intent(in),dimension(n) :: b
  double precision, intent(in), dimension(n) :: x
  double precision, dimension(n) :: produit !Le produit Lx
  integer :: i,j
  double precision :: norme
 <F4>
  !Calcul du produit Lx
  do i=1,n
        produit(i) = 0
        do j = 1,n
        produit(i) = produit(i) + L(i,j)*x(j)
        end do
  end do

  !Calcul de la norme de Lx - b
  norme = norm2(produit-b,n)

  !Calcul de l'erreur
  relative_error = norme / norm2(b)

  return 
  end function relative_error
  !---------------------------------------------------------------------------------------




program test_solve
  implicit none

  integer :: i, j, ierr, n
  double precision, allocatable :: L(:,:), x(:), b(:)
  double precision :: relative_error
  real :: start1, start2, finish1, finish2

  write(*,*) 'n?'
  read(*,*) n

  ! Initialization: L is spd
  write(*,*) 'Initialization...'
  write(*,*)
  
  allocate(L(n,n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate L(n,n) with n=',n
    stop
  end if

  allocate(x(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate x(n) with n=',n
    stop
  end if

  allocate(b(n), stat=ierr)
  if(ierr.ne.0) then
    write(*,*)'Could not allocate b(n) with n=',n
    stop
  end if

  L = 0.D0
  do i=1,n  
    L(i,i) = n+1D0
    do j=1,i-1
      L(i,j) = 1
    end do
  end do
  b = 1D0

  
  call cpu_time(start1)
  ! Left-looking triangular solve of Lx=b
  write(*,*) 'Solving with a left-looking method...'
   call left_looking_solve(L,x,b,n)
   !print*,x
  call cpu_time(finish1)
   !Affichage de l'erreur relative
   write(*,*) ' Erreur relative methode sans rapport : '
   print*,relative_error(L,x,b,n)

   !Affichage du temps nécessaire
   write(*,*) ' Temps d"éxécution methode sans rapport : '
   print '("Time = ",f6.3," seconds.")',finish1-start1



  call cpu_time(start2)
  ! Right-looking triangular solve of Lx=b
  write(*,*) 'Solving with a right-looking method...'
   call right_looking_solve(L,x,b,n)
   !print*,x
 call cpu_time(finish2)

   ! Affichage de l'erreur relative
   write(*,*) ' Erreur relative methode avec rapport : '
   print*,relative_error(L,x,b,n)

      !Affichage du temps nécessaire
   write(*,*) ' Temps d"éxécution methode avec rapport : '
   print '("Time = ",f6.3," seconds.")',finish2-start2


  deallocate(L,x,b)

end program test_solve
