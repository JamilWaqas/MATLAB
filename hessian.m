function h = hessian(funfcn,x)  
%
%HESSIAN Calculates a central difference approximation to the
%  hessian matrix of 'funfcn', with respect to 'x'
%  The width of the difference used is twice 'delta'.
%  Code due to Ted Catchpole.
%__________________________________________________________________
delta = 10^(-6);
t = length(x);
h = zeros(t);
Dx = delta*eye(t);
for i = 1:t
  for j = 1:t
  h(i,j)=(feval(funfcn,x+Dx(i,:)+Dx(j,:))-feval(funfcn,x+Dx(i,:)-Dx(j,:))...
          - feval(funfcn,x-Dx(i,:)+Dx(j,:)) + feval(funfcn,x-Dx(i,:)-Dx(j,:)...
      ))/(4*delta^2);
  end
end
