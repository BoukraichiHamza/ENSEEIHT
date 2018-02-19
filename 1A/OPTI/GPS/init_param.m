global c  Pexacte  COORDSAT  nbvisi  indvisi  t  tgps sigma;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definition des constantes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
CDR = pi/180; % Conversion degres -> radians
CRD = 180/pi; % Conversion radians -> degres
Re = 6378136; % Rayon equatoriale (m)
mu=3.986005e14; % Constante gravitationnelle (m^3/s^2)
We = 7.2921151467e-5; % Vitesse angulaire de la terre (rad.s^(-1))
c = 2.99792458e8; % Vitesse de la lumiere

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres de la simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
NBIT = 20;
PAS = 300; % Pas de temps de la simulation (s)
DEBUT = 0; % Temps debut simulation (s)
FIN = PAS*NBIT; % Temps fin simulation (s)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres de la lois sur les erreures de mesure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Les moyennes sont nulles
BH = 100; % ecart type sur le Biais d'horloge 
sigma = 50; % ecart type sur la mesure de distance.
% Temps GPS :
tgps = DEBUT;
trecep = tgps + BH;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Parametres de la constellation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ELEVMIN = 5*CDR; % Elevation minimale
NBSAT = 24; % Nombre de satellites
incl = 55*CDR; % Inclinaison du plan orbital (rad)
h=20183614; % Altitude des satellites
a=h+Re; % a=h+Re; demi grand axe de l'orbite (m)
CONST = walker(24,6,1,a,0,incl,0,Re,0); % Calcul des parametres de la constellation
M0 = CONST(:,6)'; % Anomalie moyenne initiale (rad)
OMEGA = CONST(:,5)'; % Ascension droite du noeud ascendant (rad)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialisation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% intialisation de la figure
hdl=figure(1); clf;
set(hdl,'Position',[5 35 340*2 180*2]);
axis([0 360 -90 90]);
hold on;

% chargement de la carte
load 'worldmap.bin';
worldmap(:,1) = worldmap(:,1)+180;
hdlp=plot(worldmap(:,1),worldmap(:,2),'black.');
set(hdlp,'MarkerSize',1);


% Taille du zoom en degrés
s = 6;





