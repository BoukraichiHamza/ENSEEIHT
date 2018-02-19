Grille = gen_grille();
X = Grille(:,:,1);
Y = Grille(:,:,2);
Z = Grille(:,:,3);
T = caractTime(X,Z);
S = caractTime(Y,Z);

u1 = min(T(1,:)):0.001:max(T(1,:));


[V,H,W] = LagrangeSurface(u1,S(1,:),T(1,:),Grille);

surf(X,Y,Z);
hold on
plot3(V,H,W);
plot3(V,W,H);
plot3(H,V,W);
plot3(H,W,V);
plot3(W,V,H);
plot3(W,H,V);