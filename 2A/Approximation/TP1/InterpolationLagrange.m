function S = InterpolationLagrange(U,X,Y)
n = size(X,2);
m = size(U,2);
for k = 1:m
    v = 0;
    for i = 1:n
        p = 1;
        for j = 1:n
            if j ~= i
            p = p * (U(k) - X(j)) / (X(i) - X(j));
            end
        end
        v = v + p*Y(i);    
    end
    S(k) = v;
end
end
