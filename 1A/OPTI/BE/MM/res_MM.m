%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mai  2017                                                             %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de l'equation de Michaelis-Mensen      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function r=res_MM(beta)
% Caclul du vecteur des residus
% beta : parametres de l'equation de Michaelis-Mensen
% beta(1)= Vmax; beta(2) = Km

global Si Vi

r = (beta(1).*Si)./(beta(2)+Si) - Vi;

end
