function [P]=columnstochastic_matrix(Q)
% Modification par une matrice de rang 1 afin d'obtenir une matrice
% stochastique par colonne
% Q est la matrice carr?e du graphe d'internet. 
% P est la matrice carr?e du graphe d'internet modifi?.


% Initialisation
n=length(Q(:,1));
P=Q;
e=ones(n,1);
d=zeros(n,1);


%Creation du vecteur d
for i=1:size(Q)
    if prod(Q(:,i)==0)==1
        d(i)=1;
    else
    d(i)=0;
    end
end

%Remplissage de la matrice P
Paux=e*d';
P=Q+1/n*Paux;
end