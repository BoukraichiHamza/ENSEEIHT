function H = H_f_C14(beta);
%
% Calcul de la matrice Hessienne de la fonctionnelle des moindres carres
% correspondant au probleme de datation par le carbone 14, traite dans le
% cadre des TP d'Optimisation Numerique de 2e annee ENSEEIHT-IMA.
%
% H = H_f_C14(BETA) renvoie en H la matrice Hessienne de la fonctionnelle des 
% moindres carres, calculee en le vecteur BETA. Elle suppose initialisees les 
% variables globales Ti et Ai, qui representent des ages exprimes en annees 
% (vecteur Ti) et les radioactivites du carbone 14 mesurees a ces ages (vecteur
% Ai)..
%
% Entree :
%       beta : un vecteur representant les parametres du modele d'evolution
%       de la radioactivite du carbone 14
%
% Sortie :
%       H : matrice Hessienne de la fonctionnelle des moindres carres calculee 
%	en beta
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Ti Ai % Vecteurs colonnes des ages et radioactivites correspondantes
r = res_C14(beta);
Jr = J_res_C14(beta);

H = Jr'*Jr;
deriv = 0;
for k = 1:7
    deriv = Ti(k)*exp(-beta(2)*Ti(k));
    H = H + r(k)* [ 0 deriv; deriv -Ti(k)*beta(1)*Ti(k)*exp(-beta(2)*Ti(k))]; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
