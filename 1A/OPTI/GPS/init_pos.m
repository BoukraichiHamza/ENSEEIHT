%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de la position de l'utilisateur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Tirage d'un point initial proche de la solution
P0 = Pexacte;
EPS = [normrnd(0,200000,3,1);0];
P0 = P0 + EPS;
P0(4,1) = 0;
LAT_INI = asin(P0(3,1)/norm(P0(1:3,1),2));
LON_INI = acos(P0(1,1)/norm(P0(1:2,1),2));
if ( P0(2,1) < 0 )
	LON_INI = 2*pi - LON_INI;
end;

