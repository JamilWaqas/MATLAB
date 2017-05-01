
% Program for the Newton-Raphson method for the
% two-parameter Cauchy likelihood of Example 3.2,
% giving full detail of the gradient and Hessian
% construction.
%____________________________________________________
x0=[.7,.3];			% starting value for the iteration
x0=x0';
data=[1.09,-0.23,0.79,2.31,-0.81];
one=ones(size(data));
g=[1,1];			% starting value for the 'while'
while norm(g)>0.00001		% command
  a=x0(1);b=x0(2);
  b2=b^2;
  a=a*one;
  b2=b2*one;
  x1=data-a;
  den=b2+x1 .^2;
  den2=den .^2;
  g(1)=2*sum(x1 ./den);	% the gradient vector components
  g(2)=sum((x1 .^2-b2) ./(b*den));
  h(1,1)=2*sum((x1 .^2-b2) ./den2);
  h(1,2)=-4*b*sum(x1 ./den2);
  h(2,1)=h(1,2);
  h(2,2)=-5/b^2-h(1,1);	% completes specification of the			
  xn=x0-inv(h)*g';		% Hessian matrix
  x0=xn;
end 
disp(x0)
disp(g)
disp(eig(h))
