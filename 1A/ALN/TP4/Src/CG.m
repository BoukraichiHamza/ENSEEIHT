function [x,iter,niter] = CG(A,b,x0,maxiter,eps)

  %Initialisation
  x = x0;
  d = b - A*x0;
  rancien = d;
  r = d;
  iter = 0;
  niter = norm(r)/norm(b);
  
  while niter(end) > eps && iter < maxiter
      alpha = norm(r)^2/(d'*A*d);
      x = x + alpha*d;
      rancien = r;
      r = r - alpha*A*d;
      beta = norm(r)^2/norm(rancien)^2;
      d = r + beta*d;
      niter = [niter norm(r)/norm(b)]; 
      iter = iter +1;   
   
  end
end
