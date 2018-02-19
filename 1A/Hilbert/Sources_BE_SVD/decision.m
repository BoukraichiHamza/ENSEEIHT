function d = decision( U, C )
% Fonction calculant la norme de la composante de C dans l'orthogonal de l'espace
% engendre par les colonnes de U.
% U : matrice orthogonale
% C : vecteur contenant l'image du chiffre � d�terminer
% d : norme de la composante de C dans l'orthogonal de l'espace engendre par les colonnes de U

% Initialisation
p=size(U,1);
I=diag(1,p);
N=zeros(1,p);
k=1;

%calcul de la norme d et récupération du rang de la plus petite valeur
for i=1:p
    N(i)=norm((I-(U(:,i)*U(:,i)')*C),2)/norm(C,2);
    if N(i)<N(k)
        k=i;
    end
end
%Recupération de la classe associé à la plus petite valeur
d=U(k);

end

