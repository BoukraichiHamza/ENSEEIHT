% premiere etape : Lancer platine, demander 1, choisir scene1, puis arreter
% platine
nurbs = T(1).nurbs; % recuperation des caracteristiques de la trajectoire du premier robot
figure(1), clf, hold on, set(gca,'YDir','reverse'); nrbplot(nurbs,subd,'m'); %affichage de cette nurbs
coefs = nurbs.coefs;

for i=1:size(coefs,2)
    figure(1),hold on,
    plot(coefs(1,i)/coefs(4,i),coefs(2,i)/coefs(4,i),'b*') % affichage des points de controle
    % coefs(4,i) donne le poids associe au point numero i. Les coordonnees
    % reelles de Pi sont donnees par la formule :
    % Pi = (xi,yi,zi) = (coefs(1,i)/coefs(4,i), coefs(2,i)/coefs(4,i), coefs(3,i)/coefs(4,i))
    % NB : zi = 0 quelque soit i, puisqu'on est dans le plan.
end
% Maintenant, on relache le point de controle 6, et on force le 5;

nurbs2 = nurbs;
nurbs2.coefs(:,5) = nurbs.coefs(:,5)*2;
nurbs2.coefs(:,6) = nurbs.coefs(:,6)/2;

% Affichage de cette nouvelle nurbs sur la meme figure que la premiere :
figure(1), hold on, nrbplot(nurbs2,subd,'k-.')

% On voit que la modif est tres locale

