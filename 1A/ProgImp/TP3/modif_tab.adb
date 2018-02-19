--Hamza BOUKRAICHI Groupe H
--Programme Modif_Tab
--programme modifiant les tableaux
with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
Procedure modif_tab is 
  NMAX : constant INTEGER := 5; -- Indice maximum du tableau
  TYPE TAB_ENTIERS is ARRAY (1..NMAX) of INTEGER;
  un_tab : TAB_ENTIERS; -- un tableau d'au maximum NMAX entirers
  nb_elements : INTEGER; -- le nombre effectif d'éléments (<= NMAX) de un_tab.
  i : Integer; -- L'indice de la case à changer
Begin
  --Initialisation d'un tableau
  
     --Lire la taille effective du tableau
    Loop
       Put("Entrer le nombre d'éléments");
       Get(nb_elements);
    Exit When nb_elements <= NMAX and nb_elements>0;
    End Loop; -- 0<nb_elements>=NMAX
    --Initialiser les éléments du tableau
    For i in 1..nb_elements Loop
       Put("Donner une valeur à la case ");
       Put(i);
       Get(un_tab(i));
    End Loop;
    -- Modifier la ieme case du tableau
    Loop
      put("entrer l'indice de la case à modifier");
      get(i);
    exit When i<=nb_elements and i>0;
    end loop; -- 0<i<=nb_elements
    put("entre la valeur de la case ");
    put(i);
    get(un_tab(i));
End modif_tab;
