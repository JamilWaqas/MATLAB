%
% Program to examine the insect data set and estimate lambda using the 
% EM algorithm. 
%
nit=5;
uncen=[43 26 38 18 18 22 57 32 21 45 10 17 2 32 56 25];
n1=length(uncen);
T=100;
n2=4;			 
lambda=0.02;
for i=1:nit
   lambda=lambda*(n1+n2)/(n2+lambda*sum(uncen)+n2*T*lambda);
   results=[i lambda]
end


