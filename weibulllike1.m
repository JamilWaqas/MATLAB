function loglik=weibulllike1(pars)
%Find minus log-likelihood for a Weibull distribution with parameters a and
%b
%To check the parameterisation use help wblpdf
global data
a=pars(1);
b=pars(2);

loglik=-sum(log(wblpdf(data,a,b)));

end

