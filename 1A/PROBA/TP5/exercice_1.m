clear;
close all;

donnees;

% Calcul et affichage du centre de gravite :
G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
plot(G(1),G(2),'k*','MarkerSize',10,'LineWidth',2);

% Centrage des donnees :
x_centres = x_donnees - G(1);
y_centres = y_donnees - G(2);

% Maximisation de la vraisemblance par tirages aleatoires de psi :
nombre_tirage = 1000;
psi_test = (pi/2)*(2*rand(1,nombre_tirage)-1);
arguments = [];
for k = 1:nombre_tirage
	arguments = [arguments , sum((y_centres - tan(psi_test(k))*x_centres).^2)];
end
[argument_min,indice_min] = min(arguments);
psi_estime = psi_test(indice_min);
a_estime = tan(psi_estime);
b_estime = mean(y_donnees - a_estime*x_donnees);

% Affichage de la droite de regression estimee par MV :
pas = 0.01;
if abs(a_estime)<1
	x_regression = -taille:pas:taille;
	y_regression = a_estime*x_regression+b_estime;
else
	y_regression = -taille:pas:taille;
	x_regression = (y_regression-b_estime)/a_estime;
end
plot(x_regression,y_regression,'b-','LineWidth',2);
axis equal;
axis(echelle);
lg = legend('Donnees','Centre de gravite~~~','$D_{YX}$ par MV','Location','Best');
set(lg,'Interpreter','Latex');

% Ecart angulaire sur la direction estimee par MV :
theta_estime = psi_estime+pi/2;
ecart_angulaire = min(abs(theta_estime-theta_0),abs(theta_estime-theta_0+pi));
ecart_angulaire = min(ecart_angulaire,abs(theta_estime-theta_0-pi));
disp(['D_YX estimee par MV : ecart angulaire = ' num2str(ecart_angulaire/pi*180,'%.2f') ' degres']);
