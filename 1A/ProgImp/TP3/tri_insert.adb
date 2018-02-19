--Hamza BOUKRAICHI Groupe H
--Programme tri_insert
--programme qui trie un tableau par la méthode du tri par insertion

with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;

procedure tri_insert is
  NMAX :constant INTEGER :=100; -- Indice maximum du tableau
  TYPE TAB_ENTIERS is ARRAY (1..NMAX) of INTEGER;
  un_tab : TAB_ENTIERS; -- un tableau d'au maximum NMAX entirers
  nb_elements : INTEGER; -- taille effective du tableau
  x : INTEGER; --Variable de sauvegarde de valeur
  Begin
  --Initialisation d'un tableau
  
     --Lire la taille effective du tableau
    Loop
       Put("Entrer le nombre d'éléments");
       Get(nb_elements);
    Exit When nb_elements <= NMAX and nb_elements>0;
    End Loop; -- 0<nb_elements<=NMAX
    --Initialiser les éléments du tableau
    For i in 1..nb_elements Loop
       Put("Donner une valeur à la case ");
       Put(i);
       Get(un_tab(i));
    End Loop; -- Tous les éléments du tableau sont initialisés
    for i in 2..nb_elements loop
      for j in 1..i loop
	if un_tab(j)>un_tab(i) then
	  x:=un_tab(i);
	  for k in reverse (j+1)..i loop
	    un_tab(k):=un_tab(k-1);
	  end loop; -- Décalage achevé pour i
          un_tab(j):=x;    
	else
	  null;
	end if;
      end loop; -- Décalage achevé pour tous les éléments
    end loop; -- Le tableau est trié

    --affichage des éléments triés    
    for i in 1..nb_elements loop
      put(un_tab(i));
    end loop;
end tri_insert;
