% Ce programme est le script principal permettant d'illustrer
% un algorithme de reconnaissance de chiffres.

% Nettoyage de l'espace de travail
clear all; close all;

% Ajout des repertoires Tools et Data a l'environnement de travail
addpath('Tools')
addpath('Data')

% Pourcentage d'approximation
PrecApprox=0.75;

for k=1:5
% Definition des donnees
file=['D' num2str(k)]

% Recuperation des donnees
disp('Generation de la base de donnees');
sD=load(file);
D=sD.(file);
% Analyse des donnees 
disp('Approximation : calcul du sous-espace');
Us=compute_subspace(D,PrecApprox);

% Reconnaissance de chiffres
 disp('test des chiffres :');
 tes(:,1) = importerIm('test1.jpg',1,1,16,16);
 tes(:,2) = importerIm('test2.jpg',1,1,16,16);
 tes(:,3) = importerIm('test3.jpg',1,1,16,16);
 tes(:,4) = importerIm('test4.jpg',1,1,16,16);
 tes(:,5) = importerIm('test5.jpg',1,1,16,16);
 tes(:,6) = importerIm('test9.jpg',1,1,16,16);

 for tests=1:6
    r(tests,k) = decision(Us, tes(:,tests));
 end
 
end

% Affichage du r�sultat de l'analyse
figure(1)
set(gca,'Fontsize',20,'Fontname','Times','Box','on')
chiffres=[1;2;3;4;5];
subplot(2,3,1),bar(chiffres,(r(1,:))),title('chiffre 1'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
subplot(2,3,2),bar(chiffres,r(2,:)),title('chiffre 2'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
subplot(2,3,3),bar(chiffres,r(3,:)),title('chiffre 3'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
subplot(2,3,4),bar(chiffres,r(4,:)),title('chiffre 4'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
subplot(2,3,5),bar(chiffres,r(5,:)),title('chiffre 5'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
subplot(2,3,6),bar(chiffres,r(6,:)),title('chiffre 9'),xlabel('chiffres'),ylabel('d'),axis([0 6 0 0.8])
