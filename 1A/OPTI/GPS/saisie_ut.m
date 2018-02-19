% Coordonnies utilisateur :
LON_UT_DEP = 100; LAT_UT_DEP = 45; H_UT_DEP = 350;
LON_UT_AR = 300;  LAT_UT_AR = -25; H_UT_AR = 8000;

LON_UT_DEP = input('Longitude de départ (degre):');
LAT_UT_DEP = input('Latitude de départ (degre):');
H_UT_DEP = input('Altitude de départ (m):');
LON_UT_AR = input('Longitude d arrivée (degre):');
LAT_UT_AR = input('Latitude d arrivée (degre):');
H_UT_AR = input('Altitude d arrivée (m):');

LON_UT = LON_UT_DEP;
LAT_UT = LAT_UT_DEP;
H_UT = H_UT_DEP;


LON_UT = LON_UT*CDR;
LAT_UT = LAT_UT*CDR;
LON_UT_DEP = LON_UT_DEP*CDR;
LAT_UT_DEP = LAT_UT_DEP*CDR;
LON_UT_AR = LON_UT_AR*CDR;
LAT_UT_AR = LAT_UT_AR*CDR;


PAS_LON = (LON_UT_AR - LON_UT_DEP)/ NBIT;
PAS_LAT = (LAT_UT_AR - LAT_UT_DEP)/ NBIT;
PAS_H = (H_UT_AR - H_UT_DEP)/ NBIT;

DUT_DEP = H_UT_DEP+6378136;
DUT_AR = H_UT_AR+6378136;

IT = 0;
position_ut;
init_pos;
POSINIT = P0;

figure(1);
hold on;
plot([LON_UT_DEP*CRD LON_UT_AR*CRD],[LAT_UT_DEP*CRD LAT_UT_AR*CRD],'g-');
plot(LON_UT*CRD,LAT_UT*CRD,'g*');
lons = fix(sort([LON_UT,LON_INI]*CRD));
lats = fix(sort([LAT_UT,LAT_INI]*CRD));
lons(1) = lons(1)-s;
lons(2) = lons(2)+s;
lats(1) = lats(1)-s;
lats(2) = lats(2)+s;
plot([lons(1) lons(1) lons(2) lons(2) lons(1)],[lats(1) lats(2) lats(2) lats(1) lats(1)],'k-.');



LON_SOL = [];
LAT_SOL = [];
PSOL = [];
%hdl2=figure(2); clf;
%set(hdl2,'Position',[680 35 180*2 180*2]);
%affichage_zoom;

