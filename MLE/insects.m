function loglik=insects(lambda)
%
% 
uncen=[43 26 38 18 18 22 57 32 21 45 10 17 2 32 56 25];
n1=length(uncen);
T=100;
n2=4;
loglik=n1*log(lambda)-lambda*sum(uncen)-lambda*T*n2;
loglik=-loglik;

