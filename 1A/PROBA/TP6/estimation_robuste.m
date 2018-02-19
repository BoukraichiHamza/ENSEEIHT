clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

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

% Parametres des fonctions phi :
alpha = 1;
alpha_carre = alpha*alpha;
beta = 1;
beta_carre = beta*beta;

% Boucle pour calculer les ecarts angulaires moyens :
nb_essais = 100;
ecarts_angulaires_L2 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_phi_1 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_phi_2 = zeros(nb_essais,nb_max_donnees_aberrantes);
for i = 1:nb_essais

	% Tirage aleatoire de la direction d'une droite passant par l'origine :
	theta_0 = pi*rand;
	cos_theta_0 = cos(theta_0);
	sin_theta_0 = sin(theta_0);

	% Tirage aleatoire de points sur cette droite :
	if abs(cos_theta_0)<abs(sin_theta_0)
		abscisse_min = -taille;
		abscisse_max = taille;
		x_donnees = abscisse_min+(abscisse_max-abscisse_min)*rand(1,nb_donnees);
		y_donnees = -cos_theta_0*x_donnees/sin_theta_0;
	else
		ordonnee_min = -taille;
		ordonnee_max = taille;
		y_donnees = ordonnee_min+(ordonnee_max-ordonnee_min)*rand(1,nb_donnees);
		x_donnees = -sin_theta_0*y_donnees/cos_theta_0;
	end

	% Bruit gaussien ajoute aux abscisses et aux ordonnees :
	x_donnees = x_donnees+sigma*randn(1,nb_donnees);
	y_donnees = y_donnees+sigma*randn(1,nb_donnees);

	for j = 1:nb_max_donnees_aberrantes

		% Insertion d'une abscisse aberrante et d'une ordonnee aberrante :
		x_donnees(j) = taille*(2*rand-1);
		y_donnees(j) = taille*(2*rand-1);

		% Centrage des donnees :
		G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
		x_donnees_centrees = x_donnees-G(1);
		y_donnees_centrees = y_donnees-G(2);

		% Droite D_perp estimee par les moindres carres :
		residus_L2 = cos_theta*x_donnees_centrees+sin_theta*y_donnees_centrees;
		residus_L2_carre = residus_L2.*residus_L2;
		arguments_L2 = sum(residus_L2_carre,2);
		[minimum_L2,indice_min_L2] = min(arguments_L2);
		theta_L2 = valeurs_theta(indice_min_L2);
		ecart_angulaire_L2 = min(abs(theta_L2-theta_0),abs(theta_L2-theta_0+pi));
		ecart_angulaire_L2 = min(ecart_angulaire_L2,abs(theta_L2-theta_0-pi));
		ecarts_angulaires_L2(i,j) = ecart_angulaire_L2;

		% Droite D_perp estimee par la fonction phi_1 :
		arguments_phi_1 = sum(sqrt(residus_L2_carre+alpha_carre),2);
		[minimum_phi_1,indice_min_phi_1] = min(arguments_phi_1);
		theta_phi_1 = valeurs_theta(indice_min_phi_1);
		ecart_angulaire_phi_1 = min(abs(theta_phi_1-theta_0),abs(theta_phi_1-theta_0+pi));
		ecart_angulaire_phi_1 = min(ecart_angulaire_phi_1,abs(theta_phi_1-theta_0-pi));
		ecarts_angulaires_phi_1(i,j) = ecart_angulaire_phi_1;

		% Droite D_perp estimee par la fonction phi_2 :
		arguments_phi_2 = sum(log(residus_L2_carre+beta_carre),2);
		[minimum_phi_2,indice_min_phi_2] = min(arguments_phi_2);
		theta_phi_2 = valeurs_theta(indice_min_phi_2);
		ecart_angulaire_phi_2 = min(abs(theta_phi_2-theta_0),abs(theta_phi_2-theta_0+pi));
		ecart_angulaire_phi_2 = min(ecart_angulaire_phi_2,abs(theta_phi_2-theta_0-pi));
		ecarts_angulaires_phi_2(i,j) = ecart_angulaire_phi_2;
	end
end

% Calcul des ecarts angulaires moyens (EAM) :
EAM_L2 = mean(ecarts_angulaires_L2)/pi*180;
EAM_phi_1 = mean(ecarts_angulaires_phi_1)/pi*180;
EAM_phi_2 = mean(ecarts_angulaires_phi_2)/pi*180;

% Affichage des courbes :
figure('Name','Influence des donnees aberrantes sur l''estimation des droites de regression','Position',[0,0,L,0.67*H]);
hold on;
hx = xlabel('Proportion de donnees aberrantes','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('Ecart angulaire moyen (en degres)','FontSize',20);
set(hy,'Interpreter','Latex');
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_L2,'r-','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_phi_1,'g-','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_phi_2,'b-','LineWidth',2);
lg = legend('$L_2$','$\phi_1$','$\phi_2$');
set(lg,'Interpreter','Latex','Location','Best','Box','Off');
