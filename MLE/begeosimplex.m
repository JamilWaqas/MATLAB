% Program to carry out a simplex search of the fecundability data and
% calculate the MLEs and variances and covariances of the parameter estimates.
% x0(1)=mu, x0(2)=theta
% Calls FMAX and BEGEO.
%___________________________________________________________________________
global data
%data = [29 16 17 4 3 9 4 5 1 1 1 3 7];       % data for smokers
data = [198 107 55 38 18 22 7 9 5 3 6 6 12];  % data for non-smokers
x0(1)= 0.2; x0(2)= 0.05;
fmax('begeo',x0);

