function [Q]=matrix_representation(A,n)
% Représentation sous forme de matrice du graphe Internet
% A contient les arcs du graphe orienté.
% n représente le nombre de sommets.
% Q est la matrice du graphe Internet.

% Initialisation
Q=zeros(n);

%Calcul des Nj
N=zeros(n,1);
for j=1:size(A,1)
    i=A(j,1);
    N(i)=N(i)+1;
end

%Construction de Q
for i=1:size(A)
    Q(A(i,2),A(i,1))=1/N(A(i,1));
end