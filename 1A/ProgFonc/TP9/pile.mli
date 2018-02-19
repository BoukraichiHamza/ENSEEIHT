(***** le type abstrait = pas de definition *****)
type 'a pile ;;

(***** les constructeurs abstraits *****)

(* Fonction  creer_vide : construit la pile vide         
   type : unit -> 'a pile
   parametre(s) : ()
   resultat : une pile
   precondition : aucune
   postcondition : le résultat est une pile vide
   erreur : aucune *)
val creer_vide : unit -> 'a pile ;;

(***** les accesseurs ou requetes ou selecteurs *****)

(* Fonction  est_vide : teste si la pile est vide
   type : 'a pile -> bool
   parametre(s) : une pile
   resultat : l'indication booleenne que la pile est vide
   precondition : aucune
   postcondition : aucune
   erreur : aucune *)
val est_vide : 'a pile -> bool ;;

(* Fonction empiler : ajoute un element en sommet de pile
   type : 'a -> 'a pile -> 'a pile
   parametre(s) : une element et une pile
   resultat : une pile avec element en sommet
   precondition : aucune
   postcondition : la pile resultat n'est pas vide
   erreur : aucune *)
val empiler : 'a -> 'a pile -> 'a pile  ;;

(***** les destructeurs *****)

(* Fonction depiler : enleve un element en sommet de pile
   type : 'a pile -> 'a * 'a pile
   parametre(s) : une pile
   resultat : un couple constitue du sommet de la pile initiale
              et de la pile initiale privee de son sommet
   precondition : la pile n'est pas vide
   postcondition : aucune *)
val depiler : 'a pile -> 'a * 'a pile   ;;
