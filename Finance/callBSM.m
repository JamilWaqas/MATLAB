function call = callBSM(S,X,tau,r,q,sigma)
% callBSM Pricing function for European calls
% callprice = callBSM(S,X,tau,r,q,sigma)
% ---
% S     = spot
% X     = strike
% tau   = time to mat
% r     = riskfree rate
% q     = dividend yield
% sigma = volatility
% ---
% Manfred Gilli and Enrico Schumann, version 2010-02-15
% http://comisef.eu
%
d1 = ( log(S/X) + (r-q+sigma^2/2)*tau ) / (sigma*sqrt(tau));
d2 = d1 - sigma*sqrt(tau);

call = S*exp(-q*tau)*normcdf(d1,0,1) - X*exp(-r*tau)*normcdf(d2,0,1);
