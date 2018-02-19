(******  HAMZA BOUKRAICHI Groupe H ******)
(*Types de données arborescents*)

(*Définitions du type abr*)
type 'a abr = Vide | Noeud of 'a abr * 'a * 'a abr;;
let abr1 = Noeud(Noeud(Vide,5,Vide),7,Vide);;
let abr2 = Noeud(Noeud(Noeud(Vide,4,Vide),5,Vide),7,(Noeud(Vide,8,Vide)));;
let abr3 = Noeud(Noeud(Noeud(Vide,'a',Noeud(Vide,'b',Vide)),'c',Vide),'d',(Noeud(Vide,'e',Vide)));;

(*Exercice 1*)
(*  nom : test_aprt  
 *type val test_aprt : 'a -> 'a abr -> bool = <fun>
 *  rôle : fonction qui teste l’appartenance d’un élément à un
multi-ensemble représenté par un abr
 *  paramètre : x , la valeur à chercher dans l'arbre
              : arbre : abr, l'arbre où la valeur sera cherchée
 *  résultat : booléen
 *)

let rec test_aprt = fun x arbre -> 
  match arbre with
  |Vide -> false
  |Noeud(g,r,d) -> r=x || if r<x then
                            test_aprt x d 
                            else
                               test_aprt x g;; 
(*Tests*)
test_aprt 5 abr1;;
(*- : bool = true*)
test_aprt 6 abr2;;
(*- : bool = false*)
test_aprt 'a' abr3;;
(*- : bool = true*)

(*Exercice 2*)
(*Fonction ajout*)
(*fonction qui ajoute un élément à un multi-ensemble représenté par un abr*)
(*Type val ajout : 'a -> 'a abr -> 'a abr = <fun> *)
(*Parametres 
 x : valeur à ajouter;
 arbre : abr : l'arbre ou la valeur sera ajoutée*)
(*Type retour : abr*)

let rec ajout = fun x arbre ->
  match arbre with
  |Vide -> Noeud(Vide,x,Vide)
  |Noeud(g,a,d) -> if x<a then Noeud(ajout x g,a,d)   
                           else 
                             Noeud(g,a,ajout x d);;
(*Tests*)

ajout 2 abr1;;
(*- : int abr = Noeud (Noeud (Noeud (Vide, 2, Vide), 5, Vide), 7, Vide)*)
ajout 6 abr2;;
(*- : int abr =Noeud (Noeud (Noeud (Vide, 4, Vide), 5, Noeud (Vide, 6, Vide)), 7,
 Noeud (Vide, 8, Vide))*)
ajout 'd' abr3;;
(*- : char abr =Noeud (Noeud (Noeud (Vide, 'a', Noeud (Vide, 'b', Vide)), 'c', Vide), 'd',
 Noeud (Noeud (Vide, 'd', Vide), 'e', Vide))*)


(*Exercice 3*)
(*Itérateur fold*)
(*parcourir tous les éléments d’un abr et leur appliquer une fonction donnée*)
(*Type(’a -> ’b -> ’a -> ’a) -> ’b abr -> ’a -> ’a*)
(*Parametres : f : function;
               e : type 'a;
               arbre : 'a abr;
*)

let rec fold = fun  f arbre e ->
  match arbre with
  |Vide -> e
  |Noeud(g,r,d) -> f (fold f g e)  r (fold f d e);;


fold (fun g x d->Noeud(g,x+1,d)) abr1 Vide;;
(*- : int abr = Noeud (Noeud (Vide, 6, Vide), 8, Vide)*) 

(*Exercice 4*)
(*Cardinal*)
(*une fonction permettant de calculer le cardinal d’un multi-ensemble représenté par un abr*)
(*Type val cardinal : 'a abr -> int = <fun>*)
(*Parametres : arbre ; abr*)

let cardinal = fun arbre ->
  fold (fun cardg r cardd -> 1+cardg+cardd )
       arbre
       0;;

(*Tests*)
cardinal abr1;;
(*- : int = 2*)

cardinal abr2;;
(*- : int = 4*)

cardinal abr3;;
(*- : int = 5*)

(*Exercice 5*)
(*aplat*)
(*fonction permettant de construire la liste triée des éléments d’un multi-ensemble représenté par un abr*)
(*Type *)
(*Paramètres : arbre : abr; l'arbre à aplatir*)

let aplat = fun arbre ->
  fold (fun g r d -> g@(r::d)) arbre [];;

aplat abr1;;
(*- : int list = [5; 7]*)
aplat abr2;;
(*- : int list = [4; 5; 7; 8]*)
aplat abr3;;
(*- : char list = ['a'; 'b'; 'c'; 'd'; 'e']*)

(*Exercice 6*)
(*Tri_list*)
(*une fonction triant une liste dans l’ordre croissant par l’inter-
médiaire d’un abr*)
(*Type 
 *)
(*Parametres : l : liste à trier*)

let tri_liste = fun l -> 
  let abrtri =  List.fold_right ( fun t arbre -> ajout t arbre) l Vide in
   aplat abrtri;;

(*Tests*)
tri_liste [] ;;
(*- : 'a list = []*)
tri_liste [5;9;7;12;45;10] ;;
(*- : int list = [5; 7; 9; 10; 12; 45]*)
tri_liste [2;1] ;;
(*- : int list = [1; 2]*)

(*Exercice 7*)

