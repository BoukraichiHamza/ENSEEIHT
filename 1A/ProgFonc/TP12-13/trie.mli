(*                           Module de trie                                   *)

(* type trie
le mot est de type 'a, les "caractères" le composant de type 'b
*)
type ('a,'b) trie;;

(* nouveau : ('a -> 'b list) -> ('b list -> 'a) -> ('a, 'b) trie
fonction de création d'un trie
paramètres : ('a -> 'b list), la fonction de décomposition 
             ('b list -> 'a), la fonction de recomposition 
résultat   : un trie vide 
*)
val nouveau : ('a -> 'b list) -> ('b list -> 'a) -> ('a, 'b) trie;;

(* appartient : 'a -> ('a, 'b) trie -> bool
fonction de test d'appartenance d'un mot au trie
paramètres : 'a, un mot
             ('a, 'b) trie, un trie 
résultat   : le résultat booléen du test
*)
val appartient : 'a -> ('a, 'b) trie -> bool;;

(* ajout : 'a -> ('a, 'b) trie -> ('a, 'b) trie
fonction d'ajout d'un mot au trie
paramètres : 'a, un mot
             ('a, 'b) trie, un trie
résultat   : le trie avec le mot ajouté
*)
val ajout : 'a -> ('a, 'b) trie -> ('a, 'b) trie;;

(* retrait : 'a -> ('a, 'b) trie -> ('a, 'b) trie
fonction de retrait d'un mot au trie
paramètres : 'a , un mot
             ('a, 'b) trie, un trie
résultat   : le trie avec le mot retiré
*)
val retrait : 'a -> ('a, 'b) trie -> ('a, 'b) trie;;

(* affiche : ('a -> unit) -> ('a, 'b) trie -> unit
procédure d'affichage d'un trie 
paramètres : ('a -> unit), une procédure d'affichage d'un mot 
             ('a, 'b) trie, un trie 
résultat   : rien
*)
val affiche : ('a -> unit) -> ('a, 'b) trie -> unit;;
