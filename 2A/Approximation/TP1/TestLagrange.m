[X,Y] = saisi_points();
 fplot(@(u)InterpolationLagrange(u,X,Y));
 hold on