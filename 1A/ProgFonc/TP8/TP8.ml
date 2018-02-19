(******  HAMZA BOUKRAICHI Groupe H ******)

(*  nom : Recherche
 *  type :('a -> 'a list) -> ('a -> bool) -> 'a -> 'a list
 *  rôle : Recherche de position gagnante et retourne la liste définissant le chemin suivi
 *  paramètre : Voisinage : Liste : Contenant une liste des positions voisines
 *            : Critere  : Prédicat qui permet de dire si la position gagnante est atteinte
 *  résultat  : solution : Liste définissant le chemin suivi 
 *  précondition  :
 *  postcondition :
 *  erreur :
 *)

let recherche voisinage critere position =
   let rec cherche pos =
      if critere pos then
         [ pos ] (* OK ! *)
      else
         match cherche_liste (voisinage pos) with
         | [] -> [] (* ECHEC ! *)
         | solution -> pos :: solution
   and cherche_liste positions =
      match positions with
      | [] -> [] (* ECHEC ! *)
      | tpos::queue -> match cherche tpos with
      | [] -> cherche_liste queue
      | solution -> solution
   in cherche position;;

(*Exercice 1*)

(*Position couple contenant la somme à rendre restante et une liste de pièce disponibles*)
(*val pos : int * int list*)
let pos1 = (100,[200;10;50;20;10;5;5;10]);;
let pos2 = (200,[50;20;10;5;5;10;100]);;
let pos3 = (50,[100;20;10;5;20]);;
let pos4 = (40,[10;5;20]);;
let pos5 = (20,[]);;

(*Exercice 2*)
(*Fonction voisinage*)
(*Fonction qui permet à partir d’une position, de déterminer les états voisins*)
(*Type :  int * int list -> (int * int list) list *)
(*Paramètres : position : couple(entier,liste) : représentant la position actuelle*)
(*Resultat : une liste des positions voisines*)
(*Précondition : *)
(*Postcondition : *)

let voisinage = fun position ->
  match position with
  |(_,[]) -> []
  |(arendre,t::q) -> if arendre>=t then
                        (arendre-t,q)::[(arendre,q)]
                     else
                       [(arendre,q)];;

(*Tests*)
voisinage pos1;;
(*- : (int * int list) list = [(100, [10; 50; 20; 10; 5; 5; 10])]*)
voisinage pos2;;
(*- : (int * int list) list =[(150, [20; 10; 5; 5; 10; 100]); (200, [20; 10; 5; 5; 10; 100])]*)
voisinage pos3;;
(*- : (int * int list) list = [(50, [20; 10; 5; 20])]*)
voisinage pos4;;
(*- : (int * int list) list = [(30, [5; 20]); (40, [5; 20])]*)
voisinage pos5;;
(*- : (int * int list) list = []*)

(*Exercice 3*)
(*Les cycles ne sont pas à prendre en compte puisque les listes diminuent à chaque fois de taille*)
(*Le résultat attendu est une liste de position représentant le chemin à prendre*)
(*Type : int->int list list*) 

(*Exerice 4*)
(*Fonction critere*)
(*Fonction qui permet de dire si une solution est atteinte*)
(*Type val critere : int * 'a -> bool = <fun> *)
(*Paramètres : position : couple d'entier et d'une liste d'entier*)
(*Précondition: *)
(*Postcondition *)

let critere = fun position ->
  let (arendre,l)=position in
  arendre=0;;

(*Exercice 5*)

(*Tests de fonction de recherche complete*)
recherche voisinage critere pos1;;
(*- : (int * int list) list =[(100, [200; 10; 50; 20; 10; 5; 5; 10]); (100, [10; 50; 20; 10; 5; 5; 10]);
 (90, [50; 20; 10; 5; 5; 10]); (40, [20; 10; 5; 5; 10]);
 (20, [10; 5; 5; 10]); (10, [5; 5; 10]); (5, [5; 10]); (0, [10])]*)
recherche voisinage critere pos2;;
(*- : (int * int list) list =[(200, [50; 20; 10; 5; 5; 10; 100]); (150, [20; 10; 5; 5; 10; 100]);
 (130, [10; 5; 5; 10; 100]); (120, [5; 5; 10; 100]); (115, [5; 10; 100]);
 (110, [10; 100]); (100, [100]); (0, [])]*)
recherche voisinage critere pos3;;
(*- : (int * int list) list =
[(50, [100; 20; 10; 5; 20]); (50, [20; 10; 5; 20]); (30, [10; 5; 20]);
 (20, [5; 20]); (20, [20]); (0, [])]*)
recherche voisinage critere pos4;;
(*- : (int * int list) list = []*)
recherche voisinage critere pos5;;
(*- : (int * int list) list = [] *)

(*Exercice 6*)
(*Le resultat obtenu est une liste d'entier contenant les pièces à rendre*)
(*type : int list*)

(*Exercice 7*)
(*Fonction monnaie_arendre*)
(*Fonction qui retourne l’ensemble des pièces rendues*)
(*Type: *)
(*Paramètres : postion : couple d'entier et de liste d'entier*)
(*PRéconditions :*)
(*Postconditions: *)

let rec monnaie_arendre = fun positions ->
  match  positions with 
  |[] -> []
  |[(_,[])] -> []
  |[(arendre,t::q)]->[]
  |(arendre1,t1::q1)::((arendre2,t2::q2)::q) -> if arendre1<arendre2 then
                                            t1::(monnaie_arendre ((arendre2,t2::q2)::q))
                                           else
                                             monnaie_arendre ((arendre2,t2::q2)::q);;

(*Tests*)
monnaie_arendre (recherche voisinage critere pos1);;
(**)
monnaie_arendre (recherche voisinage critere pos2);;
(**)
monnaie_arendre (recherche voisinage critere pos3);;
(**)
monnaie_arendre (recherche voisinage critere pos4);;
(**)
monnaie_arendre (recherche voisinage critere pos5);;
(**)
