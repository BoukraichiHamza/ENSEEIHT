% Ce programme est le script principal permettant d'illustrer un algorithme
% de page ranking tel que ceux utilis?s lors d'une recherche de page web 
% sur internet

%Nettoyage de l'espace de travail
clear

%Puissance it?r?e : matrice pleine (sparse=0) ou creuse (sparse/=0)
sparse=0;

% G?n?ration du graphe orient? mod?lisant les liens entre les pages web
% d'internet.
Gen=input('Voulez-vous g?n?rer un nouveau graphe du Web? (1 : oui)');
if(Gen==1)
  [Links,n]=dessinerGraphe();
  save('Graphe.mat','Links','n');
  ifig=0;
else
  load('Graphe.mat')
  ifig=1;
end

% Repr?sentation matricielle du graphe
Q=matrix_representation(Links,n);

% Correction pour obtenir une matrice stochastique par colonnes.
P=columnstochastic_matrix(Q);

% Irr?ducibilit? de la matrice des liens internet et personalisation de la
% recherche
pref=input('Personalisation : acceptez-vous de nous transmettre votre historique de navigation? (1 : oui)');
v=ones(n,1)./n;
if(pref==1)
  for k=1:n
      question=strcat('Veuillez pr?ciser votre fr?quentation de la page  ',int2str(k),' (valeur entre 1 et 100)'); 
      v(k)=input(question);
  end  
  v=v/norm(v,1);
end
alpha=input('Choix de alpha entre 0 et 1 : '); 
[A,err]=irreducible_matrix(P,alpha,v);

% Recherche du classement ou arret.
pr=input('Voulez-vous effectuer le classement des pages Web? (1 : oui)');
if(pr==1)
    if (err==1)
      disp('Recherche avort?e : les donn?es transmises sont erron?es.')  
    else    
      % Recherche du vecteur propre associ? ? 1
      eps=1.e-12;
      if(sparse==0)
        r=power_method_dense(A,eps);
      else
        r=power_method_sparse(Q,v,alpha,eps);
      end
      % Visualisation du r?sultat de la recherche
      figure(2+ifig)
      subplot(1,2,1)
      bar(1:n,r)
      xlabel('Pages web')
      ylabel('Probabilit?')
      axis([0 n+1 0 1])

      subplot(1,2,2)
      bar(1:n,v)
      xlabel('Pages web')
      ylabel('Habitudes')
      axis([0 n+1 0 1]) 
    end
end
