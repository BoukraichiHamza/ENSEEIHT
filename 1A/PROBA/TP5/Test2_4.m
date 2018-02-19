clear;
close all;

donnees;

% Calcul et affichage du centre de gravite :
G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
plot(G(1),G(2),'k*','MarkerSize',10,'LineWidth',2);

% Centrage des donnees :
x_centres = x_donnees - G(1);
y_centres = y_donnees - G(2);

% Resolution du systeme lineaire AX = B :
A(:,1) = transpose(x_donnees);
A(:,2) = ones(1,n);
B = transpose(y_donnees);

X = pinv(A)*B;
a_estime = X(1);
b_estime = X(2);

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

pas = 0.01;
% Affichage de la droite de regression estimee par resolution d'un systeme lineaire :
if abs(a_estime)<1
	x_regression1 = -taille:pas:taille;
	y_regression1 = a_estime*x_regression1+b_estime;
else
	y_regression1 = -taille:pas:taille;
	x_regression1 = (y_regression1-b_estime)/a_estime;
end


% Affichage de la droite de regression estimee par resolution d'un systeme lineaire :
if abs(sin_theta_estime)>abs(cos_theta_estime)
	x_regression2 = -taille:pas:taille;
	y_regression2 = (rho_estime-x_regression2*cos_theta_estime)/sin_theta_estime;
else
	y_regression2 = -taille:pas:taille;
	x_regression2 = (rho_estime-y_regression2*sin_theta_estime)/cos_theta_estime;
end

plot(x_regression1,y_regression1,'m-','LineWidth',2);
plot(x_regression2,y_regression2,'b-','LineWidth',2);
axis equal;
axis(echelle);
lg = legend('Donnees','Centre de gravite~~~','$D_\perp$ par MV','$D_{YX}$ par $AX = B$','Location','Best');
set(lg,'Interpreter','Latex');

%On peut en déduire que la qualité des deux droites sont similaires quelque
%soit la valeur de n choisie
