--======================================================================
--Hamza BOUKRAICHI GROUPE H
--calculatrice pile entier
--======================================================================
With text_io;  
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
With p_pile_ent;
use p_pile_ent;
--======================================================================

Procedure calculatrice_pile is

--======================================================================
--------------------Declarations de Types---------------------
Nombres_Manquants:Exception;
Divisions_par_0:Exception;
Commande_inconnue : Exception;
Operation_Inconnue : Exception;
--------------------Declarations de sous programmes---------------------
--procedure use_pile
--procedure qui gere la pile et la commande entrée
--Paramètres : Fp : pile
            -- Fcommande : string
--Préconditions : aucune
--Postconditions : aucune
--Exceptions :-- Constraint_Error
              -- Nombres_manquants
              -- Divisions_par_0
              -- Operation_Inconnue
n:Integer;
nombre1:INTEGER;
nombre2:INTEGER;
res:Integer;


  function use_pile (Fp : in out pile, Fcommande : in String, Flongueur: in Integer) is

  Begin
    n:=INTEGER'VALUE(commande(1..Flongueur));
    empiler(Fp,n);
    put(n,0);
  Exception
    When Constraint_Error =>
      If pile.hauteur < 2 then
	Raise Nombres_Manquants
      Else
	If Flongueur =1 then
	case commande(1) is
	  when '+' -> nombre1:=sommet(Fp);
	              depiler (Fp); 
		      nombre2:=Sommet(Fp);
		      depiler(Fp);
		      res:=nombre1+nombre2;
		      empiler(Fp,res);
		      put(res);

	  when '-' ->nombre1:=sommet(Fp);
	              depiler (Fp); 
		      nombre2:=Sommet(Fp);
		      depiler(Fp);
		      res:=nombre1-nombre2;
		      empiler(Fp,res);
		      put(res);

	  When '*' ->nombre1:=sommet(Fp);
	              depiler (Fp); 
		      nombre2:=Sommet(Fp);
		      depiler(Fp);
		      res:=nombre1*nombre2;
		      empiler(Fp,res);
		      put(res);


	  when '/' ->nombre1:=sommet(Fp);
	              depiler (Fp); 
		      nombre2:=Sommet(Fp);
		      depiler(Fp);
		      if nombre2=0 then
			Raise Divisions_par_0;
		      Else
			res:=nombre1/nombre2;
		        empiler(Fp,res);
		        put(res);
                      End if;

	  When Others -> Raise Operation_Inconnue;
            Else
	      Raise Commande_Inconnue;
	    End if;
	  End if;


---------------------Declarations de variables--------------------------
p:pile;
c:Character;
commande:String(1..10);
longueur: Integer;
n:Integer;
--======================================================================
function use_pile (p : in out pile
--------------------Programme Principale--------------------------------
Begin
  p:=creer_pile_vide();
  Loop
    Put("Que voulez vous Faire ?");
    New_Line;
    Put("e-Entrer un nombre ou une opération -- q-Quitter");
    New_Line;
    Get(c);
    Case c is
      When 'e' -> Put("Entrer le nombre ou l'opération");
                  New_Line;
                  Get_line(commande,longueur);
                  use_pile(p,commande,longueur);
                  

      When 'q' -> Put("Fermeture de calculatrice");
      When Others -> Raise Commande_Inconnue;
      


  Exit when c='q';
  End Loop;
End calculatrice_pile;
