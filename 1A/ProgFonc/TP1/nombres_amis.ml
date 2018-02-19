(* Regle 1 : choix significatifs des identifiants
   Regle 2 : indentation correcte
   Regle 3 : commentaires
   Regle 4 : tests *)

(*******************)
(* Aucune règle	   *)
(*******************)
let tomate poireau=let rec chou patate=if patate>poireau/2 then 0 else
let onion=succ patate in if poireau mod patate=0 then chou onion
+patate else chou onion in chou 1;;


(*******************)
(* + Règle 1	   *)
(*******************)
let somme_diviseurs n=let rec somme_courante diviseur_courant=if diviseur_courant>n/2
then 0 else let prochain_diviseur=succ diviseur_courant in if n mod diviseur_courant=0 then
somme_courante prochain_diviseur+diviseur_courant else somme_courante prochain_diviseur 
in somme_courante 1;;


(*******************)
(* + Règle 2	   *)
(*******************)
let somme_diviseurs n =
 let rec somme_courante diviseur_courant =
  if diviseur_courant > n / 2
  then 0
  else let prochain_diviseur = succ diviseur_courant
        in if n mod diviseur_courant = 0
           then diviseur_courant + (somme_courante prochain_diviseur)
           else                     somme_courante prochain_diviseur
 in somme_courante 1;;


(*******************)
(* + Règle 3	   *)
(*******************)
(******************************************************************************)
(* somme_diviseurs : int -> int                                               *)
(* calcule la somme des diviseurs d'un entier                                 *)
(* Paramètre n : int, l'entier, positif ou null,                              *)
(*               dont on veut calculer la somme des diviseurs                 *)
(* Résulat : int, la somme des diviseurs de n compris entre 1 et n-1 inclus.  *)
(*           Ces diviseurs sont comptés une seule fois.                       *)
(* Erreur :                                                                   *)
(******************************************************************************)
let somme_diviseurs n =
                             (* fonction de parcours des diviseurs potentiels *)
 let rec somme_courante diviseur_courant =
  if diviseur_courant > n / 2    (* arrêt : aucun diviseur n'est > n/2        *)
  then 0
  else let prochain_diviseur = succ diviseur_courant 
        in if n mod diviseur_courant = 0      (* on teste le diviseur courant *)
           then diviseur_courant + (somme_courante prochain_diviseur)
           else                     somme_courante prochain_diviseur
 in somme_courante 1;;


(*******************)
(* + Règle 4	   *)
(*******************)
(******************************************************************************)
(* somme_diviseurs : int -> int                                               *)
(* calcule la somme des diviseurs d'un entier                                 *)
(* Paramètre n : int, l'entier, positif ou null,                              *)
(*               dont on veut calculer la somme des diviseurs                 *)
(* Résulat : int, la somme des diviseurs de n compris entre 1 et n-1 inclus.  *)
(*           Ces diviseurs sont comptés une seule fois.                       *)
(* Erreur :                                                                   *)
(******************************************************************************)
let somme_diviseurs n =
                             (* fonction de parcours des diviseurs potentiels *)
 let rec somme_courante diviseur_courant =
  if diviseur_courant > n / 2    (* arrêt : aucun diviseur n'est > n/2        *)
  then 0
  else let prochain_diviseur = succ diviseur_courant 
        in if n mod diviseur_courant = 0      (* on teste le diviseur courant *)
           then diviseur_courant + (somme_courante prochain_diviseur)
           else                     somme_courante prochain_diviseur
 in somme_courante 1;;


(******************************************************************************)
(*  Tests :    
  somme_diviseurs 0 = 0;;
  somme_diviseurs 1 = 0;;
  somme_diviseurs 29 = 1;; 
  somme_diviseurs 28 = 28;; 
  somme_diviseurs 27 = 13 ;;                                                  *)
(******************************************************************************)


(*******************)
(* En complément   *)
(*******************)
(******************************************************************************)
(* sont_amis : int -> int -> bool                                             *)
(* Détermine si deux nombres sont amis                                        *)
(* Paramètre m : int, un entier positif ou nul                                *)
(* Paramètre n : int, un entier positif ou nul                                *)
(* Résultat : bool, teste si m et n forment une paire de nombre amis.         *)
(*       La somme des diviseurs de n doit être égale à m, et réciproquement.  *)
(* Erreur :                                                                   *)
(******************************************************************************)

let sont_amis m n =
 somme_diviseurs n = m && somme_diviseurs m = n;;

(******************************************************************************)
(*  Tests :
  not (sont_amis (-28) (-28));;
  sont_amis 0 0;; 
  not (sont_amis 1 1);;
  sont_amis 28 28;;
  sont_amis 220 284;;
  not (sont_amis 28 29);;                                                     *)
(******************************************************************************)
