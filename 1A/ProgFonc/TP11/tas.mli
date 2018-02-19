type 'a tas;;

(* écrire, en adaptant leur nom, les interfaces des fonctions définies
 * pour les ABG + les 4 fonctions spécifiques aux TAS
 *)

(*  nom : print_tas
 *  rôle : affiche le tas
 *  paramètres : la procédure d'affiche d'une valeur de type 'a
 *               le tas de valeur du type 'a
 *  résultat : aucun
 *  exemple : si les valeurs aux noeuds sont des entiers :
 *                  print_tas print_int a;;
 *)
val print_tas : ('a -> unit) -> 'a tas -> unit;;
