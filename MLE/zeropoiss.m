function loglik=zeropoiss(lambda)
%
%  ZEROPOISS is a function for calculating the negative log-likelihood of
%  a zero-truncated Poisson distribution. The parameter is lambda. 
%  The data are stored in 'data', which is a global row vector, and 
%  declared outside the program.
%_______________________________________________________________________
global data
n=length(data);				% n is the largest value in the sample

loglik=0;
for i=1:n
   pr(i)=lambda^i/(factorial(i)*(exp(lambda)-1));
   loglik=loglik+data(i)*log(pr(i));
end

loglik=-loglik;
