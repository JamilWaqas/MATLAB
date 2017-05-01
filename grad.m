function g = grad(funfcn,x)   
%
%GRAD Calculates a central difference approximation to the first-order
%  differential of 'funfcn' with respect to 'x'.
%  The difference width used is twice 'delta'.
%  Code due to Ted Catchpole.
%______________________________________________________________________
delta = 10^(-6);
t = length(x);
g = zeros(t,1);
Dx = delta*eye(t);			% eye :identity matrix
for i = 1:t
  g(i) = (feval(funfcn,x+Dx(i,:)) - feval(funfcn,x-Dx(i,:)))/(2*delta);
end
% For information on feval, see Hanselman and Littlefield (1998, p155).
