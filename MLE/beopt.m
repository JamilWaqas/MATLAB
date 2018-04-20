function y=beopt(x)
%
% BEOPT obtains the beta-geometric log-likelihood
%  as a function of just the one parameter (in this case the first one)
%  so that optimisation can take place, using fminbnd, with respect to
%  that parameter alone, the other, the second in this case, being fixed.
%  This is for obtaining a profile log-likelihood.
%  The first variable, 't', is set in the driving program, and is global.
%  Calls BEGEO, which provides the negative log-likelihood for the beta-geometric model.
%________________________________________________________________________
global t
z=[x t];
y=begeo(z);


