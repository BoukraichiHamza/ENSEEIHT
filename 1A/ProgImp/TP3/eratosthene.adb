--Hamza BOUKRAICHI Groupe H
--Programme erathostene
--programme qui calcule et affiche les nombres premiers entre 2 et N (lu au clavier) par la méthode du crible d'Eratosthène
with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
Procedure eratosthene is 
  NMAX :constant INTEGER :=100; -- Indice maximum du tableau
  TYPE TAB_ENTIERS is Array (2..NMAX) of BOOLEAN;
  un_tab : TAB_ENTIERS; -- un tableau d'au maximum NMAX entirers
  N : INTEGER; -- taille effective du tableau
Begin
--Lire N au clavier >=2
  loop
    put("donner N>=2");
    get(N);
  Exit when N>=2 and N<=NMAX;
  End loop; -- 2<=N<=NMAX
  for i in 2..N loop
      un_tab(i):=true;
      end loop; -- LE tableau est initialisé à true
  for i in 2..N loop
    for j in 2..i-1 loop
      if i mod j = 0 then
	un_tab(i):=false; 
      else
	null;
      end if;
    end loop;
  end loop; -- Les nombres non premiers sont marqués de false
  put("les nombres premiers sont");
  for i in 2..N loop
    if un_tab(i) then 
      put(i);
    else
      null;
    end if;  
  end loop;
end eratosthene;



