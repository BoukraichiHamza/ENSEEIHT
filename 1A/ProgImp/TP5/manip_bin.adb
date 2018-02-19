--Hamza BOUKRAICHI GROUPE H
--Programme manipulant les nombres positifs binaires

--------------------------------------------------
-- pour les pre et post conditions
pragma Assertion_Policy(CHECK);
with Ada.Assertions ; use Ada.Assertions ;
--------------------------------------------------

with text_io; use text_io;
with ada.integer_text_io;
use ada.integer_text_io;


Procedure manip_bin is 
  NMAX : constant INTEGER := 7; -- Indice maximum du tableau
  TYPE BINAIRE is ARRAY (0..NMAX) of INTEGER;
  N : INTEGER;
  M : INTEGER;
  S : INTEGER;
  tab_binM : BINAIRE;
  tab_binN : BINAIRE;
  tab_binS : BINAIRE;
  --Procédure affich_bin
  --procédure qui affiche un nombre binaire à l'écran
  --paramètres
  -- Ftab_bin : binaire; Donnée, tableau représentant le nombre binaire
  -- précondition :le tableau doit être initialisé et ne contient que des valeurs significatives
  -- postcondition : le nombre binaire est affiché
 
  ---------  specification affich_bin  avec pre et post condition --------------
  PROCEDURE affich_bin (Ftab_bin :IN BINAIRE)
  WITH
  PRE  =>True,
  POST =>True;
  
  --------- definition complete de affich_bin --------------
  PROCEDURE affich_bin (Ftab_bin :IN BINAIRE) is
  BEGIN
    FOR i in REVERSE 0..NMAX LOOP
      put(Ftab_bin(i),0);
    END LOOP;
    NEW_LINE;
  END affich_bin;
    


  --fonction bin_to_b10
  --fonction qui convertit un nombre binaire en base 10
  --paramètres
  --Ftab_bin : binaire; Donnée; tableau représentant le nombre binaire à convertir
  --précondition :le tableau doit être initialisé et ne contient que des valeurs significatives
  --type résultat : entier représentant la conversion du nombre binaire en base 10
  --Postcondition : le nombre binaire est affiché en base 10
  
  
  
  FUNCTION bin_to_b10 (Ftab_bin : IN BINAIRE) RETURN INTEGER is
    Nombre_b10 : INTEGER :=0;
  BEGIN
    FOR i in  0..NMAX LOOP
      nombre_b10 := nombre_b10 + (2**(i))*ftab_bin(i);
    END LOOP;
    RETURN nombre_b10;
  END bin_to_b10;

  --fonction b10_to_bin
  --fonction qui convertit un entier en base 10 en binaire
  --paramètres
  --Fn : entier; l'entier à convertir en binaire
  --précondition : Fn>=0
  --type résultat : BINAIRE; représentant la conversion de l'entier en binaire
  --postcondition: le tableau retourné est initialisé et ne contient que des valeurs significatives
 
  ---------Specification b10_to_bin avec pre et post condition-----------
  FUNCTION b10_to_bin (Fn : IN INTEGER) RETURN BINAIRE
    WITH
    PRE => Fn>=0,
    POST => True;
---------------Specification complete de b10_to_bin--------------
  FUNCTION b10_to_bin (Fn : IN INTEGER) RETURN BINAIRE is
    tab_conv : BINAIRE;
    quotient : INTEGER :=Fn;
  BEGIN
    FOR i in 0..NMAX LOOP
      tab_conv(i) := quotient mod 2;
      quotient := quotient / 2;
    END LOOP;
    RETURN tab_conv;
  END b10_to_bin;



  --fonction somme_bin
  --fonction qui effectue la somme de deux nombres binaires positifs
  --paramètres 
  --Ftab_bin1 : BINAIRE; représentant le premier nombre
  --Ftab_bin2: BINAIRE; représentant le deuxième nombre
  --précondition : les deux tableaux sont initialisés et ne contiennent que des valeurs significatives
  --Type retourné : BINAIRE; tableau représentant la somme des nombres binaires
  --postcondition : le tableau retourné est initialisé et ne contient que des valeurs significatives
  FUNCTION somme_bin(Ftab_bin1 : IN BINAIRE; Ftab_bin2 : IN BINAIRE) RETURN BINAIRE is 
    tab_somme : BINAIRE;
    retenue : INTEGER :=0;
  BEGIN
    FOR i in  0..NMAX LOOP
      if retenue=0 then
	if Ftab_bin1(i)+Ftab_bin2(i)=2 then
	  tab_somme(i):=0;
	  retenue:=1;
	 else
	   if Ftab_bin1(i)+Ftab_bin2(i)=1 then
	   tab_somme(i):=1;
	   retenue:=0;
	 else
	   tab_somme(i):=0;
	   retenue:=0;
	   end if;
	end if;   
      else
	if Ftab_bin1(i)+Ftab_bin2(i)=2 then
	  tab_somme(i):=1;
	  retenue:=1;
	else
	  if Ftab_bin1(i)+Ftab_bin2(i)=1 then
	    tab_somme(i):=0;
	    retenue:=1;	  
	  else 
	    tab_somme(i):=1;
	    retenue:=0;
	   end if;
	  end if;
      end if;
    END LOOP;
    RETURN tab_somme;
  END somme_bin;  
  

BEGIN
  --lecture de deux nombres entiers au clavier
  LOOP
    put("entrer un premier entier positif");
    NEW_LINE;
    get(M);
  EXIT WHEN N>=0;
  END LOOP;
  --M >= 0
  
  LOOP
    put("entrer un deuxième entier positif");
    NEW_LINE;
    get(N);
  EXIT WHEN M>=0;
  END LOOP;
  --N>=0
  
  --Conversion de ces deux nombres en binaires
  --Préconditions vérifiées M>=0 et N>=0
  tab_binM:= b10_to_bin(M);
  tab_binN:= b10_to_bin(N);

  --Affichage de ces deux nombres binaires
  --Préconditions vérifiées puisque tab_binM et tab_binN sont initialisés et ne contiennent que des valeurs significatives
   affich_bin(tab_binM);
   affich_bin(tab_binN);

  --Effectuer la somme des deux nombres binaires
  --préconditions vérifiées (tableaux initialisés et valeurs significatives)

  tab_binS := somme_bin(tab_binM,tab_binN);

  --affichage de la somme binaire
  --préconditions vérifiées (tableau initialisé et valeurs significatives)

  affich_bin(tab_binS);

  --conversion de la somme en base 10
  --préconditions vérifiées (tableau initialisé et valeurs significatives)

  S:=bin_to_b10(tab_binS);

  --affichage de la somme en base 10
  put("la somme est ");
  put(S);
END manip_bin;



 
 


 


