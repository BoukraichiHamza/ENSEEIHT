open File;;

let fvide = creer_vide();;
let f1 = enfiler 1 fvide;;
let f2 = enfiler 2 fvide;;
let f32 = enfiler 3 f2;;
let f21 = enfiler 2 f1;;
let f321 = enfiler 3 f21;;


let test1 = (est_vide fvide,"Le test à vide de la file vide devrait renvoyer vrai.");;
let test2 = (not (est_vide f1),"Le test à vide d'une file à un élément devrait renvoyer faux.");;
let test3 = (not (est_vide f21),"Le test à vide d'une file à 2 éléments devrait renvoyer faux.");;
let test4 = (not (est_vide f321),"Le test à vide d'une file à 3 éléments devrait renvoyer faux.");;
let test9 = (let (e,f) = defiler f1 in ((e,f) = (1,fvide)),"Erreur de la fonction défiler");;
let test10 = (let (e,f) = defiler f21 in ((e,f) = (1,f2)),"Erreur de la fonction défiler");;
let test11 = (let (_,ff) = defiler f21 in let (e,f) = defiler ff in ((e,f) = (2,fvide)),"Erreur de la fonction défiler");;
let test12 = (let (e,f) = defiler f321 in ((e,f) = (1,f32)),"Erreur de la fonction défiler");;

let l = [test1;test2;test3;test4;test9;test10;test11;test12] in
List.map (fun (test,message) -> if (test) then print_string "OK\n" else print_string ("KO : "^message^"\n")) l;;
