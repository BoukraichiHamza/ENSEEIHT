--Hamza BOUKRAICHI Groupe H
--Calculer la somme des entiers compris entre deux entiers donnés
with text_io; use text_io;
with ada.integer_text_io; use ada.integer_text_io;

procedure somme_ada is
  --Fonction sommation
  --Fonction qui calcule la somme des entiers compris entre deux entiers
  --m et n entiers
  --type retourné entier représentant la somme des entiers
  --précondition n>=m>=0
  --postcondition Somme>=0
  function sommation ( Fm: in  integer;  Fn: in integer) return integer is
    s : integer; -- La somme des entiers compris entre n et m
   begin
    s:=0;
    for i in Fm..Fn loop
      s := s+i;
    end loop; -- s est la valeur retournée de la somme des entiers
    return s;
  end sommation;
  m : integer; -- l'entier qui amorce la boucle
  n : integer; -- l'entier qui acheve la boucle
  Begin
     PUT("La somme des entiers entre 5 et 10 est");
     Put(sommation(5,10),0);
     NEW_LINE;
     loop
       Put("Donner m>=0");
       Get(m);
      Exit when m>=0;
     end loop; -- m>=0
     loop
       put("Donner n>=0");
       get(n);
      Exit when n>=0 and n>m;
     end loop; -- n>m>=0
     Put("la somme des entiers entre ");
     Put(m,0);
     Put(" et ");
     Put(n,0);
     Put(" est ");
     Put(sommation(m,n),0); -- Préconditions vérifiées n>m>=0
  end somme_ada;




