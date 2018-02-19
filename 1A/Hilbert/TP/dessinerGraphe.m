function [ Y,n ] = dessinerGraphe()
% G?n?ration du graphe orient? selon l'utilisateur.
% Y contient les arcs du graphe orient?. 
% Le nombre de lignes de Y est ?gal au nombre d'arcs du graphe orient?.
% Le nombre de colonnes de Y est ?gal ? 2 : la premi?re colonnes correspond au
% sommet de d?part, la seconde au sommet d'arriv?e.
% n repr?sente le nombre de sommet.

figure(1);
axis([0 1 0 1])
b=1;

% D?finition des sommets du graphe 
X = saisiePoints();

%Visualisation des sommets
for id = 1:size(X,1)
    x = X(id,1);
    y = X(id,2);
    plot(x,y,'r+'); %dessine les points un ? un
    text(x,y,num2str(id));
end

disp('Veuillez entrer les liens entre les pages Internet');
disp('taper RETURN apres le dernier arc');

%D?finition des arcs du graphe orient?
Y = [];
while ( b==1)
    %Choix du sommet de d?part
    boolAux = 1;
    while boolAux
        [x1,y1,b]= ginput(1);
        aux = 1;
        i = 1;
        if ~isempty(b)
            while i<=size(X,1) && aux
                distance = norm([x1 y1]-X(i,:),2);
                if distance<0.1
                    aux = 0;
                    boolAux = 0;
                    select1 = i;
                    figure(1)
                    hold on
                    plot(x1,y1,'ko');
                    hold off
                end
                i = i+1;
            end
        else
            boolAux = 0;
        end
    end
    
    %Choix du sommet d'arriv?e
    boolAux = 1;
    while boolAux
        [x2,y2,b]= ginput(1);
        aux = 1;
        i = 1;
        if ~isempty(b)
            while i<=size(X,1) && aux
                distance = norm([x2 y2]-X(i,:),2);
                if distance<0.1 && i~=select1
                    aux = 0;
                    boolAux = 0;
                    select2 = i;
                    figure(1)
                    hold on
                    plot(x2,y2,'k>');
                    hold off
                end
                i = i+1;
            end
        else
            boolAux = 0;
        end
    end
    
    %Afficher l'arc
    figure(1)
    hold on
    if(x2==x1)
       x2=x2+0.001; 
    end
    if(y2==y1)
       y2=y2+0.001;  
    end    
    plot([x1:(x2-x1)/10:x2],[y1:(y2-y1)/10:y2],'k');
    hold off
    if ~isempty(b)
        Y = [Y; [select1 select2]];
    end
end;
n = size(X,1);
hold on;

end


