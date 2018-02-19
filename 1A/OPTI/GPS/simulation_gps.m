IT = 0;
P0 = POSINIT;
randn('state',0);

if (exist('FUN','var'))
    clear FUN
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation de l'evolution de la constellation 
% Simulation de la triangulation 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
FUN = 'positionnement';
%disp(['Execution du code :' FUN '.m']);

% Boucle sur le temps
for IT=0:NBIT,
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Propagation des satellites
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	t = DEBUT+PAS*IT;
	propagation;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Position utilisateur
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	position_ut;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Determination des satellites visibles
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	visi;

	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	% Calcul de position
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (exist('FUN','var'))
        if (nbvisi >= 4)
            % Acquisition des signaux
            [TGps,TRecep,X,Y,Z] = reception;

            % Triangulation
            PSOL = feval(FUN,P0,TGps,TRecep,X,Y,Z,c);

            disp( [' '] );
            disp( ['	PSOL =     	Pexacte = '] );
            disp( num2str([ PSOL Pexacte ],'\t%0.5e') );
            pause(0.25)
        end
    else
        PSOL = Pexacte;
    end
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	%Affichages	
	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
	figure(1);
	affichage; pause(0.25)
    if (exist('FUN','var'))
	   figure(2);
	   affichage_zoom;
    end
    % M�morisation position pr�c�dente
 	P0 = PSOL;

end
