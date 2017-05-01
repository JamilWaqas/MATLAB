function y=begeo(x)
%
% BEGEO calculates the beta-geometric negative log-likelihood.
%   mu and theta are the beta-geometric parameters;
%   'data' are global, and set in the calling program
%______________________________________________________________________
global data
mu=x(1);theta=x(2);
n=length(data)-1;			    % n denotes the largest number
loglik=log(mu)*data(1);			% observed, before censoring
p=mu;
s=p;
for i=2:n
  p=p*(1-(mu+theta)/(1+(i-1)*theta));	% this is the recursive way of
					                    % generating beta-geometric
					                    % parameters
  s=s+p;
  loglik=loglik+log(p)*data(i);
end;
p=1-s;					% the right-censored probability
n1=n+1;
y=loglik+log(p)*data(n1);
y=-y;


