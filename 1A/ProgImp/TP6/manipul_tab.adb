--HAMZA BOUKRAICHI GROUPE H
--programme manipul_tab
-- Programme manipulant un tableau

pragma Assertion_Policy(CHECK);
with ada.text_io; use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
with ada.float_text_io;
use ada.float_text_io;
with ada.assertions;
use Ada.Assertions ;


Procedure manipul_tab is
  NMAX: CONSTANT INTEGER := 10;
  TYPE VECTEUR is ARRAY(1..NMAX) OF FLOAT;
  TYPE INDICATEUR is ARRAY(1..NMAX) OF BOOLEAN;
  TYPE TAB_MAP is RECORD
     tab_val : VECTEUR; -- le tableau des valeur
     tab_ind: INDICATEUR; -- le tableau indicateur de l'état des cases de tab_val
     nb_e: INTEGER; -- le nombre de valeurs effectives du tableau
     imin : INTEGER; --l'indice de départ des valeurs effectives
     imax : INTEGER; -- l'indice de fin des valeurs significatives
  END RECORD;


  --Procedure ajout_val
  --procedure qui ajoute une valeur dans une case libre du tableau
  --paramètres
  -- Fx : FLOAT;DONNEE; la valeur à ajouter dans le tableau
  -- Ftab_bm : TAB_MAP; DONNEE/RESULTAT contenant le tableau où la valeur sera ajoutée
  --précondition : les deux tableaux sont initialisés
  --postcondition : la valeur x a été ajouté au tableau si c'est possible
    --et son indicateur a la valeur true
  Procedure ajout_val(Ftab_bm : IN OUT TAB_MAP; Fx : IN FLOAT) is
     i : integer; -- Indice pour rechercher une place libre
  Begin
      IF Ftab_bm.imin =1 AND Ftab_bm.imax=1 AND Ftab_bm.nb_e=0 THEN
             Ftab_bm.tab_val(Ftab_bm.imin):=Fx;
	     Ftab_bm.tab_ind(Ftab_bm.imin):=TRUE;
	     Ftab_bm.nb_e:=Ftab_bm.nb_e + 1;
       
      ELSIF Ftab_bm.imax - Ftab_bm.nb_e > Ftab_bm.imin THEN
      i:=Ftab_bm.imin;
         WHILE i <= Ftab_bm.imax AND THEN Ftab_bm.tab_ind(i) LOOP
	   i :=i+1;
         END LOOP; --i=imax+1 ou not tab_ind 
           IF i=Ftab_bm.imax + 1 THEN
	     NULL;
	   ELSE
	     Ftab_bm.tab_val(i):=Fx;
	     Ftab_bm.tab_ind(i):=TRUE;
	     Ftab_bm.nb_e:=Ftab_bm.nb_e + 1;
	   END IF;
      

      ELSIF Ftab_bm.imin > 1 THEN
	 Ftab_bm.imin:=Ftab_bm.imin - 1; 
	 Ftab_bm.tab_val(Ftab_bm.imin):=Fx;
	 Ftab_bm.tab_ind(Ftab_bm.imin):=TRUE;
	 Ftab_bm.nb_e:=Ftab_bm.nb_e + 1;
      
      ELSIF  Ftab_bm.imax < NMAX THEN
	 Ftab_bm.imax:=Ftab_bm.imax + 1; 
	 Ftab_bm.tab_val(Ftab_bm.imax):=Fx;
	 Ftab_bm.tab_ind(Ftab_bm.imax):=TRUE;
	 Ftab_bm.nb_e:=Ftab_bm.nb_e + 1;

      ELSE
	PUT("Aucune place disponible");
	NEW_LINE;
      
      END IF;
  END ajout_val;

      
  --Fonction occu1
  --Fonction qui recherche la première occurrence d'une valeur 
   --et retourne son indice
  --Paramètres
  --Ftab_bm: TAB_MAP; DONNEE; contenant le tableau où la valeur sera recherchée
  -- Fx : FLOAT; DONNEE; la valeur à rechercher dans le tableau
  --précondition : les deux tableaux sont initialisés
  --Type Retourné : INTEGER; l'indice de la premiere occurrence ou 0;
  --postcondition : l'indice de la première occurence si elle existe est affiché;

  Function occu1 ( Ftab_bm : IN TAB_MAP; Fx : IN FLOAT) RETURN INTEGER IS
  i:INTEGER :=Ftab_bm.imin; --INDICE DE PARCOURS DU TABLEAU
  O:INTEGER; -- L'indice de la premiere occurrence  
  Begin
     WHILE i<=Ftab_bm.imax AND THEN Ftab_bm.tab_ind(i) AND THEN Ftab_bm.tab_val(i)/=Fx LOOP
      i:=i+1;
     END LOOP; -- I>IMax ou tab_val(i)=x
     IF i=Ftab_bm.imax+1 THEN
       O:=0;
     ELSE
       O:=i;
     END IF;
     RETURN O;
  END occu1;

  --PROCEDURE remove
  --PROCEDURE qui supprime la valeur de la case d'indice i 
  --Paramètres
  -- Fi :INTEGER; DONNEE; l'indice de la case à supprimer
  --Ftab_bm: TAB_MAP; DONNEE/RESULTAT; contenant le tableau où la valeur sera retirée
  --précondition : le tableau est initialisé
    --1=<i<=NMAX
  --postcondition : la case d'indice i aura la valeur false
    --imax et imin seront modifiés en conséquence
  PROCEDURE remove (Ftab_bm : IN OUT TAB_MAP; Fi : IN INTEGER) is
  BEGIN
    IF Fi=Ftab_bm.imin THEN
      Ftab_bm.tab_ind(Ftab_bm.imin):=False;
      Ftab_bm.imin:=Ftab_bm.imin + 1;
    ELSIF Fi=Ftab_bm.imax THEN
      Ftab_bm.tab_ind(Ftab_bm.imax):=False;
      Ftab_bm.imax:=Ftab_bm.imax - 1;
    ELSE
       Ftab_bm.tab_ind(Fi):=False;
    END IF;
    Ftab_bm.nb_e:=Ftab_bm.nb_e -1;
  END remove;

  --PROCEDURE affich_tab
  --PROCEDURE qui affiche les deux tableaux(booléens et valeurs) entre imin et imax
    -- puis affiche uniquement les val significatives avec le nb effectives d'éléments
  --Paramètres
    --Ftab_bm : TAB_MAP : DONNEE; contenant les tableaux à afficher;
  --précondition : les deux tableaux sont initialisés
  --postcondition : l'affichage des valeurs et des booléens a été effectué avec succés
 
  PROCEDURE affich_tab (Ftab_bm : IN TAB_MAP) is
   BEGIN
        put("Indice min = ");
        put(Ftab_bm.imin,0);
        NEW_LINE;
        
        put("Indice max = ");
        put(Ftab_bm.imax,0);
        NEW_LINE;

        FOR i in Ftab_bm.imin..Ftab_bm.imax LOOP
	  PUT("L'indice ");
	  PUT(i,0);
	  PUT("Valeur ");
          PUT(Ftab_bm.tab_val(i),0);
	  PUT("Indicateur d'état ");
	  IF Ftab_bm.tab_ind(i) THEN
	     PUT("True ");
	     NEW_LINE;
	  ELSE
	    Put("False ");
	    NEW_LINE;
	  END IF;
          NEW_LINE;
        END LOOP;
        NEW_LINE;

        PUT("Le nombre effectif d'éléments ");
	PUT(Ftab_bm.nb_e);
	NEW_LINE;
        
	PUT("Valeurs ");
	NEW_LINE;
	
	For i in Ftab_bm.imin..Ftab_bm.imax LOOP
	  IF Ftab_bm.tab_ind(i) THEN
	    PUT(Ftab_bm.tab_val(i));
	  ELSE
	    NULL;
	  END IF;
	END LOOP;
        NEW_LINE;
   END affich_tab;


  --PROCEDURE compact_tab
  --PROCEDURE qui élimine les trous entre imin et imax
  --Paramètres
  --Ftab_bm :TAB_MAP; DONNEE/RESULTAT; contenant le tableau à compacter
  --Précondition : les deux tableaux sont initialisés
  --Postcondition : le tableau est compacté
    --l'indicateur et imax seront modifiés en conséquence
  PROCEDURE compact_tab (Ftab_bm : IN OUT TAB_MAP) is
  sauvmax :INTEGER;-- Variable pour stocker la valeur de imax
  Begin
    sauvmax:= Ftab_bm.imax;
    FOR i IN Ftab_bm.imin..sauvmax LOOP
      IF Ftab_bm.tab_ind(i) THEN
	NULL;
      ELSE 
	FOR j in i..sauvmax-1 LOOP
	  Ftab_bm.tab_val(j):=Ftab_bm.tab_val(j+1);
          Ftab_bm.tab_ind(j):=Ftab_bm.tab_ind(j+1);
	END LOOP; -- LES VALEURS ONT été décalées vers le haut
        Ftab_bm.imax:=Ftab_bm.imax-1;
       END IF;
    END LOOP; -- Les tableaux sont compacts
  END compact_tab;

 
 tab_bm1 : TAB_MAP; -- L'enregistrement de TEST
 
BEGIN
  --Initialisation des tableaux
    -- Etat initial
        tab_bm1.imin := 1;
        tab_bm1.imax := 1;
        tab_bm1.nb_e:= 0;
        
        -- Passage de tous les booléens de tab_ind à false
        for i in 1..NMAX loop
            tab_bm1.tab_ind(i) := false;
        end loop; -- i = NMAX
  
  --Ajout des valeurs et affichage des tableaux
  --Précondions vérifiées
  ajout_val(tab_bm1,1.0);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  ajout_val(tab_bm1,2.0);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  ajout_val(tab_bm1,3.0);
  affich_tab(tab_bm1);
  NEW_LINE;

  ajout_val(tab_bm1,4.0);
  affich_tab(tab_bm1);
  NEW_LINE;

  ajout_val(tab_bm1,5.0);
  affich_tab(tab_bm1);
  NEW_LINE;

  --suppresions et affichage des tableaux
  --préconditions vérifiées
  
  remove(tab_bm1,1);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  remove(tab_bm1,3);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  remove(tab_bm1,5);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  --Ajout des valeurs et affichage des tableaux
  --Précondions vérifiées
  ajout_val(tab_bm1,2.5);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  ajout_val(tab_bm1,1.5);
  affich_tab(tab_bm1);
  NEW_LINE;
  
  ajout_val(tab_bm1,4.0);
  affich_tab(tab_bm1);
  NEW_LINE;
  --Compactage des tableaux puis affichage
  --préconditions vérifiées
  
  compact_tab(tab_bm1);
  affich_tab(tab_bm1);

  --Recherche des valeurs
  --préconditions vérifiées
  put("l'indice de la premiere occurence de 4.0 est ");
  put(occu1(tab_bm1,4.0));
  NEW_Line;
 
  put("l'indice de la premiere occurence de 1.0 est ");
  put(occu1(tab_bm1,1.0));
  NEW_Line;

  --Suppression de valeurs et affichage des tableaux
  --préconditions vérifiées

 remove(tab_bm1,3);
  affich_tab(tab_bm1);

  remove(tab_bm1,4);
  affich_tab(tab_bm1);

  --Recherche des valeurs
  --préconditions vérifiées
  put("l'indice de la premiere occurence de 4.0 est ");
  put(occu1(tab_bm1,4.0));
  NEW_Line;

  --Compactage des tableaux puis affichage
  --Préconditions vérifiées
  
  compact_tab(tab_bm1);
  affich_tab(tab_bm1);
  
END manipul_tab;


  




  












  
  


