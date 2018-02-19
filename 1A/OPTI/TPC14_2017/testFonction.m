function testFonction(choix)
%
% Fonction auxiliaire permettant de valider les fonctions implementees dans le
% cadre du TP consacre a la modelisation du processus de datation par le
% carbone 14, donne comme premier TP d'Optimisation Numerique en deuxieme
% annee ENSEEIHT-IMA.
%
% testFonction(CHOIX) affiche les differents calculs possibles si CHOIX vaut 0
% ou effectue la comparaison entre la valeur theorique de la fonction souhaitee
% et la valeur calculee par l'appel a la fonction. La valeur stockee est 
% extraite de la matrice de donnees DATAS.mat
%
% ENSEEIHT - Annee universitaire 2015-2016
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%
% Declaration et affectation des variables globales representant les
% observations du probleme
global Ti Ai 
Ti=[500 1000 2000 3000 4000 5000 6300]';% Vecteur des ages
Ai=[14.5 13.5 12.0 10.8 9.9 8.9 8.0]';% Vecteur des radioactivites
beta=[10 0.0001]'; % Vecteur en lequel sont calculees les fonctions
%
% Par defaut, on affiche les choix possibles
if(nargin==0)
    choix = 0;
end;
%
% On charge les donnees de reference
%
load('DATAS.mat');
%
% Choix possibles
%
switch choix
%
%	Affichage du menu
	case 0
%
		disp(' testFonction(0) : affichage des presentes options');
        	disp(' testFonction(1) : verification du residu');
        	disp(' testFonction(2) : verification du critere');
        	disp(...
		' testFonction(3) : verification de la jacobienne du residu');
        	disp(' testFonction(4) : verification du gradient du critere');
        	disp(...
		' testFonction(5) : verification de la hessienne du critere');
%	
%	Calcul de l'ecart sur le calcul du residu
    	case 1
		diff = norm(r_etalon - res_C14(beta))
%
%	Calcul de l'ecart sur la fonctionnelle aux moindres carres
	case 2
		diff = norm(sce_etalon - f_C14(beta))
%
%	Calcul de l'ecart sur la Jacobienne de la fonction residu
	case 3
		diff = norm(dr_etalon - J_res_C14(beta)) 
%
%	Calcul de l'ecart sur le gradient de la fonctionnelle des moindres
%	carres
	case 4
		diff = norm(g_etalon - grad_f_C14(beta))
%
%	Calcul de l'ecart sur la Hessienne de la fonctionnelle des moindres
%	carres
	case 5
		diff = norm(H_etalon - H_f_C14(beta),'fro')/...
		norm(H_etalon,'fro');
		if (diff<=1e-15)
			diff = 0
		end
%
%	Autres cas
	otherwise
		disp('Erreur ! Tapez testFonction(0)');
%
end;
%
return
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
