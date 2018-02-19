--======================================================================
--Hamza BOUKRAICHI GROUPE H
--Spec Paquetage pile entier
--======================================================================

--======================================================================
Package p_pile_ent is

---------------------DECLARATIONS DE TYPES------------------------------
Type NOEUD;
Type PILE_AUX is access NOEUD;
TYPE Noeud is record
val:INTEGER;
suite:PILE_AUX;
End record;
Type PILE is record
pileval:PILE_AUX;
Hauteur:INTEGER;
END Record;
------------------DECLARATIONS DES EXCEPTIONS---------------------------
Pile_Vide:Exception;
--------------------DECLARATIONS DES SP---------------------------------
--======================================================================
--Fonction creer_pile_vide
--Fonction qui crée une pile vide
--Paramètres : aucun
--Préconditions : aucune
--Postconditins : pile vide
--Exceptions : aucune

function creer_pile_vide Return pile; 

--======================================================================
--Fonction est_vide
--Fonction qui teste si une pile est vide
--Paramètres : Fp : pile
--préconditions : aucune
--postconditions : aucune
--Exceptions : aucune

function est_vide ( Fp : in pile) return boolean;
--======================================================================
--Procedure empiler
--Procedure qui insere un élément en début de pile
--paramètres :-- Fe : INTEGER, Donnee, l'élément à insérer dans la pile 
	      -- Fp : pile, Donne/Resultat la pile 
	      --où l'élément sera inséré
--préconditions : aucune
--postconditions : l'élément est en tête de pile
--Exceptions : aucune

Procedure empiler (Fe : in INTEGER; Fp : in out Pile);             
--======================================================================
--Procedure depiler
--Procedure qui retire l'élément en début de pile
--paramètres :Fp : pile, Donne/Resultat la pile où l'élément sera retiré
--préconditions : aucune
--postconditions : l'élément n'est plus en tête de pile
--Exceptions : Liste Vide

Procedure depiler ( Fp : in out Pile);
--======================================================================
--Procedure afficher
--Procedure qui affiche les éléments d'une pile
--Paramètres : Fp :Pile; Donnee; la pile à afficher
--Préconditions : aucune
--Postcondition : aucune
--Exception : aucune

procedure afficher (Fp : in Pile);
 
--======================================================================
--Fonction sommet
--Fonction qui retourne le sommet d'une pile
--Paramètres : Fp ; Pile; la pile dont le sommet sera retourné
--Préconditions : aucune
--Postconditions : aucune
--Exception : Liste Vide

function sommet ( Fp: in Pile) Return INTEGER ;

--======================================================================
end p_pile_ent;
