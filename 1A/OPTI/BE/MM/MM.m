%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ehouarn Simon                                                         %
% mai 2017                                                              %
% INP Toulouse - ENSEEIHT                                               %	
%                                                                       %
% Ce fichier contient le programme principal permettant l'estimation    %
% des parametres de l'equation de Michaelis-Mensen par une approche     %
% des moindres carres.						        %
% Modele : V(S)=Vmax*S/(Km+S)					        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all; close all; format short
% Initialisation
%

% Donn�es 
global Si Vi
Si=[4.1; 8.2;10.9;16.7;17.5;18.3;24.1;36.6;37.5;39.9];
Vi=[9.8;16.1;17.9;21.1;22.9;23.1;24.2;27.6;27.8;28.1];

Vmax = 40;
Km = 5;
%Estimation a priori des parametres du modele.
beta0=[Vmax;Km];
%beta0=[40;5];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Methode de Gauss-Newton %
%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%% Figure 1 %%%%%%%%
% Affichage des donnees
figure(1)                         
plot(Si,Vi,'ok')
rect=[0 50 0 40];
axis(rect)
xlabel('S')
ylabel('V(S)')
hold on

% Affichage de la prevision du modele.
beta=beta0
S=0:1:50;
S=S';
V=beta(1)*S./(beta(2)+S);
plot(S,V,'k')

%%%%%%% Figure 4 %%%%%%%%
% Methode de Gauss-Newton

%Evaluation de la fonction des moindres carres 
xmin=10;
xmax=50;
nx=100;
pasx=(xmax-xmin)/nx;
ymin=0;
% ymin=-0.0001;
ymax=30;
ny=100;
pasy=(ymax-ymin)/ny;

x=xmin:pasx:xmax;
y=ymin:pasy:ymax;
[X,Y]=meshgrid(x,y);
[m,n]=size(X);
for i=1:m,
   for j=1:n,
      Z(i,j)=f_MM([X(i,j),Y(i,j)]);
   end;
end;

% Affichage des lignes de niveau de la fonction des moindres carres.
figure(4)                            
contour(X,Y,Z,150);
xlabel('Vmax')
ylabel('K')
hold on
text(beta(1),beta(2),'o point de depart')


%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%
% 1- Minimisation de la fonction des moindres carres par la m�thode de Gauss-Newton
% 2- Affichage des la prevision du modele et de l'estimation des parametres
% au cours de la minimisation

%initialisation
J1 = J_res_MM(beta0);
r1 = res_MM(beta0);
gradbeta0 = J1'*r1;
normegrad0 = norm(gradbeta0,2);
gradbeta1 = gradbeta0;
beta1 = beta0;
beta1ancien = beta0;
norme1 = 1;
iter1 = 0;
maxiter1 = 1000;

while (iter1 <= maxiter1) && ( norme1 > eps) && (norm(gradbeta1,2) > eps*normegrad0)
    beta1ancien = beta1;
    beta1 = beta1 - (J1'*J1)\gradbeta1;
    norme1 = norm(beta1 - beta1ancien,2)/norm(beta1ancien,2);
    J1 = J_res_MM(beta1);
    r1 = res_MM(beta1);
    gradbeta1 = J1'*r1;
    iter1 = iter1 +1;
    
    %Affichage de la prevision du modele
    figure(1)
    V=beta1(1)*S./(beta1(2)+S);
    plot(S,V,'k')
    hold on
    
    %Affichage des points beta
    figure(4)
    text(beta1(1),beta1(2),'o')
    hold on
    
    
end
    iter1

    


%%%%%%%%%% END TO DO  %%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Methode de Newton %
%%%%%%%%%%%%%%%%%%%%%%%%%%%



% Estimation a priori des parametres du modele.
beta=beta0

%%%%%%% Figure 2 %%%%%%%%
% Affichage des donnees
figure(2)                         
plot(Si,Vi,'ok')
rect=[0 50 0 40];
axis(rect)
xlabel('S')
ylabel('V(S)')
hold on

% Affichage de la prevision du modele.
V=beta(1)*S./(beta(2)+S);
plot(S,V,'k')

%%%%%%% Figure 5 %%%%%%%%
% Methode Newton

figure(5)                          
contour(X,Y,Z,150);
xlabel('Vmax')
ylabel('K')
hold on
text(beta(1),beta(2),'o point de depart')

%%%%%%%%%% TO DO %%%%%%%%%%%%%%%%%
% 1- Minimisation de la fonction des moindres carres par la m�thode de Newton
% 2- Affichage des la prevision du modele et de l'estimation des parametres
% au cours de la minimisation

%initialisation
J2 = J_res_MM(beta0);
r2 = res_MM(beta0);
H2 = H_f_MM(beta0);
gradbeta0 = J2'*r2;
normegrad0 = norm(gradbeta0,2);
gradbeta2 = gradbeta0;
norme2 = 1;
beta2ancien = beta0;
beta2 = beta0;
iter2 = 0;
maxiter2 = 1000;

while (iter2 <= maxiter2) && (norme2 > eps) && (norm(gradbeta2,2) > eps*normegrad0)
    beta2ancien = beta2;
    beta2 = beta2 - H2\gradbeta2;
    norme2 = norm(beta2 - beta1ancien,2)/norm(beta1ancien,2);
    J2 = J_res_MM(beta2);
    r2 = res_MM(beta2);
    H2 = H_f_MM(beta2);
    gradbeta2 = J2'*r2;
    iter2 = iter2 +1;
    
     %Affichage de la prevision du modele
    figure(2)
    V=beta2(1)*S./(beta2(2)+S);
    plot(S,V,'k')
    hold on
    
    %Affichage des points beta
    figure(5)
    text(beta2(1),beta2(2),'o')
    hold on
    
    
end
    iter2

%%%%%%%%%% END TO DO  %%%%%%%%%%%%%
