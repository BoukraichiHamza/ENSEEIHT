function Q = cgs(A)

[n, m] =size(A);
Q=A;
tmp = zeros(m,1);
for k=1:m
        tmp = Q(:,1:k-1)*Q(:,1:k-1)'*Q(:,k);
        Q(:,k) = Q(:,k) - tmp;
        Q(:,k) = Q(:,k)/norm(Q(:,k));
end
        
end

