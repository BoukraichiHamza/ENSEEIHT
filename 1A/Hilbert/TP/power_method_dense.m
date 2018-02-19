function [r]=power_method_dense(A,eps)
% Algorithme de la puissance it?r?e dans le cas "dense"
% A est la matrice dont on cherche le couple propre (r,lambda) associ? ? la plus
% grande valeur propre en module.
% eps est la pr?cision souhait?e (crit?re d'arr?t).

% Initialisation
n=length(A(:,1));
r=ones(n,1)./n;
q=A*r;
k=0;
%Calcul du vecteur propre
while norm(q-r,1)>=eps*norm(r,1) && k<=2000
    r=q/norm(q,1);
    q=A*r;
    k=k+1
end

end
