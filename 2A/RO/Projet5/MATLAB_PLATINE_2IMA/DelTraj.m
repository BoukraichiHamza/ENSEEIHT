% DelTraj
%
%NOMSCENE = uigetfile('Scenes/*.mat');
%NOMFIC = ['Scenes/' NOMSCENE];
%load(NOMFIC);
%
affich_chemins2;
%
coulobjdel = input('Couleur de l''objet a detruire: red , blue, cyan, magenta , yellow , black , white, or green ? ','s');
nocc = 0;
index = [];
for i=1:nombre_objets
    if length(coulobjdel) == length(T(i).couleur) && all(T(i).couleur == coulobjdel) % l'objet n°i a-t-il la couleur coulobjdel
        nocc = nocc + 1;
        index = [index i];
    end
end
switch nocc
    case 0
        disp(['Un objet de cette couleur: ',coulobjdel,' n''existe pas dans la scene !']);
    case 1
        % on supprime l'objet nocc
        T = [T(1:index-1) T(index+1:end)];
        nombre_objets = nombre_objets - 1;
        save(NOMFIC,'im','nombre_objets','subd','T');
    otherwise
        disp('Plusieurs objets ont cette couleur !');
end