function [S,V] = LagrangeParametrique(U,T,X,Y)
    S = InterpolationLagrange(U,T,X);
    V = InterpolationLagrange(U,T,Y);
end