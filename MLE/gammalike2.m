function loglik=gammalike1(pars)
global data
mu=pars(1);
beta=pars(2);
alpha=mu*beta; % This is the error should be alpha=mu/beta

nobs=length(data);

loglik=0;
for i=1:nobs
    loglik=loglik-alpha*log(beta)-gammaln(alpha)+(alpha-1)*log(data(i))-data(i)/beta;
end

loglik=-loglik;

