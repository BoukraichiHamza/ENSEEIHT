clear;
close all;

exercice_1;

% Resolution du systeme lineaire AX = B :
A(:,1) = transpose(x_donnees);
A(:,2) = ones(1,n);
B = transpose(y_donnees);

X = pinv(A)*B;
a_estime = X(1);
b_estime = X(2);

% Affichage de la droite de regression estimee par resolution d'un systeme lineaire :
if abs(a_estime)<1
	x_regression = -taille:pas:taille;
	y_regression = a_estime*x_regression+b_estime;
else
	y_regression = -taille:pas:taille;
	x_regression = (y_regression-b_estime)/a_estime;
end
plot(x_regression,y_regression,'m-','LineWidth',2);
axis equal;
axis(echelle);
lg = legend('Donnees','Centre de gravite~~~','$D_{YX}$ par MV','$D_{YX}$ par $AX = B$','Location','Best');
set(lg,'Interpreter','Latex');

% Ecart angulaire sur la direction estimee par AX=B :
theta_estime = atan(a_estime)+pi/2;
ecart_angulaire = min(abs(theta_estime-theta_0),abs(theta_estime-theta_0+pi));
ecart_angulaire = min(ecart_angulaire,abs(theta_estime-theta_0-pi));
disp(['D_YX estimee par AX = B : ecart angulaire = ' num2str(ecart_angulaire/pi*180,'%.2f') ' degres']);
