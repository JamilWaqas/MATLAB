% Program to perform Newton-Raphson iteration on Example 3.2,
% using the gradient and Hessian numerical approximations in GRAD and 
% HESSIAN
% 'data' are global, so that they can be accessed by the 'cauchy'
% function.
% Calls the functions GRAD, HESSIAN and CAUCHY.
%_______________________________________________________________________
global data
data=[1.09, -0.23, 0.79, 2.31, -0.81];
x0=[.7 .3];			 % starting value for Newton Raphson
g=[1,1];			 % value selected to start the 'while'
while norm(g)>0.00001		 % loop
  g=grad('cauchy',x0);
  h=hessian('cauchy',x0);
  xn=x0'-inv(h)*g;
  x0=xn';
end
disp(x0)			 % the maximum-likelihood estimate
disp(g)				 % the gradient at the maximum
disp(eig(h))         % the eigen values of the Hessian at
                 	   % maximum-likelihood estimate

