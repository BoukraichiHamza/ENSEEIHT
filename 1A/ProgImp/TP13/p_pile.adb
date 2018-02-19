--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Paquetage pile entier
--======================================================================
With text_io;  
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
--======================================================================

Package Body p_pile is
--------------------DECLARATIONS DES SP---------------------------------
--======================================================================
--Fonction creer_pile_vide
--Fonction qui crée une pile vide
--Paramètres : aucun
--Préconditions : aucune
--Postconditins : pile vide
--Exceptions : aucune

function creer_pile_vide Return PILE is
	new_pile:PILE;
	Begin
		new_pile.pileval:=Null;
		new_pile.Hauteur:=0;
		Return new_pile;
	End creer_pile_vide;

--======================================================================
--Fonction est_vide
--Fonction qui teste si une pile est vide
--Paramètres : Fp : pile
--préconditions : aucune
--postconditions : aucune
--Exceptions : aucune

function est_vide ( Fp : in pile) return Boolean is
   Begin
   		Return (Fp.hauteur = 0);
	End est_vide;
	
--======================================================================
--Procedure empiler
--Procedure qui insere un élément en début de pile
--paramètres :-- Fe : T, Donnee, l'élément à insérer dans la pile 
	      -- Fp : pile, Donne/Resultat la pile 
	      --où l'élément sera inséré
--préconditions : aucune
--postconditions : l'élément est en tête de pile
--Exceptions : aucune

Procedure empiler (Fe : in T; Fp : in out Pile) is
	pins:PILE_AUX;
	Begin
		pins :=New NOEUD;
		pins.all.val := Fe;
		pins.all.suite := Fp.pileval;
		Fp.pileval:=pins;
		Fp.Hauteur:=Fp.Hauteur + 1;
	End empiler;
--======================================================================
--Procedure depiler
--Procedure qui retire l'élément en début de pile
--paramètres :Fp : pile, Donne/Resultat la pile où l'élément sera retiré
--préconditions : aucune
--postconditions : l'élément n'est plus en tête de pile
--Exceptions : Liste Vide

Procedure depiler ( Fp : in out Pile) is
	Begin
		If Fp.Hauteur = 0 Then
			Raise Pile_Vide;
		Else
			Fp.pileval:=Fp.pileval.all.suite;
		End if;
	End depiler;

--======================================================================
--Procedure afficher
--Procedure qui affiche les éléments d'une pile
--Paramètres : Fp :Pile; Donnee; la pile à afficher
--Préconditions : aucune
--Postcondition : aucune
--Exception : aucune

procedure afficher (Fp : in Pile) is
	Pcour:PILE_AUX;
	Begin
		pcour:=Fp.pileval;
		Put("Les éléments de la pile sont :");
		New_Line;
		While pcour /= Null Loop
		afficheT(pcour.all.val);
		pcour:=pcour.all.suite;
		End Loop; -- pcour = Null
	End afficher; 
 
--======================================================================
--Fonction sommet
--Fonction qui retourne le sommet d'une pile
--Paramètres : Fp ; Pile; la pile dont le sommet sera retourné
--Préconditions : aucune
--Postconditions : aucune
--Exception : Liste Vide

function sommet ( Fp: in Pile) Return T is
	Begin
		If Fp.pileval=Null Then
			Raise Pile_Vide;
		Else
			Return (Fp.pileval.all.val);
		End if;
	End sommet;

--======================================================================
end p_pile;
