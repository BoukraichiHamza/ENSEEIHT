function alpha = CholeskiMdC( A, b );

% Résolution du problème de moindres carrés linéaire : 
% Min_{alpha} || b - A*alpha ||^2
% par factorisation de Choleski du système des équations normales

S = A'*A;

% Vérification au préalable du conditionnement du système et de la stabilité
% numérique de la résolution qui va suivre
c = cond(S);
if (c > 1e16)
    disp(['Attention : le conditionnement de la matrice des équations'])
    disp(['            normales est très grand ---> ', num2str(c,'%0.5g')])
end

% Factorisation suivi de la résolution:
R = chol(S);
y = A'*b;
z = R'\y;
alpha = R\z;

return