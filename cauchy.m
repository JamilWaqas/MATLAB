function y=cauchy(x)
%CAUCHY calculates minus the Cauchy log-likelihood.
% 'alpha', 'beta' are the standard Cauchy parameters;
% 'data' are global, and set in the calling program.
%__________________________________________________
global data
alpha=x(1); beta=x(2);
x(2)=0.1;
alphv=alpha*ones(size(data));
datashift=(data-alphv).^2;
beta2v=(beta^2)*ones(size(data));
arg=log(beta2v+datashift);
loglik=length(data)*log(beta)-sum(arg);
y=-loglik;
