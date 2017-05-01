function call = callBSMcf(S,X,tau,r,q,vT)
% callBSMcf Pricing function for European calls
% callprice = callBSMcf(S,X,tau,r,q,vT)
% ---
% S     = spot
% X     = strike
% tau   = time to mat
% r     = riskfree rate
% q     = dividend yield
% vT    = variance (volatility squared)
% ---
% Manfred Gilli and Enrico Schumann, version 2010-02-05
% http://comisef.eu
%
vP1 = 0.5 + 1/pi * quad(@P1,0,200,[],[],S,X,tau,r,q,vT);
vP2 = 0.5 + 1/pi * quad(@P2,0,200,[],[],S,X,tau,r,q,vT);
call = exp(-q * tau) * S * vP1 - exp(-r * tau) * X * vP2;
end
%
function p = P1(om,S,X,tau,r,q,vT)
p = real(exp(-1i*log(X)*om) .* cfBSM(om-1i,S,tau,r,q,vT) ./ (1i * om * S * exp((r-q) * tau)));
end
%
function p = P2(om,S,X,tau,r,q,vT)
p = real(exp(-1i*log(X)*om) .* cfBSM(om  ,S,tau,r,q,vT) ./ (1i * om));
end
%
function cf = cfBSM(om,S,tau,r,q,vT)
cf = exp(1i * om * log(S) + 1i * tau * (r - q) * om - 0.5 * tau * vT * (1i * om + om .^ 2));
end