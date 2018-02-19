%% Programme PLATINE : script de dialogue
%
% permet de :
% créer/charger une image de la scène 2D
% créer/détruire les chemins des objets circulant dans cette scène
% définir leurs point de départ et d'arrivée
% calculer leurs chemins de longueur minimale
% définir leurs lois de vitesse sur ces chemins pour déterminer leurs
% trajectoires
% simuler leurs déplacements
% déterminer leurs collisions éventuelles
% calculer leurs temps de parcours en prenant en compte leurs temps de
% réparation
%
%% DIALOGUE
cprintf('*comment','          BIENVENU(E) DANS PLATINE !');
disp (' ');
%
% Initialisations
continuer = true;
%
subd = 2000; % nombre de pts d'echantillonnage
%
%couleur = char('red' , 'blue','cyan','magenta', 'yellow', 'black' , 'white', 'green');
%length_couleur = [3 4 4 7 6 5 5 5];
% couleurs attribues aux objets lors de leur creation
% L'objet n°1 prend la couleur couleur(1), n°2 couleur couleur(2)...
%%
while continuer
    %
    disp('********************************************');
    disp ('Pour afficher une scene existante , taper 1');
    disp ('Pour creer une scene , taper 2');
    disp ('Pour sauvegarder une scene, taper 11');
    disp ('*')
    disp ('Pour creer une nouvelle trajectoire dans une scene existante , taper 3');
    disp ('Pour changer la loi de vitesse d''une trajectoire , taper 4');
    disp ('Pour detruire une trajectoire dans une scene existante , taper 5');
    disp ('*')
    disp ('Pour simuler les deplacements dans une scene existante , taper 6');
    disp ('Pour deformer une trajectoire , taper 7');
    disp('********************************************');
    reponse = input('Reponse ? ');
    if isempty(reponse) 
        return
    end
    %
    switch reponse
        case 1 % Afficher une scene existante dans le dossier "Scenes"
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);
            % On affiche les chemins de la scene
            affich_chemins2;
            % On affiche les positions de depart et d'arrivee
            affichage_da; 
            %
        case 11 % Sauvegarder une scène dans le dossier "Scenes"
            disp ('Cliquer sur la scene a sauvegarder');
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);
            %
            NOMFIC = ['Scenes/SAUV' NOMSCENE];
            save(NOMFIC,'im','nombre_objets','subd','T');
        case 2 % Creer une scene
            %
            CreateScene;
            imscene = im; % sauvegarde de l'image de la scene dans le dossier "Scenes"
            % pas de creation de nouveau chemin
            nombre_objets = 0;
            NOMSCENE = input('Nom de la scene ? ','s');
            NOMFIC = ['Scenes/' NOMSCENE];
            save(NOMFIC,'im','nombre_objets','subd');
            %
        case 3 % Creer une nouvelle trajectoire dans une scene existante dans le dossier "Scenes"
            %
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);      % on charge im , nombre_objets , subd et T (si nombre_objets ~= 0)
            %
            nlig = size(im,1); % nombre de lignes de im
            ncol = size(im,2); % nombre de colonnes de im
            imscene = im;      % sauvegarde de im
            %
            % On affiche les chemins de la scene
            affich_chemins2;
            %
            % On affiche les positions de depart et d'arrivee
            affichage_da;
            %
            % Creer nouvelle trajectoire
            nombre_objets = nombre_objets + 1;
            %
            % Creer nouveau chemin
            % Création d'un chemin qui est un segment de droite ou une
            % nurbs.
            type_chemin = input('DROITE ou NURBS ? [D/N] ','s');
            if type_chemin == 'D'
                disp ('Le chemin est un segment de DROITE')
                Chemin_Initial_Droite;
                exception = false; % Pas d'exception si chemin est D
                T(nombre_objets).chemin = 'DROITE';
            else
                disp('Le chemin est une NURBS');
                Chemin_Initial2; %planification offline
                if ~exception
                    T(nombre_objets).chemin = 'NURBS';
                    T(nombre_objets).nurbs = nurbsf;
                end
            end
            if ~exception
                %
                T(nombre_objets).depart = [idep jdep];
                T(nombre_objets).arrivee = [iarr jarr];
                %
                T(nombre_objets).rayon_min = rho_min;
                %
                T(nombre_objets).diametre_robot = diametre_robot;
                %
                disp('Donner une couleur au robot en choisissant parmi:');
                disp('red , blue, cyan, magenta , yellow , black , white, green');
                couleur = input('Couleur : ','s');
                T(nombre_objets).couleur = couleur;
                %
                % Definir le nombre de fois que le chemin est parcouru dans un
                % sens puis dans l'autre
                nbre_rep = input(['Nombre de repetitions du chemin de l''objet ',num2str(nombre_objets),' : ']);
                T(nombre_objets).nbre_repetition = nbre_rep;
                %
                % Creer nouvelle loi de vitesse
                reponse3 = input ('Vitesse constante ? [Y/N]','s');
                if reponse3 == 'Y'
                    vitesse = input(['Vitesse de l''objet ',num2str(nombre_objets),' : ']);
                    T(nombre_objets).vitesse = vitesse;
                else
                    disp('NON IMPLANTE !');
                end
                %
                % Definir la portee de l'objet
                portee = input(['Portee de l''objet ',num2str(nombre_objets),' : ']);
                T(nombre_objets).portee = portee;
                %
                % Definir le temps de reparation de l'objet
                temps = input(['Temps de reparation de l''objet ',num2str(nombre_objets),' : ']);
                T(nombre_objets).temps_repar = temps;
                %
                % Sauvegarde de la scene
                reponse = input('Changement du nom de la scene ? [Y/N] ','s');
                while reponse == 'Y'
                    NOMSCENE = input('Nouveau nom de la scene : ','s');
                    NOMFIC = ['Scenes/' NOMSCENE '.mat'];
                    if exist(NOMFIC,'file') == 0
                        disp ('OK'); % le fichier n'existe pas deja , c'est bon
                        reponse = 'N';
                    else
                        % le fichier existe deja il faut donner un autre nom
                        disp('le fichier existe deja il faut donner un autre nom');
                    end
                end
                save(NOMFIC,'im','nombre_objets','subd','T');
                %
            end
            %
        case 4 % changer la loi de vitesse d'une trajectoire
            %
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);
            %
            i = input('Numero de l''objet  : ');
            vold = T(i).vitesse;
            disp(['Ancienne vitesse de l''objet ',num2str(i),' : ',num2str(vold)]);
            vnew = input(['Nouvelle vitesse de l''objet ',num2str(i),' : ']);
            T(i).vitesse = vnew;
            save(NOMFIC,'im','nombre_objets','subd','T');
            %
        case 5 % destruction d'une trajectoire dans une scene deja existante
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);
            %
            DelTraj;
            %
        case 6 % Simulation
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC);
            %
            Simulation3; % execution de la simulation
            %
        case 7 % Deformation de la trajectoire
            NOMSCENE = uigetfile('Scenes/*.mat');
            NOMFIC = ['Scenes/' NOMSCENE];
            load(NOMFIC); % Deformation de trajectoire
            %
            Deformation_trajectoire;
            %
        otherwise
            disp ('CHOIX INCORRECT');
    end
    reponse = input('Continuer ? [Y/N] ','s');
    if (reponse == 'N')
        continuer = false;
    end
end