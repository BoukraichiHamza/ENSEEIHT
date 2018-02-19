function Grille = gen_grille()
[X,Y]=meshgrid(0:0.25:1,0:0.25:1);
Z=exp(-((X-1/2).^2+(Y-1/2).^2));
%surf(X,Y,Z) % permet de visualiser la grille de points 3D
Grille=zeros(size(X,1),size(X,2),3);
Grille(:,:,1)=X;
Grille(:,:,2)=Y;
Grille(:,:,3)=Z;
end