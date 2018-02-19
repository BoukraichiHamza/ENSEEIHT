clear;
close all;

load exercice_1;

% Parametres :
p = alpha/pi;
epsilon = 1e-5;

% Affichage de l'image :
figure('Name','Detection des alignements','Position',[0,0,L,0.67*H]);
subplot(1,2,1);
imagesc(I);
axis equal;
axis off;
colormap gray;
title('L''image','FontSize',20);
drawnow;

% Affichage des alignements :
subplot(1,2,2);
imagesc(120*ones(size(I)),[0,255]);
axis equal;
axis off;
title('Son esquisse','FontSize',20);
hold on;

% Boucle sur les ensembles E :
cpt = 0;
for k = 1:length(liste_E)

	% Ensemble candidat numero k :
	E = liste_E{1,k};
	card_E = size(E,1);
	indices_E = sub2ind(size(I),E(:,1),E(:,2));

	% Centre de gravite C = (C_x,C_y) du nuage de points :
	E_x = E(:,2);			% Attention : x = j
	E_y = E(:,1);			% Attention : y = i
	poids = G_norme(indices_E);
	inverse_somme_poids = 1/sum(poids);
	C_x = inverse_somme_poids*sum(poids.*E_x);
	C_y = inverse_somme_poids*sum(poids.*E_y);

	% Centrage des donnees :
	E_x_centre = E_x-C_x;
	E_y_centre = E_y-C_y;

	% Matrice d'inertie du nuage de points :
	M_11 = inverse_somme_poids*sum(poids.*E_x_centre.*E_x_centre);
	M_12 = inverse_somme_poids*sum(poids.*E_x_centre.*E_y_centre);
	M_22 = inverse_somme_poids*sum(poids.*E_y_centre.*E_y_centre);
	M = [M_11 M_12 ; M_12 M_22];

	% Calcul des valeurs/vecteurs propres de M :
	[V,D] = eig(M);

	% Tri des valeurs propres de M par ordre decroissant :
	[lambda,indices] = sort(diag(D),'descend');

	% Matrice de passage du repere xy vers les axes propres du nuage de points :
	P = V(:,indices);
	petit_axe = P(:,2);

	% Nombre n de pixels de E ou le gradient est parallele au petit axe :
	n=0;
    for i=1:card_E
        if abs(G_x(E(i,1),E(i,2))*petit_axe(1) + G_y(E(i,1),E(i,2))*petit_axe(2)) > G_norme(E(i,1),E(i,2))*cos_alpha
            n=n+1 ;
        end 
    end

	% Coordonnees des points du nuage dans le repere des axes principaux :
	E_centre_bis = [E_x_centre E_y_centre]*P;

	% Dimensions du rectangle englobant :
	E_x_centre_bis = E_centre_bis(:,1);
	x_min_bis = min(E_x_centre_bis);
	x_max_bis = max(E_x_centre_bis);
	E_y_centre_bis = E_centre_bis(:,2);
	y_min_bis = min(E_y_centre_bis);
	y_max_bis = max(E_y_centre_bis);
	largeur_rectangle = x_max_bis-x_min_bis;
	hauteur_rectangle = y_max_bis-y_min_bis;

	% Nombre N de pixels du rectangle englobant :
	N=round(largeur_rectangle*hauteur_rectangle) ;

	% Calcul de probabilite (loi binomiale : cf. fonction binocdf) :
	proba=binocdf(N,N,p)-binocdf(n-1,N,p);

	% Test de saillance visuelle :
	if proba < epsilon					% Si l'evenement est suffisamment rare

		% Affichage du segment :
		extremites = P*[x_min_bis x_max_bis ; 0 0]+[C_x ; C_y]*ones(1,2);
		line(extremites(1,:),extremites(2,:),'Color','w','LineWidth',2);
		drawnow;
	else
		cpt = cpt+1;
	end
end
disp(['Sur ' num2str(length(liste_E)) ' ensembles candidats, ' num2str(cpt) ' ont ete elimines']);

