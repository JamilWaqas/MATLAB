function fmax(funfcn,x0)
%
%FMAX  minimises a negative log-likelihood, provided by 'funfcn' and also
%  produces, (i) an estimate of the gradient at the
%  optimum, to check for convergence; (ii) An estimate
%  of the Hessian at the maximum, and its eigen-values; (iii) an estimate 
%  of standard errors and correlations, 
%  using the observed Fisher information - see Equation (4.2);
%  x0 is the starting-value for the simplex method used in 'fminsearch'
%  Calls GRAD, HESSIAN and FMINSEARCH.
%______________________________________________________________________________
x=fminsearch((funfcn),x0);		 % x is the maximum likelihood estimate
g=grad((funfcn),x)			 % gradient at the MLE
disp('gradient at the maximum:')
disp(g)
h=hessian((funfcn),x); d=eig(h); % eig finds eigenvalues
disp('eigenvalues of the hessian:')
disp(d)
cov=inv(h); 				 % this now approximates the
					         % dispersion (var/cov) matrix
k=sqrt(diag(cov));			 % the approximation to the std., errors
k1=diag(k);k2=inv(k1);
cor=k2*cov*k2;				 % this now approximates 
					         % the correlation matrix
tril(cor)				 % Ref : HL, p 67				 
cor=tril(cor,-1 )+k1;
out=[x' cor];				 % gives output in standard format
disp('1st column gives the maximum likelihood estimates')
disp('subsequent columns give the standard errors and correlations')
disp(out)


