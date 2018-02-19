(******  HAMZA BOUKRAICHI Groupe H ******)
(**arbres_lexicographiques**)
(*====================================================================*)
(*Exercice 1*)
type 'a arbre =
  Noeud of (bool*(('a * 'a arbre) list));;

type ('a,'b)trie = Trie of ('b arbre*('a->'b list)*('b list -> 'a));;

(*====================================================================*)
(*Exercice 2*)
(*  nom : creation type val creation : ('a -> 'b list) -> 
('b list -> 'a) -> ('a, 'b) trie = <fun>
 *  rôle : creer un arbre lexicographique
 *  paramètre : decomp 'a->'b list fonction de decompisition 
 *              recomp  'b list -> 'a fonction de recomposition
 *  résultat : ('a, 'b)trie , l'arbre lexicographique
 *  précondition : aucune
 *  postcondition : aucune
 *  erreur : aucune
 *)

let creation = fun decomp recomp ->
  Trie((Noeud(false,[])),decomp,recomp);;
(*====================================================================*)
(*Exercice 3*)
(*--------------------------------------------------------------------*)
(*  nom : recherche type val recherche : 'a -> 
('a * 'b) list -> 'b option = <fun>
 *  rôle : recherche la branche commençant par un caractère
 *  paramètre : d , 'a
 *              l , ('a * 'a arbre) list
 *  résultat : 'a * 'a arbre, la branche qui débute par ce caractère
 *  précondition : aucune
 *  postcondition : aucune
 *  erreur : aucune
 *)

let rec recherche = fun d l ->
   match l with
  |[]->None
  |(x,a)::q->if d=x then (Some a)
             else
               recherche d q;;
(*--------------------------------------------------------------------*)

(*--------------------------------------------------------------------*)
(*  nom : maj type val maj : 'a -> ('a * 'b) list -> 'b -> ('a * 'b) list = <fun>
 *  rôle : mise à jour d'une branche à partir d'une autre branche 
 commençant par le meme caractère
 *  paramètre : l , (a*'a arbre) list
                a , 'a arbre
 *  résultat : 'a arbre, la branche mise à jour
 *  précondition : aucune 
 *  postcondition : aucune 
 *  erreur : aucune
 *)
let rec maj = fun c l newarb ->
  match l with 
    |[] -> [(c,newarb)]
    |(char1,arb1)::q -> if c=char1 then (c,newarb)::q
                        else if c<char1 then (c,newarb)::l
                        else (char1,arb1)::( maj c q newarb);;
                

(*--------------------------------------------------------------------*)

(*--------------------------------------------------------------------*)
(*  nom retrait : type val retrait : 'a -> ('a * 'b) list -> ('a * 'b) list = <fun>
 *  rôle : retire la branche 
 *  paramètre : type, rôle
 *  résultat : type, rôle
 *  précondition :
 *  postcondition :
 *  erreur :
 *)
let rec retrait = fun c l ->
  match l with
  |[] -> []
  |(char1,arb1)::q -> if c=char1 then q
                      else if c<char1 then l
                      else (char1,arb1)::(retrait c q);;
(*--------------------------------------------------------------------*)


(*====================================================================*)
(*Exercice 4*)


