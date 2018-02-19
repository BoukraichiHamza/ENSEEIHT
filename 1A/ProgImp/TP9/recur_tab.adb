--HAMZA BOUKRAICHI GROUPE H
--Programme Manipulant les tableaux de facon récursive

--=======================================================================
with text_io;
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
--=======================================================================
Procedure recur_tab is

--=====================Déclarations de constantes========================
   Nmax:INTEGER:=100;
--=======================================================================

--=====================Déclarations de Types=============================
 Type Tab is Array(1..Nmax) Of Integer;

--=======================================================================

--=====================Déclarations de sous programmes===================


--=======================================================================
 --Procedure rev_affiche
 --Procedure qui affiche les éléments du tableau de droite à gauche
 --Parametres  :-- Ftab : D : Tableau à afficher
                -- FtailleR : D : Taille réelle du tableau
 --Précondition : Tableau initialisé et contient des valeurs significatives
 
   Procedure rev_affiche ( Ftab : IN TAB; FtailleR : IN INTEGER) is
     Begin
       If FtailleR >1 then
	 put(Ftab(FtailleR));
	 rev_affiche(Ftab, FtailleR-1);
       ELSE
	 put(Ftab(FtailleR)); 
       END IF;
      End rev_affiche;
--=======================================================================

--=======================================================================
--Procedure affiche
--Procedure qui affiche les éléments d'un tabelau de gauche à droite
--Parametres  :-- Ftab : D : Tableau à afficher
               -- FtailleR : D : Taille réelle du tableau
	       -- Fi : indice de début d'affichage
--Précondition :--Tableau initialisé et contient des valeurs significatives
                --1=<Fi
  Procedure affiche ( Ftab : IN TAB; Fi : in integer; FtailleR : IN INTEGER) is
  Begin
    IF Fi<= FtailleR Then
      put(Ftab(Fi));
      affiche(Ftab, Fi+1,FtailleR);
    End if;
  End affiche;
--=======================================================================
--Fonction cal_ind
--Fonction qui calcule l'indice d'une valeur donnée
--Paramètres : --Fx : INTEGER; La valeur dont l'indice sera calculé
               --Ftab : Tab, Le tableau où la valeur sera recherchée
               --FtailleR : Taille Réel du tableau
--Précondition : Le tableau est initialisé et contient des valeurs significatives
--Postcondition : L'indice de la valeur est retourné si elle se trouve dans le tableau et 0 sinon

  Function cal_ind (Fx : IN INTEGER; Ftab : IN Tab; FtailleR : In INTEGER) Return integer is
    Begin
     If FTailleR=0 Then
	Return 0;
     Elsif Ftab(FtailleR)=Fx Then
	Return FtailleR;
     Else
	Return(cal_ind(Fx, Ftab, FtailleR-1));
     End if;
    End Cal_ind;

--=======================================================================
--=====================Déclarations de Variables=========================
 
 Tab_test :Tab; --Tableau de Test
 TailleR_test: INTEGER:=0; --Taille Réelle du tableau de test

--=====================Programme Principal===============================
Begin
  --Intialisation du tableau
  For i in 1..20 Loop
    tab_test(i):=i*i;
    TailleR_test:=TailleR_test+1;
   End loop;
  
   --Affichage droite à gauche
   --préconditions vérifiés
   put("===================================================================");
   New_line;
   put("les valeurs du tableau de gauche à droite");
   New_line;
   rev_affiche(tab_test,tailleR_test);
   New_line;
   put("===================================================================");
   NEw_line;

   --affichage gauche à droite
   --préconditions vérifiées
      --Affichage droite à gauche
   --préconditions vérifiés
   put("===================================================================");
   New_line;
   put("les valeurs du tableau de gauche à droite");
   New_line;
   affiche(tab_test,1,tailleR_test);
   NEW_line;
   put("===================================================================");
   NEw_line;
  
   --calcul des indices de certaines valeurs
   --Préconditions vérifiées*)
   
   put("===================================================================");
   NEw_line;
   put("l'indice de la valeur ");
   put("5");
   put(cal_ind(5,Tab_test,TailleR_test));
   New_line;
   put("===================================================================");
   NEw_line;

    put("===================================================================");
   NEw_line;
   put("l'indice de la valeur ");
   put("16");
   put(cal_ind(16,Tab_test,TailleR_test));
   New_line;
   put("===================================================================");
   NEw_line;

    put("===================================================================");
   NEw_line;
   put("l'indice de la valeur ");
   put("25");
   put(cal_ind(25,Tab_test,TailleR_test));
   New_line;
   put("===================================================================");
   NEw_line;
  End recur_tab;
   



   

