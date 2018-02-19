if (~isempty(PSOL))
	LAT_SOL = asin(PSOL(3,1)/norm(PSOL(1:3,1),2));
	LON_SOL = acos(PSOL(1,1)/norm(PSOL(1:2,1),2));
	if ( PSOL(2,1) <0 )
		LON_SOL = 2*pi - LON_SOL;
	end;
end;
LAT_INI = asin(P0(3,1)/norm(P0(1:3,1),2));
LON_INI = acos(P0(1,1)/norm(P0(1:2,1),2));
if ( P0(2,1) <0 )
	LON_INI = 2*pi - LON_INI;
end;

lons = fix(sort([LON_UT,LON_INI]*CRD));
lats = fix(sort([LAT_UT,LAT_INI]*CRD));
clf;
axis([ (lons(1)-s) (lons(2)+s) (lats(1)-s) (lats(2)+s)]);
hold on;
hdlp2=plot(worldmap(:,1),worldmap(:,2),'black.');
set(hdlp2,'MarkerSize',5);
plot(LON_UT*CRD,LAT_UT*CRD,'Marker','p','Color','k','MarkerFaceColor','g','MarkerSize',16);
plot(LON_INI*CRD,LAT_INI*CRD,'Marker','v','Color','c','MarkerFaceColor','c','MarkerSize',8);
if (~isempty(LON_SOL))
	plot(LON_SOL*CRD,LAT_SOL*CRD,'Marker','*','Color','m','MarkerFaceColor','m','MarkerSize',8);
end;

