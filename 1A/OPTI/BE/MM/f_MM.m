%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mai 2017                                                              %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de l'equation de Michaelis-Mensen      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function y=f_MM(beta)
% Evaluation de la fonction des moindres carres
% beta : parametres de l'equation de Michaelis-Mensen
% beta(1)= Vmax; beta(2) = Km

global Si Vi

r = res_MM(beta);
y = 0.5*norm(r,2)^2;

end
