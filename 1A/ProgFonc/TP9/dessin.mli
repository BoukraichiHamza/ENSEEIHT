type dessin;;

type point = float * float;;

(***** les constructeurs abstraits                        *****)

(* Fonction  creer_vide : construit un dessin vide destiné    *)
(* à être affiché dans une fenêtre graphique.                 *)
(* Parametre(s) : 2 int, constituant la taille                *)
(* en x et y de la fenêtre où sera affiché le dessin.         *)
val creer_vide : int -> int -> dessin;;

(***** les accesseurs ou requetes ou selecteurs           *****)

(* Fonction ajouter_segment : ajoute un segment au dessin.    *)
(* Le segment est constitué d'une paire de points extrémités. *)
val ajouter_segment : (point * point) -> dessin -> dessin;;

(***** affichage                                          *****)

(* Fonction dessiner : affiche le contenu d'un dessin dans    *)
(* une fenêtre graphique spécifiée à la création.             *)
(* Les segments sont affichés dans l'ordre d'insertion.       *)
(* Postcondition : un seul dessin peut être affiché à la fois.*)
(* Efface les dessins précédents.                             *)
val dessiner  : dessin -> unit;;

(* Fonction affiche_lentement : affiche un dessin,            *)
(* avec une pause de 1 seconde entre chaque segment pour      *)
(* bien montrer l'ordre d'affichage.                          *)
val dessiner_lentement : dessin -> unit;;
