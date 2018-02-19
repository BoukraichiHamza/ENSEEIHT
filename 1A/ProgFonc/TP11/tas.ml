type 'a tas = Vide | Noeud of 'a tas * 'a * 'a tas;;

(* écrire les implémentation des fonctions *)

(*  nom : print_tas
 *  rôle : affiche le tas
 *  paramètres : la procédure d'affiche d'une valeur de type 'a
 *               le tas de valeur du type 'a
 *  résultat : aucun
 *  exemple : si les valeurs aux noeuds sont des entiers :
   *                  print_tas print_int a;;
 *)
let print_tas print_elem a =
  let rec print profondeur = function
      Vide -> ()
    | Noeud(sag, v, sad) -> print (profondeur+2) sad;
                          for i=1 to profondeur
                          do
                            print_char ' '
                          done;
                          print_elem v;
                          print_newline ();
                          print (profondeur+2) sag;
  in print 0 a;;
