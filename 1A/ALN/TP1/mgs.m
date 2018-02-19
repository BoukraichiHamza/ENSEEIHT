function Q = mgs(A)

[n, m] =size(A);
Q=A;

for k=1:m
    for i = 1:k-1
        Q(:,k) = Q(:,k) - ((Q(:,k)'* Q(:,i))/(norm(Q(:,i))^2)*Q(:,i));
    end
    Q(:,k) = Q(:,k) / norm(Q(:,k));  
end

end