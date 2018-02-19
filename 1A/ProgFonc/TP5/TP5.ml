(*Hamza BOUKRAICHI GROUPE H*)

(*Exercice 1*)
(*Définition des objets de tests*)
let pol1 = [3.0;2.0;4.0];;
let pol2 = [4.5;-.3.;0.;5.;6.2];;
let pol3 = [5.0;4.7;0.;0.;-3.7];;

(*Execice 2*)
(*Fonction degree*)
(*Fonction qui retourne le degree d'un polynome*)
(*Type val degree : 'a list -> int = <fun> *)
(*Parametres*)
(* pol : liste qui modélise le polynome*)
(*précondition le dernier terme de la liste est non nul*)
(*type retourné : entier représentant le degrée du polynome*)

let rec degree = fun pol ->
  match pol with 
  | [] -> -1
  | [_] -> 0
  | t::q -> 1+degree(q);;

(*Tests
# degree pol1;;
- : int = 2
# degree pol2;;
- : int = 4
# degree pol3;
- : int = 4*)

(*Exercice 3*)
(*Fonction coeff*)
(*Fonction qui retourne le coefficient de degré i*)
(*type val coeff : 'a list -> int -> 'a = <fun>*)
(*paramètres*)
(*pol : liste représentant le polynome*)
(*i : degré dont le coefficient est recherché*)
(*précondition le dernier terme de la liste est non nul*)
(* i doit etre compris entre 1 et deg pol*)
(*type retourné : flottant représentant le coefficient de degré i du polynome*)

let rec coeff = fun pol i ->
     match i with 
     |0->  List.hd pol
     |_ -> coeff (List.tl pol) (i-1);;

(*Tests
#coeff pol1 1;;
- : float = 2.
#coeff pol2 3;;
- : float = 5.
#coeff pol3 2;;
- : float = 0.*)

(*Exercice 4*)
(*Fonction monome*)
(*Fonction qui retourne le monome X a la puissance n*)
(*Type val monome : int -> int list = <fun> *)
(*parametres*)
(*n : entier : le degrée du monome*)
(*précondition n>=0*)
(*type retourné : liste de n+1 éléments représentant le monome*)

let rec monome = fun n ->
  match n with
  |0->[1]
  |_->0::monome(n-1);;

(*Tests
# monome 5;;
- : int list = [0; 0; 0; 0; 0; 1]
# monome 1;;
- : int list = [0; 1]
# monome 0;;
- : int list = [1]*)

(*Exercice 5*)
(*Fonction evaluate*)
(*Fonction qui evalue un polynome en x*)
(*type val evaluate : float list -> float -> float = <fun> *)
(*Parametres*)
(*Pol : liste representant le polynome à évaluer*)
(*x : flotant : l'élément où le polynome est évalué*)
(*Précondition l'élément de plus haut degrée est non nul*)
(*Type retourné flotant*)

let rec evaluate = fun pol x ->
  match pol with
  |[] -> 0.
  |t::q -> t+.x*.(evaluate q x);;

(*Tests
# evaluate pol1 2.0;;
- : float = 23.
# evaluate pol2 (-1.0);; 
- : float = 8.7
# evaluate pol3 0.;;
- : float = 5.*)

(*Exercice 6*)
(*Fonction extend*)
(*Fonction qui complete un polynome par des zeros jusqu'au degré m*)
(*Type val extend : float list -> int -> float list = <fun> *)
(*Parametres*)
(*m : entier : degrée à atteindre*)
(*pol : liste : polynome à completer*)
(*préconditon m>=degree pol*)
(*Type retourné liste représentant le polynome complété*)

let rec extend = fun pol m ->
  
  let n=degree pol in
  if m<=n then
    pol
  else
    (extend (pol) (m-1))@[0.];;

(*Tests
# extend pol1 7;;
- : float list = [3.; 2.; 4.; 0.; 0.; 0.; 0.; 0.]
# extend pol2 4;;
- : float list = [4.5; -3.; 0.; 5.; 6.2]
# extend pol3 10;;
- : float list = [5.; 4.7; 0.; 0.; -3.7; 0.; 0.; 0.; 0.; 0.; 0.]*)

(*Exercice 7*)
(*Fonction retract*)
(*Fonction qui supprime les coefficients nul après le dernier coefficient non nul*)
(*Type val retract : float list -> float list = <fun> *)
(*Parametres*)
(*Pol : liste : polynome à retracter*)
(*type retourné : liste représentant le polynome rétracté*)

let rec retract = fun pol ->
  match pol with
  |[]-> []
  |t::q -> if t<>0. then t::(retract q)
           else
             let x = (retract q) in
                 if x<> [] then t::(retract q)
                 else
                   [];;

(*Test
(retract [0.; 0.; 3.; 2.; 0.;0.;7.];;
- : float list = [0.; 0.; 3.; 2.; 0.; 0.; 7.]
  retract [1.; 0.; 7.; 0.; 0.];;
- : float list = [1.; 0.; 7.]
  retract [1.; 3.; 4.; 0.; 0.;0.];;
- : float list = [1.; 3.; 4.]*)

(*Exercice 8*)
(*Fonction map*)
(*fonction qui retourne une liste d'évaluation d'une fonction dans les éléments d'une liste*)
(*Paramètres*)
(* f fonction a appliqué*)
(*l liste sur laquelle la fonction est évaluée*)
(*type val map : ('a -> 'b) -> 'a list -> 'b list = <fun> *)
(*précondition les éléments de la liste doivent appartenir à l'ensemble de définition de la fonction*)
(*Type retourné liste formé d'éléments de l'ensemble d'arrivé de f*)

let rec map = fun f l ->
  match l with
  | [] -> []
  | tete::queue -> f(tete)::map f queue;;

(*tests
#map (fun x-> x+1) [];;
- : int list = []
#map (fun x-> x+1) [1;5;9;4;8];;
- : int list = [2; 6; 10; 5; 9]*)

(*Fonction map2*)
(*fonction qui retourne une liste d'évaluation d'une fonction dans les éléments de 2 listes*)
(*Paramètres*)
(* f fonction a appliqué*)
(*l1 1ere liste sur laquelle la fonction est évaluée*)
(*l2 2ieme liste sur laquelle la fonction est évaluée*)
(*type val map2 : (float -> float -> 'a) -> float list -> float list -> 'a list =<fun>*)
(*précondition les éléments des listes doivent appartenir à l'ensemble de définition de la fonction*)
(*Type retourné liste formé d'éléments de l'ensemble d'arrivé de f*)

let rec map2 = fun f l1 l2 ->
  match l1,l2 with
  |[],[] -> []
  |_,[]  -> map (f 0.) l1
  |[],_  -> map (f 0.) l2
  |t1::q1,t2::q2 -> let (a,b)=((extend q1 (degree q2)),(extend q2 (degree q1))) in
                    (f t1 t2)::(map2 f a b);;
(*Tests
map2 (fun x y-> x+.y) pol1 pol2;;
- : float list = [7.5; -1.; 4.; 5.; 6.2
map2 (fun x y -> x*.y) pol1 pol3;;
- : float list = [15.; 9.4; 0.; 0.; -0.]*)

(*Exercice 9*)
(*fonction sacl_mult*)
(*fonction qui multiplie un polynôme par un scalaire*)
(*type val sacl_mult : float -> float list -> float list = <fun>*)
(*Parametres*)
(*k : float : le scalaire à multiplier*)
(*pol : représentant le polynome ou le scalaire sera multiplié*)
(*Postconditions : le polynome retourné a été multiplié par le scalaire*)

let scal_mult = fun k pol ->
  match pol with
  |[] -> []
  |_  -> map (fun x->k*.x) pol;; 
(*Tests
scal_mult 2. pol1;;
- : float list = [6.; 4.; 8.]
scal_mult 1. [];;
- : float list = []
scal_mult (-1.) pol3;;
- : float list = [-5.; -4.7; -0.; -0.; 3.7];;*)

(*Exercice 10*)
(*Fonction plus*)
(*Fonction qui retourne la somme de deux polynomes*)
(*Type val plus : float list -> float list -> float list = <fun>*)
(*Paramètres*)
(*pol1, pol2 : les deux listes à sommer*)
(*Postcondition: la liste retournée représente la somme des deux polynomes*)

let plus = fun pol1 pol2 ->
  map2 (fun x y -> x+.y) pol1 pol2;;

(*Tests
plus pol1 pol2;;
- : float list = [7.5; -1.; 4.; 5.; 6.2]
# plus pol2 pol3;;
- : float list = [9.5; 1.70000000000000018; 0.; 5.; 2.5]*)

(*Fonction minus*)
(*Fonction qui retourne la différence de deux polynomes*)
(*Type val plus : float list -> float list -> float list = <fun>*)
(*Paramètres*)
(*pol1, pol2 : les deux listes à soustraire*)
(*Postcondition: la liste retournée représente la différence des deux polynomes*)

let minus = fun pol1 pol2 ->
  plus pol1 (scal_mult (-1.) pol2);;

(*Tests
minus pol1 pol2;;
- : float list = [-1.5; 5.; 4.; -5.; -6.2]
minus pol2 pol3;;
- : float list = [-0.5; -7.7; 0.; 5.; 9.9]*)


(*Exercice  11*)
(*Fonction mult_monome*)
(*Fonction qui multiplie un polynome par un monome*)
(*Type val mult_monome : 'a -> int -> int list = <fun>*)
(*Parametres*)
(*pol : polynome à multiplier*)
(*n : entier ; degree du monome à multiplier avec le polynome*)
(*Postconditions : le polynome est le monome seront multiplié*)

let rec mult_monome = fun pol n ->
  match n with
  |0 -> pol
  |_ -> 0.::(mult_monome pol (n-1));;

(*Tests
mult_monome pol1 3;;
- : float list = [0.; 0.; 0.; 3.; 2.; 4.]
mult_monome pol3 5;;
- : float list = [0.; 0.; 0.; 0.; 0.; 5.; 4.7; 0.; 0.; -3.7]*)


(*Fonction mult*)
(*Fonction qui multiplie deux polynomes*)
(*Type val mult : float list -> float list -> float list = <fun>*)
(*Parametres*)
(*pol1,pol2 : polynomes à multiplier*)
(*Postconditions : les 2 polynomes  seront multipliés*)

let rec mult =fun pol1 pol2 ->
  match pol1,pol2 with
  |[],[] -> []
  |[],_ ->  []
  |_,[] ->  []
  |_,t::q -> let x=mult pol1 q in
             let y=mult_monome pol1 (degree pol2) in
             let z=scal_mult (coeff pol2 (degree pol2)) y in
             plus z x;;


(*Tests
mult pol1 pol2;;
- : float list =[18.6; 31.; 55.8000000000000043; 55.8000000000000043; 55.8000000000000043;
 37.2; 24.8]
mult pol1 [];;
- : float list = []
mult pol2 pol3;;
- : float list =[-16.6500000000000021; -5.55000000000000071; -5.55000000000000071; -24.05;
 -46.9899999999999949; -30.3399999999999963; -41.44; -41.44; -22.94]*)


(*Exercice 12*)
(*Fonction dérive*)
(*Fonction qui dérive un polynome*)
(*Type val derive : float list -> float list = <fun>*)
(*Paramètres*)
(*pol : polynome à dériver*)
(*Postcondition : le polynome retourné represente la dérivée*)

let derive = fun pol ->
   match pol with
  |[] -> []
  |_-> let rec deriv_deg = fun l deg ->
      match l with
      |[]->[]
      |t::q-> (t*.float_of_int(deg))::(deriv_deg q (deg+1)) in
  List.tl(deriv_deg pol 0);;

(*Tests
derive pol1;;
- : float list = [2.; 8.]
derive pol2;;
- : float list = [-3.; 0.; 15.; 24.8]
derive pol3;;
- : float list = [4.7; 0.; 0.; -14.8]
derive [];;
- : float list = []
derive [4.];;
- : float list = []*)



