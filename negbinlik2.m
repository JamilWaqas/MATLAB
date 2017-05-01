function y=negbinlik(x)
%
% NEGBINLIK calculates the negative-bionomial log-likelihood
% Input through x are the two parameters, n0 and k
%
global data
n0=x(1); k=x(2); 
p=k/(n0+k);
n=length(data);  % n is the size of the vector data
loglik=0;
for i=1:n
    logprob=gammaln(k+data(i))+k*log(p)+data(i)*log(1-p)-gammaln(data(i)+1)-gammaln(k);
    loglik=loglik+logprob;
end

y=-loglik;