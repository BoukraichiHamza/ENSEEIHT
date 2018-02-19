(* ouverture des modules a utiliser			*)
open Dessin;;

(* une definition d'un angle de 60 degres		*)
(* utile pour les triangles equilateraux		*)
let pi_sur_3 = 3.141592654 /. 3.;;

(* fonction qui engendre les points p2, p3 et p4	*)
(* a partir des points p1 et p5, selon la courbe	*)
(* de Von Koch (voir figure dans le sujet)		*)
let nouvelle_generation (x1, y1) (x5, y5) =
 let dx = (x5 -. x1) /. 3. in
 let dy = (y5 -. y1) /. 3. in
 let dl = sqrt (dx *. dx +. dy *. dy) in
 let a  = atan2 dy dx +. pi_sur_3 in
 let p2 = (x1 +. dx                 , y1 +. dy                 ) in
 let p3 = (x1 +. dx +. dl *. (cos a), y1 +. dy +. dl *. (sin a)) in
 let p4 = (x1 +. 2. *. dx           , y1 +. 2. *. dy           ) in
 (p2, p3, p4);;

(* fonction qui calcule la liste des segments à afficher *)
let rec dessin_fractal (p1,p5) n dessin =
	if n=0
	then ajouter_segment (p1,p5) dessin
	else let (p2,p3,p4) = nouvelle_generation p1 p5 in
			(dessin_fractal (p1,p2) (n-1)
                               (dessin_fractal (p2,p3) (n-1) 
                                      (dessin_fractal (p3,p4) (n-1)
                                             (dessin_fractal (p4,p5) (n-1) dessin ))));;

(* Affichage *)
let a=(100.,100.) and b=(500.,100.) and c=(300.,400.) in
dessiner ((dessin_fractal (b,a)) 10 ((dessin_fractal (c,b)) 10 (dessin_fractal (a,c) 10 (creer_vide 600 400))));;
