clear;
close all;
taille_ecran = get(0,'ScreenSize');
L = taille_ecran(3);
H = taille_ecran(4);

% Definition d'un alphabet ASCII avec les lettres A..Z, a..z, les chiffres 1..9 et la ponctuation :
taille_alphabet = 128;
codes_ASCII = transpose(0:taille_alphabet-1);		% Vecteur (colonne) de codes ASCII
alphabet = char(codes_ASCII);				% Vecteur de caracteres ASCII

% Texte ecrit en francais :
texte = 'Ceci est un texte en Francais. Il contient des lettres (majuscules et minuscules), des chiffres de zero (0) a neuf (9) et quelques caracteres de ponctuation comme la virgule (,), le point (.), les deux points (:) etc. Par contre il ne contient pas de caractere accentue, de guillemets, dapostrophe ou de cedille, qui ne sont pas des caracteres ASCII standards. Il sert simplement a illustrer la loi de probabilite de lalphabet francais. En fait nimporte quel texte convient, du moment quil soit assez long pour illustrer la langue francaise. Du coup on met bout a bout des phrases sans reel lien logique, mais qui permettront dobtenir un histogramme assez representatif de la langue francaise. Normalement le caractere le plus present est lespace, suivi du e, du s, a, i, t... Ce genre dhistogramme est tres utile en cryptographie : chaque langue possede son propre histogramme, ce qui permet de reconnaitre la langue dun texte code meme si les lettres ont ete changees. Evidemment, un bon outil de cryptographie fera en sorte de ne pas chiffrer deux occurrences dune meme lettre de la meme facon, sinon ce serait trop simple ! Pour finir ce texte, jajoute un k et un w, parce quil ny en avait pas encore.';

% Affichage du texte et calcul de sa longueur :
disp(['Texte : ' texte]);
longueur_texte = length(texte);

% Frequences d'apparition des lettres de l'alphabet francais :
frequences = zeros(taille_alphabet,1);		% Initialisation d'un vecteur ligne de taille taille_alphabet
 for i = 1:taille_alphabet
	indices = find(texte==alphabet(i));				
	% Indices des caracteres de 'texte' qui sont egaux a alphabet(i)
	frequences(i) = length(indices);			
	% Nombre de caracteres egaux a alphabet(i) dans 'texte'
 end
 frequences = frequences/longueur_texte;
 % Frequences relatives

% Selection des caracteres de frequence non nulle :
 indices_frequences_non_nulles = find (frequences ~= 0);
alphabet = alphabet(indices_frequences_non_nulles);
frequences = frequences(indices_frequences_non_nulles);

% Tri des caracteres par frequences decroissantes :
[frequences_triees,indices] = sort(frequences, 'descend');
alphabet_trie = alphabet(indices);

% Histogramme des frequences de chaque lettre :
 figure('Name','Histogramme des caracteres du texte','Position',[0.33*L,0,0.67*L,H]);
 bar(frequences_triees);
set(gca,'XTick',[1:length(alphabet_trie)]);
 set(gca,'XTickLabel',alphabet_trie);
 xlabel('Alphabet');
ylabel('Frequence');

save exercice_Matlab;
