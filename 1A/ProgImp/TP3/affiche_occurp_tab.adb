--Hamza BOUKRAICHI Groupe H
--Programme affiche_occurp_Tab
--programme affichant l'indice de la p ieme occurrence d'un éléments dans le tableau
with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
Procedure affiche_occurp_tab is 
  NMAX : constant INTEGER := 5; -- Indice maximum du tableau
  TYPE TAB_ENTIERS is ARRAY (1..NMAX) of INTEGER;
  un_tab : TAB_ENTIERS; -- un tableau d'au maximum NMAX entirers
  nb_elements : INTEGER; -- le nombre effectif d'éléments (<= NMAX) de un_tab.
  n : INTEGER; -- l'élément à chercher
  p : INTEGER; -- le nombre d'occurrence
  i : INTEGER; -- indice pour parcourir le tableau;
  nombre_occu: INTEGER; -- nombre de fois où l'élément apparait
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
    put("entrer l'élément à chercher");
    get(n);
    Loop
      put("entrer le nombre d'occurrence souhaité");
      get(p);
    Exit when p<= nb_elements;
    End loop; -- p <= nb-éléments
    nombre_occu:=0;
    i:=1;
    While i<= nb_elements and nombre_occu<p loop
      if un_tab(i)=n then
	nombre_occu:=nombre_occu+1;
	i:=i+1;
      else
	i:=i+1;
      End if;
    End loop; --i>nb_elements ou nombre_occu>p

    if nombre_occu=p then 
      put(i-1);
    else
      put("valeur non présente");
    End if;  
end affiche_occurp_tab;
