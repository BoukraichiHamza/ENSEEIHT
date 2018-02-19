
(*------------------------------------------------------------*)
(* Calcul d'une approximation des dérivees                   *)
(* première et seconde d'une fonction en un point            *)
(*------------------------------------------------------------*)

(******************************************************************************)
(*  derive_num : (float -> float) -> float -> float                           *)
(*  calcule une approximation de la dérivée d'une fonction en un point	      *)
(*  Paramètre f :  float -> float, une fonction dérivable		      *)
(*  Paramètre x : float, un point dans l'ensemble de définition de f          *)
(*                et telque x+h soit dans l'ensemble de définition            *)
(*  Résultat : float, la dérivé de f en x                                     *)
(*  Erreur : 			                                              *)
(******************************************************************************)
let derive f x =
   let h = 0.000001            (* pas de calcul de la dérivation *)
   in let deux_h = 2. *. h
      in (f (x +. h) -. f (x -. h)) /. deux_h;;

(******************************************************************************)
(*  derive2nde : (float -> float) -> float -> float                           *)
(*  calcule une approximation de la dérivée seconde d'une fonction en un point*)
(*  Paramètre f : float -> float, une fonction deux fois derivable            *)
(*  Paramètre x : float, un point dans l'ensemble de définition de f          *)
(*                et telque x+h et x+2h soient dans l'ensemble de définition  *)
(*  Résultat : float, la dérivé seconde de f en x                             *)
(*  Erreur : 			                                              *)
(******************************************************************************)
let derive2 f x =
   derive (derive f) x;;

(******************************************************************************)
(* Exemples et test                                                           *)
(******************************************************************************)

let carre x =
   x *. x;;

derive carre 0.;;

derive2 carre 0.;;
