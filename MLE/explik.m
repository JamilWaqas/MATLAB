function lik=explik(x)
global data
n=length(data);
lik=-n*log(x)-sum(data)/x;
