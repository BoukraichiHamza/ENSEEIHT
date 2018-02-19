function [TGps,TRecep,X,Y,Z] = reception
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Reception du signal :
% function [TGps,TRecep,X,Y,Z] = mesure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sortie :
%	TGps : vecteur colonne de taille le nombre de satellites visibles
%		indiquant le temps GPS à l'émission du signal
%	TRecep : vecteur colonne de taille le nombre de satellites visibles
%		indiquant le temps Recepteur à la réception du signal
%	X : vecteur colonne de taille le nombre de satellites visibles
%		indiquant la coordonnée X des satellites visibles
%	Y : vecteur colonne de taille le nombre de satellites visibles
%		indiquant la coordonnée Y des satellites visibles
%	Z : vecteur colonne de taille le nombre de satellites visibles
%		indiquant la coordonnée Z des satellites visibles
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


global c  Pexacte COORDSAT  nbvisi  indvisi  t  tgps sigma;

%c = 2.99792458e8; % Vitesse de la lumiere

% Distance reelle ut-sat (sans erreur de mesure, sans biais d'horloge)
SAT = COORDSAT(:,indvisi);

TGps = t * ones(nbvisi,1); 
for i=1:nbvisi,
	D = norm( (SAT(:,i)-Pexacte(1:3)) , 2 );
	TRecep(i,1) = TGps(i,1) + D/c + Pexacte(4,1);
end;
EPS = zeros(nbvisi,1);
EPS = normrnd(0,sigma,nbvisi,1);
X = COORDSAT(1,indvisi)' + EPS;
EPS = normrnd(0,sigma,nbvisi,1);
Y = COORDSAT(2,indvisi)' + EPS;
EPS = normrnd(0,sigma,nbvisi,1);
Z = COORDSAT(3,indvisi)' + EPS;

