function [cos_theta_n,sin_theta_n,rho_n] = estimation_n(x_donnees,y_donnees)

x_G = mean(x_donnees);
y_G = mean(y_donnees);
x_donnees_centrees = x_donnees-x_G;
y_donnees_centrees = y_donnees-y_G;
if size(x_donnees_centrees,2)>size(x_donnees_centrees,1)
	x_donnees_centrees = transpose(x_donnees_centrees);
	y_donnees_centrees = transpose(y_donnees_centrees);
end
C = [x_donnees_centrees y_donnees_centrees];
M = transpose(C)*C;
[V,D] = eig(M);
[valeurs_triees,indices_tries] = sort(diag(D),'ascend');
cos_theta_n = V(1,indices_tries(1));
sin_theta_n = V(2,indices_tries(1));
rho_n = x_G*cos_theta_n+y_G*sin_theta_n;
