clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Parametres :
set(0,'RecursionLimit',1000);	% Pour eviter les erreurs a l'execution
alpha = 12;			% Seuil sur l'orientation du gradient (en degres)
alpha = pi/180*alpha;		% Seuil sur l'orientation du gradient (en radians)
cos_alpha = cos(alpha);
S = 2/sin(alpha);		% Seuil sur la norme du gradient (decoulant d'une etude theorique)

% Lecture de l'image :
% I = imread('Images/Morlaix.png');
I = imread('Images/Piree.png');
% I = imread('Images/chaises.png');
if size(I,3)==3
	I = rgb2gray(I);
end
I = imresize(I,0.8);
[nb_lignes,nb_colonnes] = size(I);

% Parametres :
diagonale = floor(sqrt(nb_lignes^2+nb_colonnes^2));
card_max = floor(diagonale/2);
card_min = floor(card_max/20);

% Affichage de l'image :
figure('Name','Ensembles candidats','Position',[0,0,L,0.67*H]);
subplot(1,2,1);
imagesc(I);
axis equal;
axis off;
colormap gray;
hold on;

% Gradient du niveau de gris (x vers la droite, y vers le bas) :
I = double(I);
[G_x,G_y] = gradient(I);
G_norme = sqrt(G_x.^2+G_y.^2);

% Selection des pixels de contour :
contour = G_norme>S;

% Pas de pixel de contour sur le bord de l'image => Traitement simplifie !
contour([1 nb_lignes],:) = 0;
contour(:,[1 nb_colonnes]) = 0;

% Tri des pixels de contour :
indices_contour = find(contour);
[valeurs_triees,indices] = sort(G_norme(indices_contour),'descend');
indices_contour = indices_contour(indices);

% Affichage d'une petite fleche sur les pixels de contour :
[i,j] = ind2sub(size(I),indices_contour);
quiver(j,i,G_x(indices_contour),G_y(indices_contour),'r');		% Attention : x = j et y = i
axis equal;
title('Pixels de contour','FontSize',20);
drawnow;

% Boucle de traitement des pixels de contour :
liste_E = [];
voisins = [-1 -1 ; -1 0 ; -1 1 ; 0 1 ; 1 1 ; 1 0 ; 1 -1 ; 0 -1];	% 8 plus proches voisins
while length(indices_contour)>0

	% Pixel dont la norme du gradient est la plus elevee = "germe" :
	indice_germe = indices_contour(1);
	[i_germe,j_germe] = ind2sub(size(I),indice_germe);
	contour(i_germe,j_germe) = 0;
	indices_contour = indices_contour(indices_contour~=indice_germe);
	E = [i_germe j_germe];

	% Construction recursive de l'ensemble E :
	[E,contour,indices_contour] = recursion(E,contour,indices_contour,...
				i_germe,j_germe,voisins,G_x,G_y,G_norme,card_max,cos_alpha);

	% Ajout de l'ensemble E a la liste d'ensembles E, si son cardinal est superieur a card_min :
	if size(E,1)>=card_min
		liste_E = [liste_E {E}];				% Ajout d'une cellule a liste_E
	end
end

% Affichage des ensembles E (la fonction label2rgb donne a chaque ensemble E une couleur differente) :
etiquette = zeros(size(I));
for k = 1:length(liste_E)
	E = liste_E{1,k};
	indices_E = sub2ind(size(I),E(:,1),E(:,2));
	etiquette(ind2sub(size(I),indices_E)) = k;
end
I_resultat = label2rgb(etiquette,'jet',[0.5 0.5 0.5]);
subplot(1,2,2);
imagesc(I_resultat);
axis equal;
axis off;
title('Ensembles candidats','FontSize',20);

save exercice_1;
