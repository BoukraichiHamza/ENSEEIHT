%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de la position de l'utilisateur
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

LON_UT = LON_UT_DEP + IT*PAS_LON;
LAT_UT = LAT_UT_DEP + IT*PAS_LAT;
H_UT = H_UT_DEP + IT*PAS_H;
DUT = H_UT+6378136;
r_ut = DUT*cos(LAT_UT);
Pexacte(1,1) = r_ut*cos(LON_UT); % X
Pexacte(2,1) = r_ut*sin(LON_UT); % Y
Pexacte(3,1) = DUT*sin(LAT_UT); % Z
Pexacte(4,1) = BH;
