(*BOUKRAICHI Hamza Groupe H*)

(*Exercice 1*)
(*Fonction test_list*)
(*Fonction qui teste si un élément appartient à une liste*)
(*type val test : 'a -> 'a list -> bool = <fun>*)
(*Parametres*) 
(* x de type quelconque noté alpha qui est l'élément recherché*)
(* l une alpha liste*)
(*précondition x est de même type que les éléments de la liste*)
(*Type retourné booléen*)
let rec test_list = fun x l ->
  match l with 
  |[] -> false
  |tete::queue->  tete=x || test_list x queue;;
(*Tests
# test 4 [5;6;7;8];;
- : bool = false
# test 5 [5;6;7;8];;
- : bool = true*)

(*Exercice 2*)
(*Fonction trans_ensemble*)
(*Fonction qui transforme une liste en ensemble en éliminant les doublons*)
(*Type val trans_ensemble : 'a list -> 'a list = <fun> *)
(*Parametres*)
(* l de type liste qui est la liste à transformer en ensemble*)
(*type retourné liste*)
(*postcondition la liste finale ne contient pas de doublons*)

let rec trans_ensemble = fun l ->
  match l with 
  |[] -> []
  |tete::queue -> if test_list tete queue then trans_ensemble queue 
                  else
                    tete::trans_ensemble queue;;
                    
(*Tests
#trans_ensemble [4; 6; 78; 4; 9; 5; 4; 5; 1; 6; 4; 7; 6; 8; 12; 9];;
- : int list = [78; 5; 1; 4; 7; 6; 8; 12; 9]
#trans_ensemble [1;2;3;4;5;6;7;8;9;1;2;3;4;5;6;7;8;9];;
- : int list = [1; 2; 3; 4; 5; 6; 7; 8; 9]
#trans_ensemble [true;true;false];;
- : bool list = [true; false];;*)

(*Exercice 3*)
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

(*Exercice 4*)
(*Fonction ajout_ens*)
(*Fonction qui ajoute un élément à un ensemble*)
(*type val ajout_ens : 'a -> 'a list -> 'a list = <fun> *)
(*parametres*)
(*x de type quelconque noté alpha éléments à ajouter*)
(*l une alpha liste (ne contenant pas de doublons)*)
(*précondition x doit être de même type que les éléments de la liste*)
(*type retourné : liste ne contenant pas de doublons*)

let ajout_ens = fun x l ->
  match l with
    |[]-> [x]
    |tete::queue-> if test_list x l then tete::queue
                   else
                     x::tete::queue;;
(*Tests
#ajout_ens 4 [1;2;3];;
- : int list = [4; 1; 2; 3]
#ajout_ens 4 [1;2;3;4];;
- : int list = [1; 2; 3; 4]
#ajout_ens true [];;
- : bool list = [true]*)


(*Exercice 5*)
(*Fonction union_ens*)
(*Fonction qui retourne l'union de deux ensembles*)
(*Type val union_ens : 'a list -> 'a list -> 'a list = <fun> *)
(*parametres*)
(*l alpha liste*)
(*l' alpha liste*)
(*les listes dont l'union sera retourné*)
(*préconditions les listes doivent contenir des éléments de même type*)
(*type retourné liste ne contenant pas de doublons*)

let rec union_ens = fun l l' ->
  match l with
  | [] -> l'
  | tete::queue -> union_ens queue (ajout_ens tete l');; 

(*Tests
# union_ens [] [1;2];;
- : int list = [1; 2]
# union_ens [1;3;4;5;7;8;9] [1;2;3;4;5;6;7];;
- : int list = [9; 8; 1; 2; 3; 4; 5; 6; 7]*)


(*Exercice 6*)

(*Fonction rmv_ens*)
(*fonction qui retire un élément à un ensemble*)
(*type val rmv_ens : 'a -> 'a list -> 'a list = <fun> *)
(*parametres*)
(* x de type alpha : éléments à retirer*)
(*l de type alpha list : l'ensemble duquel l'élément doit être retiré*)
(*précondion x doit être de même type que les éléments de la liste*)
(*type retourné alpha liste : ensemble duquel l'élément a été retiré*)

let rec rmv_ens = fun x l ->
  match l with 
  |[] -> []
  |tete::queue -> if tete=x then queue
                 else
                   tete::(rmv_ens x queue);;
(*tests
# rmv_ens 4 [];;
- : int list = []
# rmv_ens 4 [1;2;3;4;5];;
- : int list = [1; 2; 3; 5]
# rmv_ens 4 [1;2;3];;
- : int list = [1; 2; 3]*)

(*Exercice 7*)

(*fonction diff_ens*)
(*fonction qui retourne la différence de deux ensembles*)
(*type val diff_ens : 'a list -> 'a list -> 'a list = <fun> *)
(*paramètres*)
(*l : alpha liste*)
(*l' : alpha liste*)
(* représentant les deux ensembles dont la différence sera retournée*)
(*préconditon l et l' doivent contenir des éléments de même type*)
(*type retourné alpha liste représentant la différence ensembliste de l et l'*)
 let rec diff_ens = fun l l' ->
   match l' with 
   |[] -> l
   |tete::queue -> if test_list tete l then diff_ens (rmv_ens tete l) queue
                   else
                     tete::diff_ens l queue;;
(*tests
# diff_ens [1;2] [];;
- : int list = [1; 2]
# diff_ens [1;2;3;4;5;6;7;8;9] [1;3;5;7;9];;
- : int list = [2; 4; 6; 8]*)

(*Exercice 8*)

(*fonction image_of*)
(*fonction qui calcule l'image d'une fonction sur un ensemble*)
(*type  val image_of : ('a -> 'b) -> 'a list -> 'b list = <fun> *)
 * (*paramètres*)
(* f : fonction : la fonction a appliqué sur l'ensemble*)
(*l : l'ensemble sur lequel la fonction sera appliquée*)
(*préconditions les éléments de l doivent appartenir à l'ensemble de définition de f*)
(*type retourné : une liste d'éléments appartenant à l'ensemble d'arrivé de f*)

 let rec image_of = fun f l ->  trans_ensemble(map f l);;

(*Tests
# image_of (fun x->x*x) [1;2;3];;
- : int list = [1; 4; 9]
# image_of (fun x->x*x) [];;
- : int list = []
# image_of (fun x->x*x) [-1;0;1];;
- : int list = [0; 1]*)

(*Exercice 9*)/(*Exercice 10*)

(*fonction union_indexee*)
(* fonction qui retourne l'ensemble représentant l'union de plusieurs ensembles considérés*)
(*type val union_indexee : 'a list list -> 'a list = <fun> *)
(*parametres*)
(*l : liste d'alpha liste : contenant les ensembles considérés*)
(*préconditions : tous les ensembles doivent contenir des éléments de même type*)
(*type retourné alpha liste : représentant l'union des ensembles*)

 let rec union_indexee = fun l ->
   match l with 
   |[] -> []
   |tete::queue -> union_ens tete (union_indexee queue);; 

(*Tests
# union_indexee [];;
- : 'a list = []
# union_indexee [[1;3;2];[1;4;3];[];[2;5;6]];;
- : int list = [3; 4; 1; 6; 5; 2]*)




