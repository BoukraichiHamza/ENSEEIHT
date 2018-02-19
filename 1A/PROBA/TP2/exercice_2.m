clear;
close all;

load exercice_1_TP1;

% Codage de Huffman de l'image initiale :
 frequences_image_initiale = histogramme/sum(histogramme);
 dico = huffmandict(I_min:I_max,frequences_image_initiale);

% Pour chaque entier dico{j,1}, le code binaire dico{j,2} a pour longueur length(dico{j,2}) :
 nb_bits_codage_Huffman_image_initiale = 0;
for j = 1:length(histogramme)   
	nb_bits_codage_Huffman_image_initiale = nb_bits_codage_Huffman_image_initiale+length(dico{j,2})*histogramme(j);
 end

% Calcul du coefficient de compression obtenu par codage de Huffman :
 nb_bits_sans_compression = 8*sum(histogramme);
 coefficient_de_compression_avant_decorrelation = nb_bits_sans_compression/nb_bits_codage_Huffman_image_initiale;
disp(['Coefficient de compression avant decorrelation : ' num2str(coefficient_de_compression_avant_decorrelation)]);

load exercice_2_TP1;

% Codage de Huffman de l'image decorrelee :
set(0,'RecursionLimit',550);	% Plus de 500 appels recursifs (nombre d'entiers a coder : 2*I_max+1 = 511 > 500)
 frequences_image_decorrelee = histogramme_decorrele/sum(histogramme_decorrele);
dico_decorrele = huffmandict(I_min:I_max,frequences_image_decorrelee);

% Pour chaque entier dico_decorrele{j,1}, le code binaire dico_decorrele{j,2} a pour longueur length(dico_decorrele{j,2}) :
nb_bits_codage_Huffman_image_decorrelee = 0;
 for j = 1:length(histogramme_decorrele) 
	nb_bits_codage_Huffman_image_decorrelee = nb_bits_codage_Huffman_image_decorrelee+length(dico_decorrele{j,2})*histogramme_decorrele(j);
 end

% Calcul du coefficient de compression obtenu par decorrelation et codage de Huffman :
 coefficient_de_compression_apres_decorrelation = nb_bits_sans_compression/nb_bits_codage_Huffman_image_decorrelee;
 disp(['Coefficient de compression apres decorrelation : ' num2str(coefficient_de_compression_apres_decorrelation)]);
disp(['Gain en compression : ' num2str(coefficient_de_compression_apres_decorrelation/coefficient_de_compression_avant_decorrelation)]);
