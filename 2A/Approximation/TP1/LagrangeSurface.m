function [V,H,W] = LagrangeSurface(U,S,T,Grille)
l = size(Grille,2);
n = size(U,2);
P1ligne = ones(l,n);
P2ligne = ones(l,n);
P3ligne = ones(l,n);
%% Interpolation des lignes de la grille
for i = 1:l
    for j = 1:n
    P1ligne(i,j) = InterpolationLagrange(U(j),T,Grille(i,:,1));
    P2ligne(i,j) = InterpolationLagrange(U(j),T,Grille(i,:,2));
    P3ligne(i,j) = InterpolationLagrange(U(j),T,Grille(i,:,3));
    end
end

%% Interpolation de la colonne resultat
for j = 1:n
    V(j) = InterpolationLagrange(U(j),S,P1ligne(:,j));
    H(j) = InterpolationLagrange(U(j),S,P2ligne(:,j));
    W(j) = InterpolationLagrange(U(j),S,P3ligne(:,j));
end