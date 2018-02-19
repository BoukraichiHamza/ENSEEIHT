--======================================================================

--Hamza BOUKRAICHI GROUPE H
--Spec Paquetage Liste entier
--======================================================================

--======================================================================
Package p_liste_ent is
---------------------DECLARATIONS DE TYPES------------------------------
Type NOEUD;
Type LISTE is access NOEUD;
TYPE NOEUD is record
val:INTEGER;
suivant:LISTE;
End record;

--------------------DECLARATIONS DES SP---------------------------------
 --=====================================================================
 
--fonction créeer_liste_vide
--sémantique: créer une liste vide
--paramétres: aucun
--type retour: liste
--pré-condition: aucune
--post-condition: est_vide (l) vaut vrai
--exception: aucune

 function creer_liste_vide  Return LISTE;


 --=====================================================================
--fonction est_vide
--Semantique: teste si une liste l est vide
--parametres: Fl donnee type liste
--type retour: booleen
--pre-condition: aucune
--post-condition: aucune
--exception: aucune
   
 function est_vide (Fl : in LISTE) return boolean;

 --=====================================================================
--procedure inserer_en_tete
--semantique: insere l'element nouveau en tete de la liste l
--(l vide ou non vide)
--parametres: Fl donnee/resultat type liste
--Fnouveau donnee type entier
--pre-condition: aucune
--post-condition: nouveau appartient a la liste
--exception: aucune
 
 Procedure inserer_en_tete ( Fl: in out LISTE; Fnouveau : in INTEGER);


 --=====================================================================
--procedure afficher_liste
--semantique: afficher les elements de la liste l
--parametres: Fl donnee type liste
--pre-condition: aucune
--post-condition: aucune
--exception: aucune

  Procedure afficher_liste ( Fl : in LISTE);
  
 --=====================================================================
--fonction rechercher
--semantique: recherche si e est present dans la liste l,
--retourne son adresse ou null si la liste est vide ou
--si e n'appartient pas a la liste
--parametres: Fl donnee type liste
--Fe donnee type entier
--type-retour: liste
--pre-condition: aucune
--post-condition: aucune
--exception: aucune

    function rechercher (Fl : in LISTE; Fe : in INTEGER) Return LISTE;

 --=====================================================================

--procedure inserer_apres
--semantique: insere dans la liste l (liste vide ou non vide),
--l'element nouveau, apres la valeur data
--parametres: l donnee/resultat type liste
--nouveau donnee type entier
--data donnee type entier
--pre-condition: aucune
--post-condition: nouveau appartient a la liste
--exception: data n'est pas dans la la liste
--la liste est vide

 Procedure inserer_apres (Fl : in out LISTE; Fnouveau : in INTEGER;
  Fdata : IN INTEGER);


--======================================================================
--procedure inserer_avant
--semantique: insere dans la liste l (liste vide ou non vide),
--l'element de nom nouveau, avant la valeur data
--parametres: l donnee/resultat type liste
--nouveau donnee type entier
--data donnee type entier
--pre-condition: aucune
--post-condition: nouveau appartient a la liste
--exception: data n'est pas dans la la liste
--la liste est vide
 
Procedure inserer_avant (Fl : in out LISTE; Fnouveau : in INTEGER;
 Fdata : IN INTEGER);

--======================================================================
--procedure enlever
--semantique: enlever un element e de la liste l (liste vide ou non vide)
--parametres: l donnee/resultat type liste
--e donnee type entier
--pre-condition: aucune
--post-condition: e n'appartient pas a la liste
--exception: aucune    
 
procedure enlever (Fl : in out LISTE; Fe : in INTEGER );

--======================================================================
 End p_liste_ent;
