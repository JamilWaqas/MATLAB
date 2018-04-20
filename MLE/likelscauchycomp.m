% Program to produce graphs of -log-likelihood for 2-parameter cauchy model
% with beta = 0.1 and beta = 2
%______________________________________________________________________
global data;
data=[-4.20 -2.85 -2.30 -1.02 0.70 0.98 2.72 3.50];
alpha=-6:0.01:6;
[m n] = size(alpha);
for k=1:n
   x(1)=alpha(k);
   x(2)=0.1;
   loglik1(k)=cauchy(x);
   x(2)=2;
   loglik2(k)=cauchy(x);
end
plot(alpha,loglik1, '-', alpha, loglik2, '--')
xlabel alpha; ylabel -loglikelihood
