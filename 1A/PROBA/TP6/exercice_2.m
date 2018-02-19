clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

donnees_aberrantes;

% Affichage des donnees :
figure('Name','Estimation d''un cercle par maximum de vraisemblance','Position',[0.5*L,0,0.5*L,0.6*H]);
axis equal;
hold on;
hx = xlabel('$x$','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('$y$','FontSize',20);
set(hy,'Interpreter','Latex');
plot(xy_donnees(1,:),xy_donnees(2,:),'b*');
axis(echelle);


% Parametres :
taille = 20;
nb_donnees = 50;
valeurs_donnees_aberrantes = 0:floor(nb_donnees/2);
nb_max_donnees_aberrantes = length(valeurs_donnees_aberrantes);
sigma = 2;


% Tirages aleatoires de valeurs de theta dans [0,pi] (c'est-a-dire de psi dans [-pi/2,pi/2]) :
nb_tirages = 100;
valeurs_theta = pi*rand(nb_tirages,1);
cos_theta = cos(valeurs_theta);
sin_theta = sin(valeurs_theta);

% Tirage aleatoire uniforme de C :
nb_tirages = 10000;
C_test = taille*(2*rand(2,nb_tirages)-1);
C_test = [C_test ; taille*rand(1,nb_tirages)];
arguments = [];
for k = 1:nb_tirages
    X = (xy_donnees(1,:) - C_test(1,k)).^2;
    Y = (xy_donnees(2,:) - C_test(2,k)).^2;
    
	arguments = [arguments , sum((sqrt(X+Y) - C_test(3,k)).^2)];
end
[argument_min,indice_min] = min(arguments);
C_estime = C_test(:,indice_min);
xy_cercle = [C_estime(3)*cos(theta_cercle) ; C_estime(3)*sin(theta_cercle)]+C_estime(1:2)*ones(1,nb_points_cercle);
plot([xy_cercle(1,:) xy_cercle(1,1)],[xy_cercle(2,:) xy_cercle(2,1)],'g-','LineWidth',2);
legend('Donnees','Cercle estime','Location','Best');
