function call = callMerton(S,X,tau,r,q,sigma,lambda,muJ,vJ,N)
% callMerton Pricing function for European calls
% callprice = callMerton(S,X,tau,r,q,sigma,lambda,muJ,vJ,N)
% ---
% S     = spot
% X     = strike
% tau   = time to mat
% r     = riskfree rate
% q     = dividend yield
% sigma = volatility
% lambda= intensity of poisson process
% muJ   = mean jump size
% vJ    = variance of jump process
% N     = number of jumps to be included in sum
% ---
% Manfred Gilli and Enrico Schumann, version 2010-02-19
% http://comisef.eu
%
lambda2 = lambda*(1+muJ); call = 0;
for n=0:N
    sigma_n = sqrt(sigma^2 + n*vJ/tau);
    r_n = r - lambda*muJ+ n*log(1+muJ)/tau;
    call = call + ( exp(-lambda2*tau) * (lambda2*tau)^n ) * ...
        callBSM(S,X,tau,r_n,q,sigma_n)/ exp( sum(log(1:n)) );
end
