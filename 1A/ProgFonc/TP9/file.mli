(***** le type abstrait = pas de definition *****)
type 'a file ;;

(***** les constructeurs abstraits *****)

(* Fonction  creer_vide : construit la file vide         
   type : unit -> 'a file
   parametre(s) : ()
   resultat : une file
   precondition : aucune
   postcondition : le résultat est une file vide
   erreur : aucune *)
val creer_vide : unit -> 'a file ;;

(***** les accesseurs ou requetes ou selecteurs *****)

(* Fonction  est_vide : teste si la file est vide
   type : 'a file -> bool
   parametre(s) : une file
   resultat : l'indication booleenne que la file est vide
   precondition : aucune
   postcondition : aucune
   erreur : aucune *)
val est_vide : 'a file -> bool ;;

(* Fonction enfiler : ajoute un element en queue de file
   type : 'a -> 'a file -> 'a file
   parametre(s) : une element et une file
   resultat : une file avec element en dernier position
   precondition : aucune
   postcondition : la file resultat n'est pas vide
   erreur : aucune *)
val enfiler : 'a -> 'a file -> 'a file  ;;

(***** les destructeurs                                  *****)

(* Fonction defiler : enleve un element en tete de file
   type : 'a pile -> 'a * 'a file
   parametre(s) : une file
   resultat : un couple constitue de la tete de la file initiale et
              et de la file initiale privee de sa tete
   precondition : la file n'est pas vide
   postcondition : aucune *)
val defiler : 'a file -> 'a * 'a file   ;;
