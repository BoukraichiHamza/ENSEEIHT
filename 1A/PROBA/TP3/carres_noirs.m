clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

valeurs_t = 1.5:0.1:5.5;
valeurs_p = 0.2:0.02:0.8;
[t,p] = meshgrid(valeurs_t,valeurs_p);
probas = power(p,t.*t);

% Calcul et affichage de la probabilite pour qu'un carre soit noir :
figure('Name','Probabilite pour qu''un carre de cote t soit noir','Position',[0,0,0.3*L,0.4*H]);
imagesc(valeurs_t,valeurs_p,probas);
colormap gray;
set(gca,'YDir','normal');
set(gca,'FontSize',10);
xlabel('Cote $t$ du carre','Interpreter','Latex','FontSize',20);
ylabel('Parametre $p$ de la loi','Interpreter','Latex','FontSize',20);
set(gca,'XTick',2:5);
set(gca,'YTick',0.2:0.1:0.8);
hold on;

% Affichage de courbes de niveau :
[C,h] = contour(valeurs_t,valeurs_p,probas,[0.1 0.01 0.001 0.0001],'LineColor','g','LineWidth',1);
text_handle = clabel(C,h);
set(text_handle,'Color','g','FontSize',10);

% Affichage d'images aleatoires contenant au moins un carre noir :
figure('Name','Images binaires aleatoires','Position',[0.3*L,0,0.7*L,H]);
numero_image = 1;
T = 64;
p = 0.5;
liste_valeurs_t = 2:5;
for t = liste_valeurs_t(1):liste_valeurs_t(end)

	% Affichage du point sur le graphique 1 :
	figure(1);
	plot(t,p,'rs','MarkerSize',4*t,'Linewidth',2);
	drawnow;

	% Tirage d'images aleatoires tant qu'aucun carre noir n'a ete detecte :
	aucun_carre_noir_detecte = 1;
	cpt_tirages = 0;
	while aucun_carre_noir_detecte

		% Tirage aleatoire d'une image :
		I = rand(T);
		I = I>p;

		% Detection des carres de cote t entierement noirs :
		J = zeros(T-t+1,T-t+1,t*t);
		for i = 1:t
			for j = 1:t
				k = (i-1)*t+j;
				J(:,:,k) = I(i:end-t+i,j:end-t+j);
			end
		end
		somme = sum(J,3);
		indices_carres_noirs = find(somme==0);
		if length(indices_carres_noirs)>0
			aucun_carre_noir_detecte = 0;
		end
		cpt_tirages = cpt_tirages+1;
	end

	% Affichage de l'image :
	figure(2);
	subplot(2,2,numero_image);
	numero_image = numero_image+1;
	imagesc(I);
	axis off;
	axis equal;
	colormap gray;
	set(gca,'FontSize',15);
	nb_carres = length(indices_carres_noirs);
	if nb_carres==1
		title(['Il y a 1 carre noir ' num2str(t) '$\times$' num2str(t) ' : le voyez-vous ?'],'Interpreter','Latex');
	else
		title(['Il y a ' num2str(nb_carres) ' carres noirs ' num2str(t) '$\times$' num2str(t) ' : les voyez-vous ?'],'Interpreter','Latex');
	end
	hold on;
	fprintf('Tapez un caractere pour surligner les carres noirs\n');
	pause;

	% Surlignage des carres de cote t entierement noirs :
	for k = 1:length(indices_carres_noirs)
		l = indices_carres_noirs(k);
		x = ceil(l/(T-t+1))-0.5;
		y = mod(l-1,T-t+1)+1-0.5;
		line([x,x],[y,y+t],'Color','r','Linewidth',2);
		line([x+t,x+t],[y,y+t],'Color','r','Linewidth',2);
		line([x,x+t],[y,y],'Color','r','Linewidth',2);
		line([x,x+t],[y+t,y+t],'Color','r','Linewidth',2);
	end
	if t<liste_valeurs_t(end)
		fprintf('Tapez un caractere pour afficher une nouvelle image\n');
		pause;
	end
end