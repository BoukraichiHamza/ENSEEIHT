%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mai 2017                                                              %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de l'equation de Michaelis-Mensen      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function g=grad_f_MM(beta)
% Calcul du gradient de la fonction f_MM
% beta : parametres de l'equation de Michaelis-Mensen
% beta(1)= Vmax; beta(2) = Km

J = J_res_MM(beta);
r = res_MM(beta);
g = J'*r;

end
