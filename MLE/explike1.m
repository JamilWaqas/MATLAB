function loglik=explike1(pars)
% Finds minus the log-likelihood for an exponential distribution with mean mu
global data
mu=pars(1);

loglik=-sum(log(exppdf(data,mu)));

end

