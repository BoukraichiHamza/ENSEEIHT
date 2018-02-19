function [largest_eig,smallest_eig] = CondEstim(A)
  %Largest and smallest eigenvalues with iterative power.
  
  prec = 1e-6;
  iter_max = 1000;
  
  largest_eig = 1;
  smallest_eig = 1;

  %initialisation
  p =0;
  n = size(A,1);
  x =ones(n,1);
  beta = x'*(A*x);
  betaold = 0;
  
  while abs(beta - betaold)/abs(beta) > prec && p < iter_max
      y = A*x;
      x = y/norm(y);
      betaold = beta;
      beta = x'*(A*x);
      p = p + 1;
  end
  
  largest_eig = beta
  
  
  x =ones(n,1);
  p=0;
  beta = x'*(A*x);
  betaold = 0;
  
  
    while abs(beta - betaold)/abs(beta) > prec && p < iter_max
      y = A\x;
      x = y/norm(y);
      betaold = beta;
      beta = x'*(A*x);
      p = p + 1;
    end
    
   smallest_eig = beta
  
end
