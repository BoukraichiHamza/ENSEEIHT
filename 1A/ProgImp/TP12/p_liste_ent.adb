--======================================================================

--Hamza BOUKRAICHI GROUPE H
--Paquetage Liste entier
--======================================================================
With text_io;  
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
--======================================================================
 Package Body p_liste_ent is
 
----------------------Declarations des opérations-----------------------
--======================================================================
 
--fonction créeer_liste_vide
--sémantique: créer une liste vide
--paramétres: aucun
--type retour: liste
--pré-condition: aucune
--post-condition: est_vide (l) vaut vrai
--exception: aucune

 function creer_liste_vide   return LISTE is
   Begin
     Return (null);
   End creer_liste_vide;

 --=====================================================================
--fonction est_vide
--Semantique: teste si une liste l est vide
--parametres: Fl donnee type liste
--type retour: booleen
--pre-condition: aucune
--post-condition: aucune
--exception: aucune
   
 function est_vide (Fl : in LISTE) return boolean is
 Begin 
   Return (Fl=null);
 End est_vide;

 --=====================================================================
--procedure inserer_en_tete
--semantique: insere l'element nouveau en tete de la liste l
--(l vide ou non vide)
--parametres: Fl donnee/resultat type liste
--Fnouveau donnee type entier
--pre-condition: aucune
--post-condition: nouveau appartient a la liste
--exception: aucune
 
 Procedure inserer_en_tete ( Fl: in out LISTE; Fnouveau : in INTEGER) is
 pins:LISTE; 
   Begin
     pins:=NEW NOEUD;
     pins.all.val:=Fnouveau;
     pins.all.SUIVANT:=Fl;
     Fl:=pins;
   End inserer_en_tete;

 --=====================================================================
--procedure afficher_liste
--semantique: afficher les elements de la liste l
--parametres: Fl donnee type liste
--pre-condition: aucune
--post-condition: aucune
--exception: aucune

  Procedure afficher_liste ( Fl : in LISTE) is
    Begin 
      If Fl=null then
	New_Line;
      Else
	Put(Fl.all.VAL,0);
	Put('|');
	afficher_liste(Fl.all.SUIVANT);
      End If;
    End afficher_liste;

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

    function rechercher (Fl : in LISTE; Fe : in INTEGER) Return LISTE is
      pcour:LISTE:=Fl;
    Begin
      While pcour/=Null and then pcour.all.VAL/=Fe Loop
	pcour:=pcour.all.SUIVANT;
      End loop; --pcour=Null ou pcour.all.VAL=Fe
      Return pcour;
    End rechercher;

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
  Fdata : IN INTEGER) is
 pdata:Liste;
 pnouveau:Liste; 
 Begin
   pdata:=rechercher(Fl,Fdata);
   If pdata=NULL 
       then inserer_en_tete (Fl,Fnouveau);
   else
   pnouveau:=New NOEUD;
   pnouveau.all.val:=Fnouveau;
   pnouveau.all.suivant:=pdata.all.suivant;
   pdata.all.suivant:=pnouveau; 
   End if;
 End inserer_apres;

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
 Fdata : IN INTEGER) is
  pcour:Liste:=Fl;
  pnouveau:Liste;
Begin
  If Fl=Null then
    inserer_en_tete(Fl,Fnouveau);
  Else
     If Fl.all.val=Fdata Then
       inserer_en_tete(Fl,Fnouveau);
     Else
    While pcour.all.suivant/=Null and then 
    pcour.all.suivant.all.val /= Fdata Loop
      pcour:=pcour.all.suivant;
    End Loop;
    If pcour.all.suivant=Null
     Then
       inserer_en_tete(Fl,Fnouveau);
    Else
    pnouveau:=New NOEUD;
    pnouveau.all.val:=Fnouveau;
    pnouveau.all.suivant:=pcour.all.suivant;
    pcour.all.suivant:=pnouveau;
    End if;
  End if;
 End if;
End inserer_avant;


 --=====================================================================
--procedure enlever
--semantique: enlever un element e de la liste l (liste vide ou non vide)
--parametres: l donnee/resultat type liste
--e donnee type entier
--pre-condition: aucune
--post-condition: e n'appartient pas a la liste
--exception: aucune    
 
procedure enlever (Fl : in out LISTE; Fe : in INTEGER ) is
  pcour:LISTE;
  Begin
  pcour:=Fl;
  If Fl=Null then
    Null;
    Else
      While pcour.all.suivant/= Null 
      and then pcour.all.suivant.all.val /= Fe Loop
      pcour:=pcour.all.suivant;
      End Loop;
    If pcour=Null then
      Null;
    else
      pcour.all.suivant:=pcour.all.suivant.all.suivant;
    End if;
   End if;
  End enlever;
   
 --=====================================================================
End p_liste_ent;
