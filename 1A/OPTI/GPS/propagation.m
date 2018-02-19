global c  Pexacte  COORDSAT  nbvisi  indvisi  t  tgps sigma;

indvisi = [];
tgps = t;
for sat=1:NBSAT,

   % Propagation des satellites
   D = w*tgps + M0(sat);
   DTMP = D;
   D=mod(D,2*pi);
   if ((D>=0) & (D<=pi/2))
      D2 = 0;
   elseif ((D<=pi) & (D>pi/2))
      D2 = pi;
   elseif ((D>pi) & (D<=3*pi/2))
      D2 = -pi;
   else
      D2 = 0;
   end;
   D=DTMP;

   % Calcul longitude, latitude
   LAT = asin(sin(incl)*sin(D));
   LON = OMEGA(sat)-We*tgps+atan(tan(D)*cos(incl))+D2;
   LON = LON+2*pi;
   LON=mod(LON,2*pi);
      
   % Coord (X,Y,Z) du satellite en rephre giocentrique
   r_sat = a*cos(LAT);
   CSAT(1,1) = r_sat*cos(LON); % X
   CSAT(2,1) = r_sat*sin(LON); % Y
   CSAT(3,1) = a*sin(LAT); % Z

   LONS(sat) = LON;
   LATS(sat) = LAT;
   COORDSAT(:,sat) = CSAT;
end;

