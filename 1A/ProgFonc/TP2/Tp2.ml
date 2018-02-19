(*Exercice 1*)

(*Fonction qui calcule l'inverse d'un nombre rationnel*)
(*Type :int * int -> int * int = <fun>*)
(*un rationnel est représenté par une paire (p,q)*)
(*Le resultat retourné est un rationnel : l'inverse en question*)

let inverse_ratio (p,q):int*int = (q,p);;

(*Test
inverse_ratio(2,3);;
- : int * int = (3, 2)*)

(*Fonction qui calcule l'addition de 2 nombres rationnels*)
(*Type :int * int -> int * int -> int * int = <fun>*)
(*2 rationnels représentés sous formes de paires*)
(*le resultat retourné est un rationnel : la somme*)

let somme_ratio = fun (p1,q1)(p2,q2) ->
  (p1*q2+p2*q1,q1*q2);;

(*Test
somme_ratio(4,3)(5,2);;
- : int * int = (23, 6) *)

(*Exercice 2*)

(*fonction qui calcule la factorielle d'un entier*)
(*n>=0*)
(*type:int -> int = <fun> *)

let rec fact = fun n ->
  if n=0 then 1
  else n*fact(n-1);;

(*Test # fact 2;;
- : int = 2
# fact 20;;
- : int = 2432902008176640000*)
(*La fonction termine pour des valeurs de n positives puisque les valeurs de n diminiuent jusqu'à 0 qui est un cas terminal*)
(*La compléxité est linéaire O(n)=n*)

(*Exercice 3*)

(*fonction qui calcule la somme des carrés des entiers inférieurs ou egaux à un entier défini*)
(*n>=0*)
(*type:int -> int = <fun> *)
let rec carre = fun n -> 
  if n = 0 then 0 else
    n*n + carre(n-1);;
(*Equation de compléxité C(n)=2 + C(n-1) donc compléxité O(n)=2n*)
(*La fonction termine car la valeur de n diminue progressivement vers 0 qui est un cas terminal*)

(*Test # carre 5;;
- : int = 55*)

(*Exercice 4*)

(*fonction qui calcule le pgcd de 2 entiers*)
(*Type int -> int -> int = <fun>*)
(*a et b >=0*)

let rec pgcd = fun a b -> 
  if a=b then a else
    if a>b then pgcd (a-b) b else
      pgcd a (b-a);;

(*variante pour calculer le pgcd d'entier relatif*)
let pgcd_z a b= pgcd (abs a)(abs b);;

(*Test
# pgcd_z 7 (-12);;
- : int = 1
# pgcd 5 10;;
- : int = 5*)

(*Exercice 5*)
(*fonction qui calcule le nieme terme de la suite de Padovan*)
(*Type int -> int = <fun>*)
(*n>=0*)

let rec padovan = fun n ->
  match n with
  |0->0
  |1->0
  |2->1
  |_->padovan(n-2)+padovan(n-3);;

(*Test
# padovan 17;;
- : int = 28 *)
(*Equation de compléxité C(0)=C(1)=C(2)=0 et C(n)=1+C(n-2)+C(n-3)*)

 
(*Exercice 6*)
(* Fonction qui calcule les coefficients binominaux (k,n)*)
(*Type int * int -> int = <fun>*)
(*k et n >= 0 et k<n*)
let rec coeff_bin = fun (k,n) -> 
  if (k,n) = (0,0) then 1 else 
    if n = 0  then 0 else
      if k>n then 0 else
      coeff_bin(k-1,n-1) + coeff_bin(k,n-1);;
(*Equation de compléxité C(0,0)=0 et C(k,n)=C(k-1,n-1)+C(k,n-1)+1*)

(*Variante non recursive avec l'appel de la fonction fact*)
let coeff_bin2 = fun (k,n) -> 
  if k>n then  0  else
    fact(n)/(fact(k)*fact(n-k));;

(*Test
# coeff_bin (1,3);;
- : int = 3
* # coeff_bin2 (2,3);;
- : int = 3
# coeff_bin2 (3,2);;
Exception: Failure "n doit etre superieur a k".*)

(*Exercice 7*)
(*fonction qui test si un entier est premier*)
(*n: entier*)
(* le resulat retourné est un booléen*)
let premier n = 
  if n=1 then failwith"1 n'est pas un nombre premier"
  else 
    let racine=int_of_float(sqrt(float_of_int n)) in
    let rec pas_de_diviseur n p = 
      if p>racine+1 then true else
        if n mod p =0 then false
        else pas_de_diviseur n (p+1) in
    pas_de_diviseur n 2;;
(*Test
# premier 17;;
- : bool = true
# premier 21;;
- : bool = false *)
     

(*Exercice 8*)
(*fonction qui determine le zero d'une fonction par dichotomie*)
(*parametres f fonction donnée
( * a et b les valeurs délimitant le segment*)
(*type retourné est un flottant représentant le zero de la fonction*)
(*précondition f définie sur (a,b)*)
let epsilon=0.0001;; 
let rec zero = fun f (a,b) ->
  let m=(a+.b)/.2.0 in
  if b-.a < epsilon then a else
    if f(m)=0.0 then m else
    if f(a)*.f(m)<0.0 then zero f (a,m)
    else zero f (m,b);;
(*Test*)
let f = fun x ->x+.3.;;
let g = fun x -> x*.x*.x +. 4.;;
zero f (-.5.,-.2.);;
zero g (-.2.,0.);;
(*val f : float -> float = <fun>
# val g : float -> float = <fun>
# - : float = -3.000030517578125
# - : float = -1.58740234375*)


  

