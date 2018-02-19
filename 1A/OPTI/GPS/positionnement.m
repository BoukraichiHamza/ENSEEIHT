function M = positionnement(M0,TGps,TRecep,X,Y,Z,c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Calcul de la position de l'utilisateur
% function M = positionnement(M0,TGps,TRecep,X,Y,Z,c)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Entrees :
%       M0 : point initial M0 = [X0,Y0,Z0,BH0]' (4x1)
%       TGps : vecteur colonne de taille le nombre de satellites visibles
%               indiquant le temps GPS � l'�mission du signal
%       TRecep : vecteur colonne de taille le nombre de satellites visibles
%               indiquant le temps Utilisateur � la r�ception du signal
%       X : vecteur colonne de taille le nombre de satellites visibles
%               indiquant la coordonn�e X des satellites visibles
%       Y : vecteur colonne de taille le nombre de satellites visibles
%               indiquant la coordonn�e Y des satellites visibles
%       Z : vecteur colonne de taille le nombre de satellites visibles
%               indiquant la coordonn�e Z des satellites visibles
%       c : vitesse de propagation du signal
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sortie :
%       M : point solution (4x1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% fonctions utiles :
%       test_convergence : 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Initialisations / recuperation des donnees
CoordSat = [X';Y';Z'];
NbSat = size(CoordSat,2);
Mn=M0;

NbIter = 0;
Critere = 0;

%Initialisation
jacobien = zeros(NbSat,4);
    
%%%%%%%%%%%%%%%%%%%%%  A COMPLETER %%%%%%%%%%%%%%%%%%%%%%%
% Iterations de Gauss-Newton :

while ( NbIter <= 1000 && Critere == 0)
    residu = - c*(TRecep - Mn(4,1) - TGps);
    for i = 1:NbSat 
        norme = norm(Mn(1:3,:) - CoordSat(:,i),2);
        residu(i)=  norme + residu(i);
        jacobien(i,:) = [(Mn(1)-CoordSat(1,i))/norme ; (Mn(2)-CoordSat(2,i))/norme ; (Mn(3)-CoordSat(3,i))/norme ; c ];
    end
    s = CholeskiMdC(-jacobien,residu);
    Mn = Mn +s;
    NbIter = NbIter+1;
end

%Iteration de Newton :


    
    
%%%%%%%%%%%%%%%%%%%%%  A COMPLETER (fin) %%%%%%%%%%%%%%%%

% Affichage du nombre d'iterations et du critere d'arret ainsi
% que des erreurs sur la position calculee et le biais d'horloge:
test_convergence( Mn(1:3), Mn(4), NbIter, Critere );

% Affectation de la solution retournee:
M = Mn;
