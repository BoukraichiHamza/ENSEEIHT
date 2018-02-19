(*HAMZA BOUKRAICHI GROUPE H*)
(*TRI*)

let l1 = [2;3;4;-2;1;2;-5;6;7;-8;9];;

(*EXERCICE 1*)
(*Fonction tri_insert_el*)
(*Fonction qui insére un élément selon un ordre dans le 3ieme argument qui est une liste*)
(*Type : val tri_insert_el : ('a -> 'a -> bool) -> 'a list -> 'a -> 'a list = <fun> *)
(*paramètres*)
(*ordre : fonction selon laquelle la liste sera triée*)
(*l : la liste où l'élément sera inséré*)
(*x : l'élément à insérer dans la liste*)
(*Préconditions : la liste doit être triée*)
(*Postconditions : la liste retournée est triée et l'élément est bien insérée*)

let rec tri_insert_el = fun f l x ->
  match l with
  |[] -> [x]
  |t::q -> if f x t then
             x::t::q
           else
             t::(tri_insert_el f q x);;

(*Tests
# tri_insert_el (<=) [1;3] 2;;
- : int list = [1; 2; 3]
# tri_insert_el (<=) ['e';'h'] 'f';;
- : char list = ['e'; 'f'; 'h']
# tri_insert_el (<=) [1;2;3;5;6] 4;;
- : int list = [1; 2; 3; 4; 5; 6]*)

(*Exercice 2*)
(*Fonction tri_insert*)
(*Fonction qui trie une liste selon un ordre*)
(*Type val tri_insert : ('a -> 'a -> bool) -> 'a list -> 'a list = <fun> *)
(*Paramètres*)
(*l : liste à trier*)
(* f : Ordre d'après lequel la lettre sera triée*)
(*Postcondition la liste retournée est triée*)

let rec tri_insert = fun f l ->
  match l with
  |[] -> []
  |t::q -> tri_insert_el f (tri_insert f q) t;;

tri_insert (<=) l1;;

(*Tests
# tri_insert (<=) [5;7;6;1;0;9;8];;
- : int list = [0; 1; 5; 6; 7; 8; 9]
# tri_insert (<=) ["dictionnaire";"television";"abricot";"internet"];;
- : string list = ["abricot"; "dictionnaire"; "internet"; "television"]*)

(*Exercice 3*)
(*fonction decompse*)
(*Fonction qui decompose une liste en deux parties selon un prédicat*)
(*Type  *)
(*Paramètres*)
(* p : prédicat qui permet de différencier les éléments de la liste*)
(* l : liste à décomposer*)
(*postcondition : les deux listes retournées sont formées selon le prédicat*)

let rec decompose = fun p l ->
  match l with
  |[] -> ([],[])
  |t::q -> let (q1,q2) = decompose p q in
                              if p t then (t::q1,q2)
                            else
                                 (q1,t::q2);;
(*Test*)
(*decompose (fun x -> (<=) 0 x) l1;;
- : int list * int list = ([2; 3; 4; 1; 2; 6; 7; 9], [-2; -5; -8])*)

(*Exercice 4*)
(*fonction tri_rapide*)
(*Fonction qui réalise*)
(*Type  *)
(*Paramètres*)
(* l : liste à trier*)
(*postcondition : la liste retournée est triée*)

let rec tri_rapide = fun l ->
  match l with
  |[] -> 

