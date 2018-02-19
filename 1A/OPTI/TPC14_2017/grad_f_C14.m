function g = grad_f_C14(beta)
%
% Calcul du gradient de la fonctionnelle des moindres carres correspondant au 
% probleme de datation par le carbone 14, traite dans le cadre des TP 
% d'Optimisation Numerique de 2e annee ENSEEIHT-IMA.
% 
% G = grad_f_C14(BETA) renvoie en G le vecteur colonne representant le gradient % de la fonctionnelle des moindres carres calculee en le vecteur BETA. Elle 
% suppose initialisees les variables globales Ti et Ai, representant 
% respectivement des ages en annees et les radioactivites du carbone 14 
% mesurees pour ces ages.
%
% Entree :
%       beta : un vecteur representant les parametres du modele d'evolution
%       de la radioactivite du carbone 14
%
% Sortie :
%       g : vecteur gradient de la fonctionnelle des moindres carres calculee 
%	en beta
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Ti Ai % Vecteurs colonnes des ages et radioactivites correspondantes
Jr=J_res_C14(beta);
r = res_C14(beta)
g = Jr'*r;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
