clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres de la droite :
taille = 20;
marge = 5;
echelle = [-taille taille -taille taille];
theta_0 = pi*rand;
cos_theta_0 = cos(theta_0);
sin_theta_0 = sin(theta_0);
rho_0 = (taille-marge)*(2*rand-1);

% Fenetre d'affichage :
figure('Name','Estimation de droites de regression','Position',[0.2*L,0,0.6*L,H]);
axis equal;
hold on;
hx = xlabel('$x$','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('$y$','FontSize',20);
set(hy,'Interpreter','Latex');

% Extremites de la droite :
if abs(cos_theta_0)<abs(sin_theta_0)
	abscisse_min = -taille;
	ordonnee_min = (rho_0-abscisse_min*cos_theta_0)/sin_theta_0;
	abscisse_max = taille;
	ordonnee_max = (rho_0-abscisse_max*cos_theta_0)/sin_theta_0;
else
	ordonnee_min = -taille;
	abscisse_min = (rho_0-ordonnee_min*sin_theta_0)/cos_theta_0;
	ordonnee_max = taille;
	abscisse_max = (rho_0-ordonnee_max*sin_theta_0)/cos_theta_0;
end

% Donnees :
n = 100;
if abs(cos_theta_0)<abs(sin_theta_0)
	x_donnees = abscisse_min+(abscisse_max-abscisse_min)*rand(1,n);
	y_donnees = (rho_0-cos_theta_0*x_donnees)/sin_theta_0;
else
	y_donnees = ordonnee_min+(ordonnee_max-ordonnee_min)*rand(1,n);
	x_donnees = (rho_0-sin_theta_0*y_donnees)/cos_theta_0;
end
sigma = 2;
x_donnees = x_donnees+sigma*randn(1,n);
y_donnees = y_donnees+sigma*randn(1,n);
indices_visibles = find(x_donnees>-taille & x_donnees<taille & y_donnees>-taille & y_donnees<taille);
x_donnees = x_donnees(indices_visibles);
y_donnees = y_donnees(indices_visibles);
n = length(indices_visibles);		% Seuls les points à l'interieur du cadre sont comptabilises

% Affichages :
plot(x_donnees,y_donnees,'r*');
axis(echelle);
