function s=score(funfcn,x)

%  SCORE preforms a score test and returns the score test 
%  Calls GRAD and HESSIAN.

H=hessian((funfcn),x);
g=grad((funfcn),x);
s=g'*inv(H)*g;
