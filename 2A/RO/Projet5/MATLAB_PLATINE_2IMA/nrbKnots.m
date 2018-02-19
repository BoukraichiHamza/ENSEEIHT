function U= nrbKnots(n,order)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Cette fonction permet de g�n�rer un vecteur nodal
%       non p�riodique ( poss�dant des noeuds de multiplicit� > 1)
%    et non uniforme ( les valeurs nodales sont r�parties non uniform�ment)
%  input:
%        n= nombre des points de contr�le 
%        order: ordre de la NURBS 
%  output:
%        U: vecteur nodal non p�riodique et non uniforme
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N=n-1;%% N+1 points de contr�le
m=N+order; %% nombre des noeuds - 1: m = N+p+1 avec {p=degr� ( order= p+1), N+1 pts de contr�le, m+1 knots}
M=m+1;%%nombre des noeuds
%display (M);
%display(M-order);
U=zeros(1,M);
for i=1:M
    if ((i>order) && (i<=M-order))
        U(1,i)=i/M;
    elseif (i>M-order)
        U(1,i)=1;
    end
        
end