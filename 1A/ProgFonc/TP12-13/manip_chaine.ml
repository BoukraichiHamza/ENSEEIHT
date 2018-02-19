(* decompose_chain : string -> char list
fonction de décomposition d'une chaîne de caractères
paramètre s : string, une chaîne de caractères
résultat   : la liste formée des caractères de la chaîne, dans l'ordre
*)
let decompose_chaine s =
  let rec decompose i accu =
    if i < 0 then accu
    else decompose (i-1) (String.get s i::accu)
  in decompose (String.length s - 1) [];;

(* recompose_chaine : char list -> string
fonction de recomposition d'une chaine de caractères
paramètre l : char list, une liste des caractères
résultat   : la chaîne formée des caractères de la liste, dans l'ordre
*)
let recompose_chaine l =
 List.fold_right (fun t q -> String.make 1 t ^ q) l "";;

