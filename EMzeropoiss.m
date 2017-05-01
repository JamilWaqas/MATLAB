%
% Program to take a data set from a zero-truncated Poisson distribution,
% and then  estimate the Poisson parameter using the EM algorithm. 
% The data are stored in 'data', which is a global row vector, and 
% declared outside the program.
%

global data
nit=10;                  % This is the number of iterations
s=1;				     % This is the starting value
                         % Note we start with a value for the missing
                         % observation, rather than the parameter
n=length(data); z=0:1:n;
for i=1:nit
  datacomp=[s data];
  w=sum(datacomp);
  n=z*datacomp';
  m=n/w;				% this is the M-step, where we updated the parameter
  e1=exp(-m);
  s=e1*w;				% this is the E-step, where we update the missing
                        % observation
  results=[i  m  s]
end
