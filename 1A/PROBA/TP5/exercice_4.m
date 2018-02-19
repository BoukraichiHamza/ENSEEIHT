clear;
close all;

exercice_3;

% Resolution du systeme lineaire CY = 0 :
C(1,:) = x_centres;
C(2,:) = y_centres;
C = transpose(C);
[vect_p, val_p] = eig(C'*C);
[min_val,indice_min] = min(diag(val_p));
Y = vect_p(:,indice_min);
cos_theta_estime = Y(1);
sin_theta_estime = Y(2);
rho_estime = mean(x_donnees*cos_theta_estime + y_donnees*sin_theta_estime);

% Affichage de la droite de regression estimee par resolution d'un systeme lineaire :
if abs(sin_theta_estime)>abs(cos_theta_estime)
	x_regression = -taille:pas:taille;
	y_regression = (rho_estime-x_regression*cos_theta_estime)/sin_theta_estime;
else
	y_regression = -taille:pas:taille;
	x_regression = (rho_estime-y_regression*sin_theta_estime)/cos_theta_estime;
end
plot(x_regression,y_regression,'m-','LineWidth',2);
axis equal;
axis(echelle);
lg = legend('Donnees','Centre de gravite~~~','$D_\perp$ par MV','$D_\perp$ par $CY = O$','Location','Best');
set(lg,'Interpreter','Latex');

% Ecart angulaire sur la direction estimee par CY = O :
theta_estime = atan(sin_theta_estime/cos_theta_estime);
ecart_angulaire = min(abs(theta_estime-theta_0),abs(theta_estime-theta_0+pi));
ecart_angulaire = min(ecart_angulaire,abs(theta_estime-theta_0-pi));
disp(['D_perp estimee par CY = O : ecart angulaire = ' num2str(ecart_angulaire/pi*180,'%.2f') ' degres']);
