%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul du cercle de visibilite 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Rayon du cercle de visibiliti (THETA)
phi = asin(cos(ELEVMIN)/(1+h/Re));
THETA = pi/2 - phi - ELEVMIN;

T=2*pi*sqrt(a*a*a/mu); % Periode orbitale (s)
w=sqrt(mu/(a*a*a)); % vitesse angulaire du satellite (rad.s^(-1))


% Calcul des points extremes du cercle de visibilite
i=0;
DLAT_VIS=[-THETA:0.01:THETA];
for LAT_VIS=DLAT_VIS,
	i=i+1; 
	DLAT = abs(LAT_VIS);
	t2 = sin(THETA)^2;
	sdlat = sin(DLAT)^2;
	DLON(i)=asin(sqrt(abs((t2-(sin(DLAT))^2)/((cos(DLAT))^2))));
end;

