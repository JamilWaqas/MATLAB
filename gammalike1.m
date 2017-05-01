function loglik=gammalike1(pars)
global data
mu=pars(1);
beta=pars(2);
alpha=mu/beta;

loglik=-sum(log(gampdf(data,alpha,beta)));

end

