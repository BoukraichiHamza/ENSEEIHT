(*Hamza BOUKRAICHI Groupe H*)
(*Programme Combinatoire*)

(*Exercice 1*)

(*Fonction gray*)
(*Fonction qui engendre un code de gray à n bits*)
(*Type val gray : int -> int list list = <fun>*)
(*Paramètres*)
(*n : entier; nombre de bits du code de gray*)
(*Préconditions : n>=0*)
(*Type retourné : liste de liste d'entier*)

let rec gray = fun n ->
  match n with
  |0 -> [[]]
  |_ -> let x=gray(n-1) in 
        let f1 l = 1::l in
        let f0 l = 0::l in  
  (List.map f0 x)@(List.map f1 (List.rev(x)));;   

(*Tests*)
gray 3;;
(*- : int list list =[[0; 0; 0]; [0; 0; 1]; [0; 1; 1]; [0; 1; 0]; [1; 1; 0]; [1; 1; 1]; [1; 0; 1];
 [1; 0; 0]]*)
gray 0;;
(*- : int list list = [[]]*)

(*Exercice 2*)
(*Fonction combinaison*)
(*Fonction qui retourne une liste des combinaisons de k éléments parmi les éléments de l*)
(*Type int -> 'a list -> 'a list list = <fun> *)
(*Paramètres*)
(*k : entier : nombre de paramètres à combiner*)
(*l : la liste à combiner*)
(*Précondition 0<=k<=taille(l)*)
(*Type retourné liste de liste d'entier*)

let rec combinaison = fun k l ->
  let n=List.length(l) in
  match n,k with
  |_,0 -> [[]]
  |0,_ -> []
  |_,_ -> match l with
          |[] -> []
          |t::q-> (List.map (fun l'->t::l') (combinaison (k-1) q) )@(combinaison k q);;

(*Tests*)
combinaison 2 [1;2;3];;
(*- : int list list = [[1; 2]; [1; 3]; [2; 3]]*)
combinaison 0 [];;
(*- : 'a list list = [[]]*)

(*Exercice 3*)
(*Fonction insertion_partout*)
(*Fonction qui renvoie la liste des insertions à toutes les positions possibles d'un éléments dans une liste*)
(*Type val insertion_partout : 'a -> 'a list -> 'a list list = <fun> *)
(*Paramètres*)
(*k : entier;  l'entier à inserer*)
(*l : la liste ou l'entier sera inséré*)
(*type retourné liste de liste des insertions*)

let rec insertion_partout = fun k l ->
  match l with
  |[] -> [[k]]
  |t::q ->   (k::l)::((List.map (fun x -> t::x) (insertion_partout k q)));;

(*Tests*)
insertion_partout 4 [1;2;3];;
(*- : int list list = [[4; 1; 2; 3]; [1; 4; 2; 3]; [1; 2; 4; 3]; [1; 2; 3; 4]]*)
insertion_partout 3 [];;
(*- : int list list = [[3]]*)

(*Exercice 4*)
(*Fonction permutation*)
(*Fonction qui retourne la liste des permutations d'une liste*)
(*Type val permutation : 'a list -> 'a list list = <fun>*)
(*Paramètres*)
(*l : liste d'entier : à permuter*)
(*type retourné : liste de liste d'entier*)

let rec permutation = fun l ->
  match l with
  |[] -> [[]]
  |t::q -> List.flatten (List.map (insertion_partout t) (permutation q));;

(*Tests*)
permutation [1;2;3];;
(*- : int list list =[[1; 2; 3]; [2; 1; 3]; [2; 3; 1]; [1; 3; 2]; [3; 1; 2]; [3; 2; 1]]*)
permutation [];;
(*- : 'a list list = [[]]*)

(*Exercice 5*)
(*Fonction partition*)
(*Fonction qui retourne la liste des décomposition possible d'un entier en somme d'entiers*)
(*Type : val partition : int -> int list list *)
(*Parametres : n : entier à partitionner*)
(*Précondition n>0*)
let rec partition = fun n ->
   let rec recpart = fun n acc m k ->
    match  m,k with
    |n,0 -> acc
    |0,k -> acc
    |m,k->let l=partition (m) in 
            if (m=k)||abs(m-k)=1 then
            [[k;m]] @ acc
            else if m>k then 
              match l with
              |[] -> acc              
              |t::q ->  recpart n ((List.map (fun liste ->k::liste) l)@acc) (m-1) (k+1)
            else
               acc  
   in
    match n with
     |0 -> []
     |1 -> [[1]]
     |n -> recpart n [[n]] (n-1) 1;;

(*Tests*)
partition 4;;
(*- : int list list = [[2; 2]; [1; 1; 2]; [1; 3]; [4]]*)
partition 5;;
(*- : int list list = [[2; 3]; [1; 2; 2]; [1; 1; 1; 2]; [1; 1; 3]; [1; 4]; [5]]*)
partition 1;;
(*- : int list list = [[1]]*)






