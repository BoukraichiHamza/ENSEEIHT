open Tas;;

(* fonction qui génère un tas avec des valeurs aléatoires *)
(* à noter l'appel à la fonction int du module random     *)

let genere_tas n =
  let rec aux m a =
    match m with
        0 -> a
      | _ -> aux (m-1) (ajout (Random.int n) a)
  in aux n (nouveau_tas ());;

(* création de deux abg *)
let a1 = genere_tas 10;;
print_tas print_int a1;;
print_newline ();;
print_string "-------------------------------------";;
print_newline ();;
print_newline ();;

let a2 = genere_tas 10;;
print_tas print_int a2;;
print_newline ();;
print_string "-------------------------------------";;
print_newline ();;
print_newline ();;

(* test de multi_union (déjà testé dans genere_tas) *)
let a = multi_union a1 a2;;
print_tas print_int a;;
print_newline ();;
print_string "-------------------------------------";;
print_newline ();;
print_newline ();;

(* test de profondeur *)
print_string "test de profondeur : ";;
print_int (profondeur a1);;
print_newline ();;

(* test de profondeur *)
print_string "test de profondeur : ";;
print_int (profondeur a);;
print_newline ();;

(* test de cardinal *)
print_string "test de cardinal : ";;
print_int (cardinal a);;
print_newline ();;

(* test de elt_min *)
print_string "test de elt_min : ";;
print_int (elt_min a);;
print_newline ();;

(* test de est_vide *)
print_string "test de est_vide : ";;
if (est_vide a) then print_string "vide"
                else print_string "non vide";;
print_newline ();;

(* test de est_vide et nouveau_tas *)
print_string "test de est_vide : ";;
if (est_vide (nouveau_tas())) then print_string "vide"
                              else print_string "non vide";;
print_newline ();;

(* test de retrait_min *)
print_string "test de retrait_min : ";;
print_newline ();;
print_tas print_int (retrait_min a);;
print_newline ();;

(* test de tas_fold : calcule l'élément max de l'arbre *)
print_string "test de tas_fold : ";;
print_int (tas_fold max a (elt_min a));;
print_newline ();;
