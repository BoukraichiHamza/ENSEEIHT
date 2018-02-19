--HAMZA BOUKRAICHI GROUPE H
--programme except_ens
-- Programme manipulant les ensembles en gérant les exceptions

pragma Assertion_Policy(CHECK);
with ada.text_io; use ada.text_io;
with ada.integer_text_io;
use ada.integer_text_io;
with ada.float_text_io;
use ada.float_text_io;
with ada.assertions;
use Ada.Assertions ;

Procedure except_ens is

  NMAX : constant integer := 20;
  type elements is array(1..NMAX) of integer;
  type ensemble is record
    contenu : elements;       -- les elements de l'ensemble
    cardinal : integer;       -- le nombre d'elements de l'ensemble
  end record;

  ensemble_plein: exception;
  element_present: exception;
  ensemble_vide: exception;
  element_absent: exception;
  
  --fonction creer_vide
  --fonction qui crée un ensemble vide
  --Paramètres
  --Aucun Parametres
  --Type retour Ensemble
  --Précondition : aucune
  --Postcondition l'ensemble retourné est vide
  
  Function creer_vide Return ensemble
    With
    POST=>creer_vide'RESULT.cardinal=0;
  
  FUNCTION creer_vide return ensemble is
    e_vide: ensemble;
  Begin
    e_vide.cardinal:=0;
    Return e_vide;
  End creer_vide;

  --Fonction appartient 
  --fonction qui teste si un élément appartient à un ensemble
  --Paramètres
  --Fe : ensemble; l'ensemble à tester
  --Fx : integer; l'entier à chercher
  --Type retour : boolean;
  --Précondition : le tableau est initialisé et contient des valeurs significatives
  --Postcondition : aucune

  

  FUNCTION appartient (Fe : IN ensemble; Fx : IN integer) RETURN BOOLEAN IS
    appart:BOOLEAN :=False; -- Booléen à retourner
    i:INTEGER:=1; -- Indice de parcours du tableau   
  BEgin
       While i<=Fe.cardinal and Then Fe.contenu(i)/=Fx LOOP
	 i:=i+1;
       END LOOP; -- i>cardinal ou Fe_contenu(i)=Fx
       IF i=Fe.cardinal+1 THEN
	 Null;
       ELSE
	 appart:=True;
        END IF;
       Return appart;
  END appartient;  

 --Procedure Ajouter
 --Procedure qui ajoute un élément à un ensemble
 --Paramètres
 --Fe : ensemble; D/R; l'ensemble où la valeur sera ajouté
 --Fx : integer; D; la valeur à ajouter
 --Préconditions : Fe.cardinal < NMAX
 --Postcondition : la valeur est ajouté à l'ensemble si c'est possible

  PROCEDURE ajouter (Fe : IN OUT ensemble; Fx : IN INTEGER)
    With
    PRE => Fe.cardinal>=0 and Fe.cardinal<=NMAX,
    POST => Fe.cardinal=NMAX or (not appartient(Fe'old,Fx)and Fe.cardinal=Fe'old.cardinal+1)  or (appartient(Fe'old,Fx) and Fe.cardinal=Fe'old.cardinal); 
  
  PROCEDURE ajouter (Fe : IN OUT ensemble; Fx : IN INTEGER) is
  Begin
    If appartient(Fe,Fx) Then 
      raise element_present;
    Elsif Fe.cardinal=NMAX Then
      raise ensemble_plein;
    ELSE
      Fe.cardinal:=Fe.cardinal+1;
      Fe.contenu(Fe.cardinal):=Fx;
    END IF;
  End ajouter;  
 
  --Procedure supprimer
 --Procedure qui retire un élément d'un ensemble
 --Paramètres
 --Fe : ensemble;D/R; l'ensemble d'où la valeur sera supprimée
 --Fx : integer; D; la valeur à supprimer
 --Préconditions: le tableau est initialisé et contient des valeurs significatives
 --Postconditions : la valeur est retirée de l'ensemble
  
  Procedure supprimer ( Fe :IN OUT ensemble; Fx : IN INTEGER) is 
  i:integer:=1; --Indice de parcours du tableau
   Begin
     IF Fe.cardinal=0 Then
       raise ensemble_vide;
     ELSE
       while i<= Fe.cardinal and then Fe.contenu(i)/= Fx Loop
         i:=i+1;
       END LOOP; -- i>cardinal ou Fe.contenu(i)=Fx
       IF i=Fe.cardinal+1 Then
        raise element_absent;
       ELSE
	 Fe.contenu(i):=Fe.contenu(Fe.cardinal);
	 Fe.cardinal:=Fe.cardinal-1;
       END IF;
     END IF;
   End supprimer;

  


 --Procedure afficher
 --Procedure qui affiche le contenu de l'ensemble
 --Paramètres
 --Fe : ensemble; D; l'ensemble à afficher
 --PRéconditions : tableau initialisé
 --Postconditions : le tableau est affiché

 Procedure afficher ( Fe : IN ensemble) is
  Begin
    IF Fe.cardinal = 0 Then
      Put("Ensemble vide");
      NEW_line;    
    Else
      Put("Le nombre d'éléments est ");
      PUT(Fe.cardinal);
      NEW_LINE;
      PUT("Les valeurs sont ");
      FOR i in 1..Fe.cardinal LOOP
	PUT(Fe.contenu(i));
      END LOOP;
      NEW_LINE;
    END IF;
  END afficher;
  

e_test2:ensemble;


Begin
   --Test des exceptions


  -- Création de l'ensemble vide
  -- aucune postcondition
   e_test2:=creer_vide;
   
  --suppression d'une valeur
 Begin   
  supprimer(e_test2,1);

 Exception
    When ensemble_vide => put("ensemble vide");
                         New_Line;
   When element_absent => put("element absent");
 End;

  --ajout de 20 valeurs
  --Préconditions vérifiées
  For i in 1..20 LOOP
   ajouter(e_test2,i); 
  END LOOP;

  --ajouter une valeur
  Begin
  ajouter(e_test2,25);
 Exception
    When ensemble_plein => put ("ensemble plein");
                          New_line;
  When element_present => put ("element present");
                          New_line;
  End;
  --suppression d'une valeur
  Begin
  supprimer(e_test2,25);
 Exception
   When ensemble_vide => put("ensemble vide");
                         New_Line;
   When element_absent => put("element absent");
                          New_line;
 End;

  --suppression d'une valeur
  supprimer(e_test2,20);
  Begin
  --ajout d'une valeur
  ajouter(e_test2,19);
 Exception
   When ensemble_plein => put ("ensemble plein");
                          New_line;
  When element_present => put ("element present");
                          New_line;
  End;


 End except_ens;
