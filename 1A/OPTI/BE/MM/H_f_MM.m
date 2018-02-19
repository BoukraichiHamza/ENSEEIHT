%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mai 2017                                                              %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient les fonctions matlab pour l'exemple               %
% de l'estimation des parametres de l'equation de Michaelis-Mensen      %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function H=H_f_MM(beta)
% Calcul de la matrice Hessienne de la fonction f_MM
% beta : parametres de l'equation de Michaelis-Mensen
% beta(1)= Vmax; beta(2) = Km

global Si Vi
J = J_res_MM(beta);
r = res_MM(beta);
Hresidu = zeros(2,2);
H = J'*J;

for i=1:length(J)
    eSym = -Si(i)/((beta(2)+Si(i))^2);
    Hr22 = 2 * (beta(1)*Si(i)^2*(beta(2)+Si(i))) / ((beta(2) + Si(i))^4);
    Hresidu = [ 0 , eSym ; eSym , Hr22 ];
    H = H + r(i) * Hresidu;
end
    
end
