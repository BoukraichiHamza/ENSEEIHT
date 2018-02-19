% Matrix
choice_matrix=menu('Choose a matrix','bodyy4','nos4','bcsstk09','bcsstk05','bcsstk27','nos1');
switch choice_matrix
  case 1
    load Matrices/bodyy4
  case 2
    load Matrices/nos4
  case 3
    load Matrices/bcsstk09
  case 4
    load Matrices/bcsstk05
  case 5
    load Matrices/bcsstk27
  case 6
    load Matrices/nos1 
end
A=Problem.A;
clear Problem;

% Pre-multiply diagonal terms
coeff=input('Diagonal pre-multiplier? ');
A=A+(coeff-1)*diag(diag(A));

% Estimate conditioning
 [largest_eig,smallest_eig]=CondEstim(A);
 fprintf('Conditioning = %e\n',abs(largest_eig)/abs(smallest_eig));

% Solve
b=ones(size(A,1),1);
x0=ones(size(A,1),1);
maxiter=1e4;
eps=1e-8;
choice_method=menu('Choose a method','Gauss-Seidel','Jacobi','Conjugate Gradient');
switch choice_method
  case 1
    fprintf('Using Gauss-Seidel...\n');
    tic;
    [x,iter,niter] = GaussSeidel(A,b,x0,maxiter,eps);
    toc;
    fprintf('Nombre itération : \n');
    iter
    fprintf('Résidu relatif : \n');
    niter(end)
  case 2
    fprintf('Using Jacobi...\n');
    tic;
    [x,iter,niter] = Jacobi(A,b,x0,maxiter,eps);
    toc;
    fprintf('Nombre itération : \n');
    iter
    fprintf('Résidu relatif : \n');
    niter(end)
  case 3
    fprintf('Using Conjugate Gradient...\n');
    tic;
    [x,iter,niter] = CG(A,b,x0,maxiter,eps);
    toc;
    fprintf('Nombre itération : \n');
    iter
    fprintf('Résidu relatif : \n');
    niter(end)

end
plot([0:iter],log(niter));


