
# #use "derivation.ml";;
val derive : (float -> float) -> float -> float = <fun>
val derive2 : (float -> float) -> float -> float = <fun>
val carre : float -> float = <fun>
- : float = 0.
- : float = 2.
(*Test des différentes fonctions*)
# derive carre 2.0;;
- : float = 4.00000000011502266
# derive2 carre 2.0;;


(*Exercise 1*)
# let un_entier = 160895;;
val un_entier : int = 160895
# let un_reel = 3.14159;;
val un_reel : float = 3.14159
# let une_chaine = "OCaML";;
val une_chaine : string = "OCaML"
# let un_entier = "N7";;        
val un_entier : string = "N7"
# let un_reel = "Toulouse";;
val un_reel : string = "Toulouse"


(*Exercice 2*)
# let x=2*8+3 in let y=5-3*7 in x*(8*2+5*y);;
- : int = -1216
# let x=3*4-2 in let y=4*3-2 in let z=4*3-2 in x+(4*y-5)*z;;  
- : int = 360


(*Exercice 3*)
# let x=5;;
val x : int = 5
# x;;
- : int = 5
# let x=2 in x+3;;
- : int = 5
# x;;
- : int = 5
# let x=3;;
val x : int = 3
# x;;
- : int = 3


(*Exercice 4*)
(*fonction qui retourne le coefficient directeur d'une droite à partir des coordonnées de deux points*)
(*int * int -> int * int -> int = <fun>*)
(*x1 <> x2 pour éviter la division par zéro*)
#let coeff_droite = fun (x1,y1)(x2,y2) ->
  if x1<>x2 then   (y2-y1)/(x2-x1)
  else failwith "le coefficient directeur de la droite est infini";;
(*Test
 * # coeff_droite (2,3)(3,4);;
- : int = 1
# coeff_droite (5,4)(5,7);;
Exception: Failure "le coefficient directeur de la droite est infini".*)


(*Exercice 5*)
(*fonction qui calcule les racines d'un polynome de degré 2*)
(*type float * float * float -> float * float = <fun>*)
(*si a nul alors il y a une racine simple*)
let rac2 = fun (a,b,c) ->
  let delta = b*.2.0 -.a-.c in (* Calcul du discriminant*)
  if a=0.0 then ((-.c/.b),(-.c/.b)) else
  if delta < 0.0 then failwith " pas de racines reelles"
 else if delta = 0.0 then ((-.b/.(2.0*.a)),(-.b/.(2.0*.a)))
  else  ((sqrt(delta)-.b)/.(2.0*.a),(-.sqrt(delta)-.b)/.(2.0*.a));;
(*Test
 * # rac2(5.,3.,2.);;
Exception: Failure " pas de racines reelles".
# rac2(1.,2.,1.);;
- : float * float = (-0.292893218813452427, -1.70710678118654746)
# rac2(0.,1.,1.);;
- : float * float = (-1., -1.)*)


(*Exercice 6*)
(*Fonction qui teste si x est superieur à y*)
(*Type int * int -> bool = <fun>*)
let plus_grand ((x,y):int*int) =  x>=y;;
(*Test*)
(*# plus_grand (5,7);;
- : bool = false *)

(*fonction qui teste la positivité d'un entier*)
(*Type int -> bool = <fun>*)
let positif x = x>=0;;
(*Test
# positif 5;;
- : bool = true *)

(*fonction qui retourne le même éléments*)
(*type 'a -> 'a = <fun>*)
let identite = fun x -> x;;

(*fonction qui teste l'égalité des coordonnées d'un point*)
(*type 'a * 'a -> bool = <fun>*)
let test_egal =fun (x,y) -> x=y;;
(*Test
# test_egal (5,4);;
- : bool = false *)

(*Fonction qui retourne la première coordonnée d'un point*)
(*Type 'a * 'b -> 'a = <fun>*)
let premiere_coord = fun (x,y) -> x;;
(*Test 
# premiere_coord (3,-2);;
- : int = 3 *)


(*Exercice 7*)
(*Fonction qui retourne la iéme composante d'un triplet*)
(*Type ('a * 'a * 'a) * int -> 'a = <fun>*)
(* i compris entre 1 et 3*)
let coord_trip = fun ((a,b,c),i) -> 
  match i with 
  | 1 -> a
  | 2 -> b
  | 3 -> c
  | _ -> failwith "i doit etre compris entre 1 et 3";;
(*Test
# coord_trip ((1.,2.4,7.2),3);;
- : float = 7.2
# coord_trip ((0.2,-.3.,5.4),4);;
Exception: Failure "i doit etre compris entre 1 et 3".*)
