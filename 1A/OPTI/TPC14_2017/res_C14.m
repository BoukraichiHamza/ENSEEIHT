function rvec = res_C14(beta)
%
% Calcul du vecteur des residus correspondant au probleme de datation par le
% carbone 14, tel que traite et modelise dans le cadre des TP d'Optimisation
% Numerique de 2e annee ENSEEIHT-IMA.
%
% RVEC = res_C14(BETA) renvoie en RVEC le vecteur colonne des differents
% residus issus de l'ecart entre les valeurs observees et celles calculees
% au moyen du modele de radioactivite parametre par le vecteur BETA.
% Il est donc suppose que les variables Ti et Ai, representant respectivement
% des ages en annees et les valeurs de radioactivites correspondantes.
%
% Entree :
%	beta : un vecteur representant les parametres du modele d'evolution
%       de la radioactivite du carbone 14
%
% Sortie :
%	rvec : le vecteur des residus, c'est-a-dire des erreurs entre les
%	valeurs observees et les valeurs calculees par le modele
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global Ti Ai % Vecteurs colonnes des ages et radioactivites correspondantes


rvec = Ai - beta(1)*exp(-beta(2)*Ti);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
