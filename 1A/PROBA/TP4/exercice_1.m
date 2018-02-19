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

% Tirage aleatoire uniforme de C :
nb_tirages = 10000;
C_test = taille*(2*rand(2,nb_tirages)-1);
arguments = [];
for k = 1:nb_tirages
    X = (xy_donnees(1,:) - C_test(1,k)).^2;
    Y = (xy_donnees(2,:) - C_test(2,k)).^2;
	arguments = [arguments , sum((sqrt(X+Y) - R_0).^2)];
end
[argument_min,indice_min] = min(arguments);
C_estime = [C_test(1,indice_min);C_test(2,indice_min)];
xy_cercle = [R_0*cos(theta_cercle) ; R_0*sin(theta_cercle)]+C_estime*ones(1,nb_points_cercle);
plot([xy_cercle(1,:) xy_cercle(1,1)],[xy_cercle(2,:) xy_cercle(2,1)],'g-','LineWidth',2);
legend('Donnees','Cercle estime','Location','Best');
