
function aff_cercle_visi(LON,LAT,DLON,DLAT,col)


CRD = 180/pi;

s=size(DLON,2);
LON_VIS(1,:) = LON+DLON;
LON_VIS(2,:) = LON-DLON;
%if ((min(LON_VIS(:) < 0) | (max(LON_VIS(:)>2*pi))



DLAT2 = DLAT(1,s:-1:1);


%plot([LON_VIS(1,:) LON_VIS(2,:) LON_VIS(1,1)]*CRD,([DLAT DLAT2 DLAT(1)]+LAT)*CRD,col);

LATV = DLAT+LAT;

INDLAT = find(LATV>pi/2);
LATV(INDLAT) = pi-LATV(INDLAT);
LON_VIS(:,INDLAT) = LON_VIS(:,INDLAT)+pi;

INDLAT = find(LATV< (-pi/2));
LATV(INDLAT) = -pi-LATV(INDLAT);
LON_VIS(:,INDLAT) = LON_VIS(:,INDLAT)+pi;
LON_VIS(2,:) = LON_VIS(2,s:-1:1);

LON_VIS = LON_VIS+2*pi;
LON_VIS = modulo(LON_VIS,2*pi);

LATV2 = LATV(s:-1:1);

plot(LON_VIS(1,:)*CRD,LATV*CRD,col);
plot(LON_VIS(2,:)*CRD,LATV2*CRD,col);
%plot([LON_VIS(1,1) LON_VIS(2,1)]*CRD,[LATV2(1) LATV2(1)]*CRD,col);
