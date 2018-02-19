function Us=compute_subspace(D,PrecApprox)
% Cette fonction caclule le sous-espace dominant
% associe aux donnees D
% D : matrice representant les multiples images d'un chiffre
% PrecApprox : precision de l'approximation souhaitee
% Us : Sous-espace dominant associ� � D

%TO DO
[n,p] = size(D);
Us=zeros(n,p);
[U,S,V]=svd(D);
k=1;
O=S^2;
b=trace(O);
i=1;
while k>=PrecApprox
        Us(:,i)=S(i)*U(:,i)*V(:,i)';
    k=1-(trace((Us-D)*(Us-D)'))/b;
    i=i+1;
end    
    
end
