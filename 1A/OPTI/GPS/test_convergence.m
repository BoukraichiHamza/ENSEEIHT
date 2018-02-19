function test_convergence(Pos, BH, NbIter, Critere);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Teste la distance entre M et la solution exacte 
% R�alise une pause
% function test_convergence(Pos, BH, NbIter, Critere);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Entree - Pos     : solution courante (3x1)
% Entree - BH      : Biais horloge  courant (1x1)
% Entree - NbIter  : Nombre d'iterations effectuees
% Entree - Critere : valeur du critere d'arret courant
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

global c Pexacte

position = (Pos-Pexacte(1:3))';
% biais = abs([BH-Pexacte(4) c*(BH-Pexacte(4))])
biais = (BH-Pexacte(4));


% Affichage du nombre d'iterations et du critere d'arret:
disp( [' '] );
disp( ['nombre d''iterations et critere d''arret : ' ...
        num2str(NbIter,'\t%3d') num2str(Critere,'\t%0.5e')] );

% Affichage des erreurs sur la position calculee et le biais d'horloge:
disp(['�cart par rapport � la position exacte : ' ...
       num2str(position,'\t%0.4g') ]);
disp(['�cart sur le biais d''horloge exact :    ' ...
       num2str(biais,'\t%0.5e') ]);

%pause;

