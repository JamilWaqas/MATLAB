function p = pnorm(x)
% pnorm(x)
% distribution function for standard normal

p = 0.5 + 0.5*erf(x/sqrt(2));

