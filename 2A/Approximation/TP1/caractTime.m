function T = caractTime(X,Y)
%% Initialisation de la taille
n = size(X,2);
T = zeros(4,n);
P = [ X , Y ];

%% Initialisation de la premiere valeur
% T(1,:) == Caractérisation uniforme
% T(1,:) == Caractérisation selon la longueur des segments
% T(1,:) == Caractérisation selon la racine carré de la longueur des
% segments
% T(1,:) == Caractérisation selon les abscisses de Tchebychev
T(:, 1) = [0; 0; 0; cos(pi / (2 * n + 2))];

%% Calcul du reste des valeurs
for i = 2:n
    T(1,i) = i/n;
    T(2, i) = T(2, i-1) + norm(P(:, i) - P(:, i-1));
    T(3, i) = T(3, i-1) + sqrt(norm(P(:, i) - P(:, i-1)));
    T(4, i) = cos((2 * (i - 1) + 1) * pi / (2 * n + 2));
end
end