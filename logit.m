function y=logit(t)
%
%LOGIT Calculates the negative log-likelihood for a logistic
%  model and quantal response data
%  x is the 'dose'
%  n is the number of individuals at each 'dose'
%  r is the number of individuals that respond at each 'dose'
%  x,n and r are global variables, set in the driving program
%_____________________________________________________________
global x n r 
alpha=t(1); beta=t(2);
x=[49.06 52.99 56.91 60.84 64.76 68.69 72.61 76.54];
n=[59 60 62 56 63 59 62 60];
r=[6 13 18 28 52 53 61 60];
w=ones(size(x));
y=w./(1+exp(-(alpha+beta*x))); z=w-y;
loglik=r*(log(y))'+(n-r)*(log(z))';
y=-loglik;
plot(y)