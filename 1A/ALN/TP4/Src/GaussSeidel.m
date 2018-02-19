function [x,iter,niter] = GaussSeidel(A,b,x0,maxiter,eps)

%Décomposition de la matrice A
  M =tril(A);
   

   
   %Initialisation
   x=x0;
   r=b-A*x;
   iter = 0;
   niter = norm(r)/norm(b);
   
   while niter(end) > eps && iter < maxiter
       y = M\r;
       x = x + y;
       r = r - A*y;
       iter = iter +1;
       niter = [niter norm(r)/norm(b)];
        end


end
