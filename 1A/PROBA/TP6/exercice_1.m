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

% Parametres de l'algorithme RANSAC :
k_max = floor(nchoosek(nb_donnees,2)/2);
seuil_distance = 4;
seuil_proportion = 0.5;

% Boucle pour calculer les ecarts angulaires moyens :
nb_essais = 20;
ecarts_angulaires_L2 = zeros(nb_essais,nb_max_donnees_aberrantes);
ecarts_angulaires_D_perp_RANSAC = zeros(nb_essais,nb_max_donnees_aberrantes);
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

		% Insertion d'une ordonnee aberrante :
		x_donnees(j) = taille*(2*rand-1);
		y_donnees(j) = taille*(2*rand-1);

		% Estimation L2 de D_perp et calcul de l'ecart angulaire :
		[cos_theta_L2,sin_theta_L2,rho_L2] = estimation_n(x_donnees,y_donnees);
		theta_L2 = atan(sin_theta_L2/cos_theta_L2);
		ecart_angulaire_L2 = min(abs(theta_L2-theta_0),abs(theta_L2-theta_0+pi));
		ecart_angulaire_L2 = min(ecart_angulaire_L2,abs(theta_L2-theta_0-pi));
		ecarts_angulaires_L2(i,j) = ecart_angulaire_L2;

		% Algorithme RANSAC :
		critere_min = Inf;
		cos_theta_RANSAC = 0;
		sin_theta_RANSAC = 0;
		for k = 1:k_max
			% Tirage aleatoire de deux points du nuage :
			i_rand = randi(nb_donnees,1,2);
			while i_rand(1)==i_rand(2)
				i_rand = randi(nb_donnees,1,2);
			end

			% Parametres de la droite definie par ces deux points :
			[cos_theta_2,sin_theta_2,rho_2] = estimation_2(x_donnees(i_rand),y_donnees(i_rand));

			% Detection des donnees conformes au modele :
			indices_conformes = find(abs(cos_theta_2*x_donnees+sin_theta_2*y_donnees-rho_2*ones(1,nb_donnees))< seuil_distance);

			% Test pour savoir si la droite est selectionnee :
			if length(indices_conformes)/nb_donnees >=seuil_proportion
				x_donnees_conformes = x_donnees(indices_conformes);
				y_donnees_conformes = y_donnees(indices_conformes);
				[cos_theta_n,sin_theta_n,rho_n] = estimation_n(x_donnees_conformes,y_donnees_conformes);
				residus_donnees_conformes = cos_theta_n*x_donnees_conformes+sin_theta_n*y_donnees_conformes-rho_n*ones(1,length(x_donnees_conformes));
                critere = mean(residus_donnees_conformes.^2);
				if critere<critere_min
					critere_min = critere;
					cos_theta_RANSAC = cos_theta_n;
					sin_theta_RANSAC = sin_theta_n;
				end
			end
		end

		% Ecart angulaire sur la direction de la droite D_perp estimee par RANSAC :
		theta_RANSAC = atan(sin_theta_RANSAC/cos_theta_RANSAC);
		ecart_angulaire_RANSAC = min(abs(theta_RANSAC-theta_0),abs(theta_RANSAC-theta_0+pi));
		ecart_angulaire_RANSAC = min(ecart_angulaire_RANSAC,abs(theta_RANSAC-theta_0-pi));
		ecarts_angulaires_RANSAC(i,j) = ecart_angulaire_RANSAC;
	end
end

% Calcul des ecarts angulaires moyens (EAM) :
EAM_L2 = mean(ecarts_angulaires_L2)/pi*180;
EAM_RANSAC = mean(ecarts_angulaires_RANSAC)/pi*180;

% Affichage des courbes :
figure('Name','Estimation robuste par l''algorithme RANSAC','Position',[0,0,L,0.67*H]);
hold on;
hx = xlabel('Proportion de donnees aberrantes','FontSize',20);
set(hx,'Interpreter','Latex');
hy = ylabel('Ecart angulaire moyen (en degres)','FontSize',20);
set(hy,'Interpreter','Latex');
proportions = [1:nb_donnees]./[nb_donnees+1:2*nb_donnees];
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_L2,'r-','LineWidth',2);
plot(100*valeurs_donnees_aberrantes/nb_donnees,EAM_RANSAC,'g-','LineWidth',2);
drawnow;
lg = legend('Moindres carres','RANSAC');
set(lg,'Interpreter','Latex','Location','Best','Box','Off');
