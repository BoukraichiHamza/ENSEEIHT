function [X] = saisiePoints()
% D?finition des sommets du graphe orient? selon l'utilisateur.
% X contient les sommets du graphe.

figure(1);
axis([0 1 0 1])
b=1;
X=[];

hold on

disp('Veuillez entrer les sommets du graphe Internet');
disp('taper RETURN apres le dernier point');
while ( b==1 )
    [x,y,b]= ginput(1);
    X=[X; [x y]];
    figure(1)
    plot(x,y,'r+');
end;
end