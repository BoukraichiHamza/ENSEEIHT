function [V,S] = Neville(U,T,X,Y)
 n = size(X,2);

 if n < 2
     V = 0;
     S = 0;
 elseif n == 2
         V = ((T(2)-U)*X(1) + (U-T(1))*X(2))/(T(2)-T(1));
         S = ((T(2)-U)*Y(1) + (U-T(1))*Y(2))/(T(2)-T(1));
 else
     [Pgx,Pgy] = Neville(U,T(1:end-1),X(1:end-1),Y(1:end-1));
     [Pdx,Pdy] = Neville(U,T(2:end),X(2:end),Y(2:end));
     m = size(Pgx,2);
     for i = 1:m
     V(i) = ((T(end)-U(i))*Pgx(i) + (U(i)-T(1))*Pdx(i))/(T(end)-T(1));
     S(i) = ((T(end)-U(i))*Pgy(i) + (U(i)-T(1))*Pdy(i))/(T(end)-T(1));
     end
 end 
end