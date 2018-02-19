function [r]=power_method_sparse(Q,v,alpha,eps)
% Algorithme de la puissance it?r?e dans le cas "creux"
% Q est la matrice repr?sentative du graphe d'Internet.
% v est le vecteur de personalisation.
% alpha est le param?tre de poids.
% eps est la pr?cision souhait?e (crit?re d'arret).
% r est le vecteur propre assoic?e ? la valeur propre 1.

% Initialisation
n=length(Q(:,1));
r=ones(n,1)./n;

end