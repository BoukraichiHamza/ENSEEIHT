clear all
close all
n=4;
U=gallery('orthog',n);
D=diag(ones(n,1));
i=1;
for k=1:16
    D(1,1) = 10^k;
  %TO DO: modifier D pour obtenir A tel K(A)=10^k
  A=U*D*U';

  %Gram-Schmidt classique 
  Qcgs=cgs(A);

  %Gram-Schmidt modifié
  Qmgs = mgs(A);
  
  %Gram-Shmidt Classique *2
  Qcgs2 = cgs(cgs(A));
  
  %Gram-Shmidt Modifié *2
  Qmgs2 = mgs(mgs(A));

  po(1,k)=norm(eye(n)-Qcgs'*Qcgs);
  po(2,k)=norm(eye(n)-Qmgs'*Qmgs);
  po(3,k)=norm(eye(n)-Qcgs2'*Qcgs2);
  po(4,k)=norm(eye(n)-Qmgs2'*Qmgs2);
end
semilogy(po(1,:),'r')
hold on
semilogy(po(2,:),'b')
hold on
semilogy(po(3,:),'y')
hold on
semilogy(po(4,:),'g')
legend('CGS','MGS');
xlabel('logarithm of the condition number of A_k')
ylabel('|| I - Q_k^TQ_k ||')
