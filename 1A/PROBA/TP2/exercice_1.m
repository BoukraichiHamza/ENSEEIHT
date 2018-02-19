clear;
close all;
load exercice_Matlab;

% Codage de Huffman du texte :
 alphabet_cell = num2cell(alphabet);			% Format 'cell' requis par la fonction huffmandict
 dico = huffmandict(alphabet_cell,frequences);		% dico{j,2} est le code binaire du caractere ASCII dico{j,1}
 texte_encode = huffmanenco(texte,dico);
 texte_encode_editable = num2str(texte_encode);
 texte_encode_editable = texte_encode_editable(1:3:end);	% Permet d'enlever les espaces dans la chaine de bits
 disp(['Texte encode : ' texte_encode_editable]);

% Calcul du coefficient de compression obtenu par le codage de Huffman :
 nb_bits_sans_compression = 8*longueur_texte;% 8 bits par caractere
 nb_bits_codage_Huffman = 	length(texte_encode_editable);		% texte_encode est binaire	
 coefficient_de_compression = nb_bits_sans_compression/nb_bits_codage_Huffman;
 disp(['Coefficient de compression : ' num2str(coefficient_de_compression)]);

% Decodage du texte : 
 texte_decode = huffmandeco(texte_encode,dico);
 texte_decode_editable = transpose(char(texte_decode));
 disp(['Texte decode : ' texte_decode_editable]);
