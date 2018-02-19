switch nombre_objets
    case 1
        robot=plot(xunit,yunit,T(1).couleur);
    case 2
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:end);
        y2 = yunit(lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur);
    case 3
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:2*lth);
        y2 = yunit(lth+1:2*lth);
        x3 = xunit(2*lth+1:end);
        y3 = yunit(2*lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur,x3,y3,T(3).couleur);
    case 4
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:2*lth);
        y2 = yunit(lth+1:2*lth);
        x3 = xunit(2*lth+1:3*lth);
        y3 = yunit(2*lth+1:3*lth);
        x4 = xunit(3*lth+1:end);
        y4 = yunit(3*lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur,x3,y3,T(3).couleur,x4,y4,T(4).couleur);
    case 5
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:2*lth);
        y2 = yunit(lth+1:2*lth);
        x3 = xunit(2*lth+1:3*lth);
        y3 = yunit(2*lth+1:3*lth);
        x4 = xunit(3*lth+1:4*lth);
        y4 = yunit(3*lth+1:4*lth);
        x5 = xunit(4*lth+1:end);
        y5 = yunit(4*lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur,x3,y3,T(3).couleur,x4,y4,T(4).couleur,x5,y5,T(5).couleur);
    case 6
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:2*lth);
        y2 = yunit(lth+1:2*lth);
        x3 = xunit(2*lth+1:3*lth);
        y3 = yunit(2*lth+1:3*lth);
        x4 = xunit(3*lth+1:4*lth);
        y4 = yunit(3*lth+1:4*lth);
        x5 = xunit(4*lth+1:5*lth);
        y5 = yunit(4*lth+1:5*lth);
        x6 = xunit(5*lth+1:end);
        y6 = yunit(5*lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur,x3,y3,T(3).couleur,x4,y4,T(4).couleur,x5,y5,T(5).couleur,x6,y6,T(6).couleur);
    case 7
        x1 = xunit(1:lth);
        y1 = yunit(1:lth);
        x2 = xunit(lth+1:2*lth);
        y2 = yunit(lth+1:2*lth);
        x3 = xunit(2*lth+1:3*lth);
        y3 = yunit(2*lth+1:3*lth);
        x4 = xunit(3*lth+1:4*lth);
        y4 = yunit(3*lth+1:4*lth);
        x5 = xunit(4*lth+1:5*lth);
        y5 = yunit(4*lth+1:5*lth);
        x6 = xunit(5*lth+1:6*lth);
        y6 = yunit(5*lth+1:6*lth);
        x7 = xunit(6*lth+1:end);
        y7 = yunit(6*lth+1:end);
        robot=plot(x1,y1,T(1).couleur,x2,y2,T(2).couleur,x3,y3,T(3).couleur,x4,y4,T(4).couleur,x5,y5,T(5).couleur,x6,y6,T(6).couleur,x7,y7,T(7).couleur );
    otherwise
        error('Trop d''objets a afficher !');
end