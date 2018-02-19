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
valeurs_psi = valeurs_theta-pi/2;
tangentes_psi = tan(valeurs_psi);

% Boucle pour calculer les ecarts angulaires moyens :
nb_essais = 100;
ecarts_angulaires_D_YX_1 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_D_YX_2 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_D_perp_1 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_D_perp_2 = zeros(nb_essais,nb_max_donnees_aberrantes);
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
	y_donnees_sauv = y_donnees;

	% Bruit gaussien ajoute aux ordonnees :
	y_donnees = y_donnees+sigma*randn(1,nb_donnees);

	for j = 1:nb_max_donnees_aberrantes

		% Ajout d'une ordonnee aberrante :
		nb_donnees_aberrantes = valeurs_donnees_aberrantes(j);
		y_donnees(j) = taille*(2*rand-1);

		% Centrage des donnees :
		G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
		x_donnees_centrees = x_donnees-G(1);
		y_donnees_centrees = y_donnees-G(2);

		% Droite D_YX estimee par MV :
		residus_YX = ones(nb_tirages,1)*y_donnees_centrees-tangentes_psi*x_donnees_centrees;
		arguments_YX = sum(residus_YX.*residus_YX,2);
		[minimum_YX,indice_min_YX] = min(arguments_YX);
		psi_YX = valeurs_psi(indice_min_YX);
		theta_YX = psi_YX+pi/2;
		ecart_angulaire_YX = min(abs(theta_YX-theta_0),abs(theta_YX-theta_0+pi));
		ecart_angulaire_YX = min(ecart_angulaire_YX,abs(theta_YX-theta_0-pi));
		ecarts_angulaires_D_YX_1(i,j) = ecart_angulaire_YX;

		% Droite D_perp estimee par MV :
		residus_perp = cos_theta*x_donnees_centrees+sin_theta*y_donnees_centrees;
		arguments_perp = sum(residus_perp.*residus_perp,2);
		[minimum_perp,indice_min_perp] = min(arguments_perp);
		theta_perp = valeurs_theta(indice_min_perp);
		ecart_angulaire_perp = min(abs(theta_perp-theta_0),abs(theta_perp-theta_0+pi));
		ecart_angulaire_perp = min(ecart_angulaire_perp,abs(theta_perp-theta_0-pi));
		ecarts_angulaires_D_perp_1(i,j) = ecart_angulaire_perp;
	end

	% Bruit gaussien ajoute aux abscisses et aux ordonnees :
	x_donnees = x_donnees+sigma*randn(1,nb_donnees);
	y_donnees = y_donnees_sauv+sigma*randn(1,nb_donnees);

	for j = 1:nb_max_donnees_aberrantes

		% Creation d'une abscisse aberrante et d'une ordonnee aberrante :
		nb_donnees_aberrantes = valeurs_donnees_aberrantes(j);
		x_donnees(j) = taille*(2*rand-1);
		y_donnees(j) = taille*(2*rand-1);

		% Centrage des donnees :
		G = transpose(mean([transpose(x_donnees),transpose(y_donnees)]));
		x_donnees_centrees = x_donnees-G(1);
		y_donnees_centrees = y_donnees-G(2);

		% Droite D_YX estimee par MV :
		residus_YX = ones(nb_tirages,1)*y_donnees_centrees-tangentes_psi*x_donnees_centrees;
		arguments_YX = sum(residus_YX.*residus_YX,2);
		[minimum_YX,indice_min_YX] = min(arguments_YX);
		psi_YX = valeurs_psi(indice_min_YX);
		theta_YX = psi_YX+pi/2;
		ecart_angulaire_YX = min(abs(theta_YX-theta_0),abs(theta_YX-theta_0+pi));
		ecart_angulaire_YX = min(ecart_angulaire_YX,abs(theta_YX-theta_0-pi));
		ecarts_angulaires_D_YX_2(i,j) = ecart_angulaire_YX;

		% Droite D_perp estimee par MV :
		residus_perp = cos_theta*x_donnees_centrees+sin_theta*y_donnees_centrees;
		arguments_perp = sum(residus_perp.*residus_perp,2);
		[minimum_perp,indice_min_perp] = min(arguments_perp);
		theta_perp = valeurs_theta(indice_min_perp);
		ecart_angulaire_perp = min(abs(theta_perp-theta_0),abs(theta_perp-theta_0+pi));
		ecart_angulaire_perp = min(ecart_angulaire_perp,abs(theta_perp-theta_0-pi));
		ecarts_angulaires_D_perp_2(i,j) = ecart_angulaire_perp;
	end
end

% Calcul des ecarts angulaires moyens (EAM) :
EAM_D_YX_1 = mean(ecarts_angulaires_D_YX_1)/pi*180;
EAM_D_perp_1 = mean(ecarts_angulaires_D_perp_1)/pi*180;
EAM_D_YX_2 = mean(ecarts_angulaires_D_YX_2)/pi*180;
EAM_D_perp_2 = mean(ecarts_angulaires_D_perp_2)/pi*180;

% Affichage des courbes :
figure('Name','Influence des donnees aberrantes sur l''estimation des droites de regression','Position',[0,0,L,0.67*H]);
hold on;
hx = xlabel('Proportion de donnees aberrantes','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('Ecart angulaire moyen (en degres)','FontSize',20);
set(hy,'Interpreter','Latex');
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_D_YX_1,'r-','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_D_perp_1,'g-','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_D_YX_2,'r-.','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_D_perp_2,'g-.','LineWidth',2);
lg = legend('$D_{YX}$ (ecarts au modele en $y$)','$D_\perp$ (ecarts au modele en $y$)',...
	'$D_{YX}$ (ecarts au modele en $x$ et en $y$)','$D_\perp$ (ecarts au modele en $x$ et en $y$)');
set(lg,'Interpreter','Latex','Location','Best','Box','Off');
