function [cos_theta_2,sin_theta_2,rho_2] = estimation_2(x_donnees,y_donnees)

x_G = mean(x_donnees);
y_G = mean(y_donnees);
distance = sqrt((x_donnees(2)-x_donnees(1))^2+(y_donnees(2)-y_donnees(1))^2);
cos_theta_2 = -(y_donnees(2)-y_donnees(1))/distance;
sin_theta_2 = (x_donnees(2)-x_donnees(1))/distance;
rho_2 = x_G*cos_theta_2+y_G*sin_theta_2;
