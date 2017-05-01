% Program to produce log-likelihood surface for beta-geometric model
% Note that here we use the MATLAB elementwise
% operations, '.*' and './'
%___________________________________________________________
%data=[92 42 18 8 10 4 3 2 21];    % for driving scool 1
data=[115 23 4 4 2 1 0 0 1] % for driving school 2 
[mu,theta]=meshgrid(0.01:0.01:0.9,0.01:0.01:1.0);
loglik=log(mu)*data(1);	 	  % mu and theta are now matrices
p=mu;					  % of the same dimensions: the
s=p;					  % rows of m are copies of the
for i=2:8				  % vector (0.01, 0.02,...,0.9), and
  p=p.*(1-(mu+theta)./(1+(i-1)*theta)); % the columns of theta are copies
  s=s+p;				  % of the vector (0.01, 0.02,...,1.0)'.
  loglik=loglik+log(p)*data(i);	  % recursive specification of the
end					  % beta-geometric probabilities
p=ones(size(mu))-s;
loglik=loglik+log(p)*data(9);		% completes log-likelihood
contour(0.01:0.01:0.9,0.01:0.01:1.0,loglik,200)  % plots the contours
xlabel \mu; ylabel \theta           % last number is no. of contours
