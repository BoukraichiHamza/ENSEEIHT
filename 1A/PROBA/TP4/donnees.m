clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres du cercle :
R_0 = 5;
taille = 20;
echelle = [-taille taille -taille taille];
C = (taille-R_0)*(2*rand(2,1)-1);

% Fenetre d'affichage :
figure('Name','Donnees situees au voisinage d''un cercle','Position',[0,0,0.5*L,0.6*H]);
axis equal;
hold on;
hx = xlabel('$x$','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('$y$','FontSize',20);
set(hy,'Interpreter','Latex');

% Affichage du cercle :
nb_points_cercle = 100;
theta_cercle = 2*pi/nb_points_cercle:2*pi/nb_points_cercle:2*pi;
xy_cercle = [R_0*cos(theta_cercle) ; R_0*sin(theta_cercle)]+C*ones(1,nb_points_cercle);
plot([xy_cercle(1,:) xy_cercle(1,1)],[xy_cercle(2,:) xy_cercle(2,1)],'r-','LineWidth',2);

% Donnees bruitees :
n = 20;
sigma = 0.5;
rho_donnees = R_0+sigma*randn(1,n);
theta_donnees = 2*pi*rand(1,n);
xy_donnees = C*ones(1,n)+[rho_donnees.*cos(theta_donnees) ; rho_donnees.*sin(theta_donnees)];

% Affichages :
plot(xy_donnees(1,:),xy_donnees(2,:),'b*');
axis(echelle);
legend('Cercle','Donnees','Location','Best');
