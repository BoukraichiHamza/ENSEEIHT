clear;
close all;

% Definition d'un alphabet ASCII avec les lettres A..Z, a..z, les chiffres 1..9 et la ponctuation :
 taille_alphabet = 128;
codes_ASCII = transpose(0:taille_alphabet-1);		% Vecteur (colonne) de codes ASCII
alphabet = char(codes_ASCII);					% Vecteur de caracteres ASCII

% Texte a coder :
texte = 'Voici le texte';

% Affichage du texte et calcul de sa longueur :
disp(['Texte : ' texte]);
 longueur_texte = length(texte);

% Frequences d'apparition des lettres dans le texte :
frequences = zeros(taille_alphabet,1);		% Initialisation d'un vecteur ligne de taille taille_alphabet
 for i = 1:taille_alphabet
	indices = find(texte==alphabet(i));				% Indices des caracteres de 'texte' qui sont egaux a alphabet(i)
	frequences(i) = length(indices);				% Nombre de caracteres egaux a alphabet(i) dans 'texte'
end
 frequences = frequences/longueur_texte;					% Frequences relatives

% Selection des caracteres de frequence non nulle :
 indices_frequences_non_nulles = find(frequences ~= 0);
 alphabet = alphabet(indices_frequences_non_nulles);
 taille_alphabet = length(alphabet);
 frequences = frequences(indices_frequences_non_nulles);

% Partitionnement de l'intervalle [0,1[ :
somme = 0;
 bornes = zeros(2,taille_alphabet);
 for i = 1:taille_alphabet-1
     somme = somme + frequences(i);
	bornes(2,i) = somme;
	bornes(1,i+1) = somme;
 end
 bornes(2,taille_alphabet) = 1;

% Codage arithmetique :
 borne_inf = 0;
 borne_sup = 1;
 for i = 1:longueur_texte
	c = find(alphabet==texte(i));
	largeur = borne_sup-borne_inf;
	borne_inf_sauv = borne_inf;
	borne_inf = borne_inf_sauv+largeur*bornes(1,c);
	borne_sup = borne_inf_sauv+largeur*bornes(2,c);
 end

% Choix (arbitraire) d'un nombre compris dans l'intervalle [borne_inf,borne_sup] pour coder le texte :
 k = 1;
 while (floor(k*borne_inf)==floor(k*borne_sup))
	k = 10*k;	
 end
 texte_code = floor(k*borne_sup)/k;
 disp(['Texte code : ' num2str(texte_code,15)]);

 %Decodage du texte code :
 texte_decode = '';
 texte_code_courant = texte_code;
 for i = 1:longueur_texte
	c = find((texte_code_courant>bornes(1,:))&(texte_code_courant<bornes(2,:)));	% Identification du caractere courant
	texte_decode = [texte_decode alphabet(c)];		% Concatenation du caractere au texte decode
	texte_code_courant = (texte_code_courant-bornes(1,c))/frequences(c);	% Soustraction de la borne inferieure et division par la probabilite pour obtenir le caractere suivant
 end
 texte_decode;
 disp(['Texte decode : ' texte_decode]);

% Calcul du nombre de bits necessaires pour coder la partie decimale :
 dec_texte_code = texte_code*k;			% Partie decimale
 nb_bits_codage_arithmetique = length(dec2bin(dec_texte_code));		% Conversion de la partie decimale en binaire (dec2bin)
 disp(['Nombre de bits du codage arithmetique : ' num2str(nb_bits_codage_arithmetique)]);

% Comparaison avec le codage de Huffman :
 dico = huffmandict(num2cell(alphabet),frequences);
 texte_encode = huffmanenco(texte,dico);
 nb_bits_codage_Huffman = length(texte_encode);
 disp(['Nombre de bits du codage de Huffman : ' num2str(nb_bits_codage_Huffman)]);
