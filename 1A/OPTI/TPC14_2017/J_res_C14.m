function Jr = J_res_C14(beta)
%
% Calcul de la matrice Jacobienne de la fonction vectorielle residu 
% correspondant au probleme de datation par le carbone 14, tel que traite et 
% modelise dans le cadre des TP d'Optimisation Numerique de 2e annee 
% ENSEEIHT-IMA.

% JR = J_res_C14(BETA) renvoie en JR la matrice Jacobienne dont les lignes
% sont les transposes des vecteur gradients des differentes fonctions
% residus issus de l'ecart entre les valeurs observees et celles calculees
% au moyen du modele de radioactivite parametre par le vecteur BETA.
% On suppose qu'avant l'appel a cette fonction les variables Ti et Ai, qui
% representent des ages (en annees) et les radioactivites correspondant a
% ces ages, ont ete initialisees..
%
% Entree :
%       beta : un vecteur representant les parametres du modele d'evolution
%       de la radioactivite du carbone 14
%
% Sortie :
%       Jr : la matrice Jacobienne de la fonction residu, c'est-a-dire la
%	matrice dont les lignes sont les transposes des vecteurs gradients des
%	composantes de la fonction residu. 
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Ti Ai % Vecteurs colonnes des ages et radioactivites correspondantes

Jr = zeros(7,2);
for i = 1:7
    Jr(i,1) = -exp(-beta(2)*Ti(i));
    Jr(i,2) = beta(1)*Ti(i)*exp(-beta(2)*Ti(i));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
