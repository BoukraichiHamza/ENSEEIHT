--======================================================================

--Hamza BOUKRAICHI GROUPE H
--Programme de Test Paquetage Liste
--======================================================================
With text_io;  
use text_io;
with ada.integer_text_io;
use ada.integer_text_io;
With p_liste_ent;
Use p_liste_ent;
------------------------------------------------------------------------

------------------------------------------------------------------------
Procedure test_liste is
------------------------------------------------------------------------
--======================================================================
----------------------Declarations des variables------------------------
 l:LISTE;
 prec:LISTE; --liste de recherche
 vide:Boolean; 
--======================================================================
--======================================================================
----------------------Programme Principal-------------------------------
Begin
 l:=creer_liste_vide;
 vide:=est_vide(l);
 Put(Boolean'image(vide));
 New_Line;
 afficher_liste(l);

 For i in 1..5 Loop
 inserer_en_tete(l,5-i);
 afficher_liste(l);
 vide:=est_vide(l);
 New_Line;
 Put(Boolean'image(vide));
 New_Line;

 End loop;
 For i in 1..5 Loop
 prec:=rechercher(l,5-i);
 afficher_liste(prec);
 End loop;
 prec:=rechercher(l,6);
 vide:=est_vide(prec);
 Put(Boolean'image(vide));
 New_Line;

inserer_avant(l,5,4);
afficher_liste(l);
inserer_apres(l,5,4);
afficher_liste(l);
enlever(l,5);
afficher_liste(l);
enlever(l,5);
afficher_liste(l);

End test_liste;


------------------------------------------------------------------------
--======================================================================
