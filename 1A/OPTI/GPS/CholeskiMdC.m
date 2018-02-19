function alpha = CholeskiMdC( A, b );

% R�solution du probl�me de moindres carr�s lin�aire : 
% Min_{alpha} || b - A*alpha ||^2
% par factorisation de Choleski du syst�me des �quations normales

S = A'*A;

% V�rification au pr�alable du conditionnement du syst�me et de la stabilit�
% num�rique de la r�solution qui va suivre
c = cond(S);
if (c > 1e16)
    disp(['Attention : le conditionnement de la matrice des �quations'])
    disp(['            normales est tr�s grand ---> ', num2str(c,'%0.5g')])
end

% Factorisation suivi de la r�solution:
R = chol(S);
y = A'*b;
z = R'\y;
alpha = R\z;

return