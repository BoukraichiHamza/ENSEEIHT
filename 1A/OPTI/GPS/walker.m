function CONST=walker(T,P,F,a,e,i,w,RE,v)
%function CONST=walker(T,P,F,a,e,i,w,RE,v)

CDR = pi/180;

CONST = zeros(T,12);
CONST(:,1) = a + RE; % a (m)
CONST(:,2) = e; % e
CONST(:,3) = i*CDR; % i (rad)
CONST(:,4) = w; % w


for j=1:P,
	DM = (j-1)*2*pi*F/T;
	ab = (j-1)*2*pi/P;
	CONST(1+(j-1)*T/P:j*T/P,5) = ab;
	for k=1:T/P,
		or = mod(DM+(k-1)*2*pi*P/T,2*pi);
		CONST(k+(j-1)*T/P,6) = or;
	end
end

if (v==1)
	figure('Position',[0 0 2*360 360]);
	axis([0 2*pi 0 2*pi]);
	plot(CONST(:,5),CONST(:,6),'r.');
end;

