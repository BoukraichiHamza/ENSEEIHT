(******  HAMZA BOUKRAICHI Groupe H ******)
(*Arbres binaires à Gauche*)

type 'a abg = Vide | Noeud of 'a abg * 'a * 'a abg;;

(*Exercice 1 *)
(*  nom : profondeur type val profondeur : 'a abg -> int = <fun>
 *  rôle : calcule la profondeur maximale d'un arbre
 *  paramètre : a : agb , l'arbre dont la profondeur sera calculée
 *  résultat : entier, la profondeur de l'arbre
 *  précondition : aucune
 *  postcondition : aucune
 *  erreur : aucune
 *)

let rec profondeur = fun a ->
  match a with
  |Vide -> 0
  |Noeud(abgg,r,abgd) -> 1+profondeur(abgg);;

(*Exercice 2*)
(*  nom : multi_union type val multi_union : 'a abg -> 'a abg -> 'a abg = <fun>
 *  rôle : retourne l'union de deux arbres gauches
 *  paramètre : a1 a2: abg , les arbres dont l'union sera effectuée
 *  résultat :  abg, l'union des deux arbres
 *  précondition : aucune
 *  postcondition : aucune
 *  erreur : aucune
 *)

let rec multi_union = fun a1 a2 ->
  match a1,a2 with
    |_,Vide -> a1
    |Vide,_ -> a2
    |Noeud(ag1,r1,ad1),Noeud(ag2,r2,ad2)-> if r1 <= r2 then 
                                             let ad = multi_union ad1 a2 in
                                                if (profondeur ag1)<(profondeur ad) then
                                                  Noeud(ad,r1,ag1)
                                                else
                                                  Noeud(ag1,r1,ad)
                                           else
                                             let ad = multi_union a1 ad2 in
                                                if (profondeur ag2)<(profondeur ad) then
                                                  Noeud(ad,r2,ag2)
                                                else
                                                  Noeud(ag2,r2,ad);;

(*Exercice 3*)
(*  nom : ajout type val ajout : 'a abg -> 'a -> 'a abg = <fun>
 *  rôle : ajouter un element dans l'arbre
 *  paramètre : a :'a abg , l'arbre où l'element sera ajouté
 *              e :'a , l'élément à ajouté
 *  résultat : 'a abg, l'arbre final
 *  précondition : aucune 
 *  postcondition : e appartient à a
 *  erreur : aucune
 *)

let ajout = fun a e -> multi_union a (Noeud(Vide,e,Vide));;

(*TESTS*)
profondeur Vide;;
let a1=ajout Vide 1;;
profondeur a1;;
let a1= ajout (ajout a1 3) 2;;
profondeur a1;;
let a2 =ajout (ajout (ajout Vide 3) 2) 4;;
profondeur a2;;
let a3 = multi_union a1 a2;;
profondeur a3;;

(*
- : int = 0
val a1 : int abg = Noeud (Vide, 1, Vide)
- : int = 1
val a1 : int abg = Noeud (Noeud (Vide, 3, Vide), 1, Noeud (Vide, 2, Vide))
- : int = 2
val a2 : int abg = Noeud (Noeud (Vide, 3, Vide), 2, Noeud (Vide, 4, Vide))
- : int = 2
val a3 : int abg =
  Noeud
   (Noeud (Noeud (Noeud (Vide, 3, Vide), 2, Noeud (Vide, 4, Vide)), 2, Vide),
   1, Noeud (Vide, 3, Vide))
- : int = 4
 *)


(*Exercice 4*)
(*  nom :elt_min type val elt_min : 'a abg -> 'a = <fun>
 *  rôle : renvoie l'element minimum d'un arbre
 *  paramètre : e : 'a abg, l'arbre dont l'élément minimum sera renvoyé
 *  résultat : 'a, l'élément minimum
 *  précondition : aucune
 *  postcondition : aucune
 *  erreur : arbre vide
 *)
 
let elt_min  =fun a ->
  match a with
  |Vide -> failwith("Arbre vide")
  |Noeud(_,r,_) -> r;;



(*Exercice 5*)
(*  nom : retrait_min type val retrait_min : 'a -> 'b abg -> 'b abg = <fun>
 *  rôle : retire le plus petit élément d'un arbre
 *  paramètre :a a'abg, rôle l'arbre à modifier
 *  résultat : a'abg, rôle l'arbre modifié
 *  précondition : aucune 
 *  postcondition : aucune
 *  erreur : aucune
 *)

let retrait_min = fun a ->
  match a with
  |Vide -> Vide
  |Noeud(g,_,d) -> (multi_union g d);;


(*Tests*)
elt_min a1;;
let a12=retrait_min a1;;
elt_min a12;;

elt_min a2;;
let a22=retrait_min a2;;
elt_min a22;;

elt_min a3;;
let a32=retrait_min a3;;
elt_min a32;;

(*
- : int = 1
val a12 : int abg = Noeud (Noeud (Vide, 3, Vide), 2, Vide)
- : int = 2
- : int = 2
val a22 : int abg = Noeud (Noeud (Vide, 4, Vide), 3, Vide)
- : int = 3
- : int = 1
val a32 : int abg =
  Noeud (Noeud (Noeud (Vide, 3, Vide), 2, Noeud (Vide, 4, Vide)), 2,
   Noeud (Vide, 3, Vide))
- : int = 2
*)
