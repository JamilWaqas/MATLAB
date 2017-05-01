function call = callMertoncf(S,X,tau,r,q,v,lambda,muJ,vJ)
% callMertoncf Pricing function for European calls
% callprice = callMertoncf(S,X,tau,r,q,v,lambda,muJ,vJ)
% ---
% S     = spot
% X     = strike
% tau   = time to mat
% r     = riskfree rate
% q     = dividend yield
% v     = variance (volatility squared)
% lambda= intensity of poisson process
% muJ   = mean jump size
% vJ    = variance of jump process
% ---
% Manfred Gilli and Enrico Schumann, version 2010-02-19
% http://comisef.eu
%
vP1 = 0.5 + 1/pi * quad(@P1,0,200,[],[],S,X,tau,r,q,v,lambda,muJ,vJ);
vP2 = 0.5 + 1/pi * quad(@P2,0,200,[],[],S,X,tau,r,q,v,lambda,muJ,vJ);
call = exp(-q * tau) * S * vP1 - exp(-r * tau) * X * vP2;
end
%
function p = P1(om,S,X,tau,r,q,v,lambda,muJ,vJ)
p = real(exp(-1i*log(X)*om) .* cfMerton(om-1i,S,tau,r,q,v,lambda,muJ,vJ) ./ (1i * om * S * exp((r-q) * tau)));
end
%
function p = P2(om,S,X,tau,r,q,v,lambda,muJ,vJ)
p = real(exp(-1i*log(X)*om) .* cfMerton(om  ,S,tau,r,q,v,lambda,muJ,vJ) ./ (1i * om));
end
%
function cf = cfMerton(om,S,tau,r,q,v,lambda,muJ,vJ)
A = 1i*om*log(S) + 1i*om*tau*(r-q-0.5*v-lambda*muJ) - 0.5*(om.^2)*v*tau;
B = lambda*tau*( exp(1i*om*log(1+muJ)-0.5*1i*om*vJ-0.5*vJ*om.^2) -1);
cf = exp(A + B);
end