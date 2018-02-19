--Hamza BOUKRAICHI Groupe H
--Programme incr_Tab
--programme incrémentant toutes les cases d'un tableau
with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
Procedure incr_tab is 
  NMAX : constant INTEGER := 5; -- Indice maximum du tableau
  TYPE TAB_ENTIERS is ARRAY (1..NMAX) of INTEGER;
  un_tab : TAB_ENTIERS; -- un tableau d'au maximum NMAX entirers
  nb_elements : INTEGER; -- le nombre effectif d'éléments (<= NMAX) de un_tab.

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
    For i in 1..nb_elements loop
      un_tab(i):=un_tab(i) +1;
    End loop;
End incr_tab;
