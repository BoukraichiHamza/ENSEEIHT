LAT_INI = asin(P0(3,1)/norm(P0(1:3,1),2));
LON_INI = acos(P0(1,1)/norm(P0(1:2,1),2));
if ( P0(2,1) <0 )
	LON_INI = 2*pi - LON_INI;
end;
bl = 'b';
colorsat(1:NBSAT) = bl(ones(1,NBSAT));
colorsat(indvisi) = 'r';
hold off;
hdlp=plot(worldmap(:,1),worldmap(:,2),'black.');
set(hdlp,'MarkerSize',1);
hold on;
plot(LON_UT*CRD,LAT_UT*CRD,'Marker','p','Color','k','MarkerFaceColor','g','MarkerSize',12);
plot([LON_UT_DEP*CRD LON_UT_AR*CRD],[LAT_UT_DEP*CRD LAT_UT_AR*CRD],'g-');
aff_cercle_visi(LON_UT,LAT_UT,DLON,DLAT_VIS,'r-');
% Affichage des satellites
for sat=1:NBSAT,
	plot(LONS(sat)*CRD,LATS(sat)*CRD,'Marker','d','Color',colorsat(sat),'MarkerFaceColor',colorsat(sat));
%   aff_cercle_visi(LONS(sat),LATS(sat),DLON,DLAT_VIS,[colorsat(sat) '.']);
end
lons = fix(sort([LON_UT,LON_INI]*CRD));
lats = fix(sort([LAT_UT,LAT_INI]*CRD));
lons(1) = lons(1)-s;
lons(2) = lons(2)+s;
lats(1) = lats(1)-s;
lats(2) = lats(2)+s;
plot([lons(1) lons(1) lons(2) lons(2) lons(1)],[lats(1) lats(2) lats(2) lats(1) lats(1)],'k-.');

drawnow;


