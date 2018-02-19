clear;
close all;

donnees;

% Affichage du centre de gravite :
G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
plot(G(1),G(2),'k*','MarkerSize',10,'LineWidth',2);

% Centrage des donnees :
x_centres = x_donnees - G(1);
y_centres = y_donnees - G(2);

% Maximisation de la vraisemblance par tirages aleatoires de theta :
nombre_tirage = 1000;
theta_test = (pi)*(rand(1,nombre_tirage));
arguments = [];
for k = 1:nombre_tirage
	arguments = [arguments , sum((cos(theta_test(k))*x_centres + sin(theta_test(k))*y_centres).^2)];
end
[argument_min,indice_min] = min(arguments);
theta_estime = theta_test(indice_min);
rho_estime = mean(x_donnees*cos(theta_estime) + y_donnees*sin(theta_estime));

% Affichage de la droite de regression estimee par MV :
pas = 0.01;
if abs(pi/2-theta_estime)<pi/4
	x_regression = -taille:pas:taille;
	y_regression = (rho_estime-x_regression*cos(theta_estime))/sin(theta_estime);
else
	y_regression = -taille:pas:taille;
	x_regression = (rho_estime-y_regression*sin(theta_estime))/cos(theta_estime);
end
plot(x_regression,y_regression,'b-','LineWidth',2);
axis equal;
axis(echelle);
lg = legend('Donnees','Centre de gravite~~~','$D_\perp$ par MV','Location','Best');
set(lg,'Interpreter','Latex');

% Ecart angulaire sur la direction estimee par MV :
ecart_angulaire = min(abs(theta_estime-theta_0),abs(theta_estime-theta_0+pi));
ecart_angulaire = min(ecart_angulaire,abs(theta_estime-theta_0-pi));
disp(['D_perp estimee par MV : ecart angulaire = ' num2str(ecart_angulaire/pi*180,'%.2f') ' degres']);
