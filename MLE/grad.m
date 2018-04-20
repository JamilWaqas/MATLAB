function g = grad(funfcn,x,X1,Xa,Xlam,atype)   

delta = 10^(-6)*ones(1,length(x));   % change this for better accuracy
Dx = diag(delta);

g = zeros(size(x));

for i = 1:length(x)
  g(i) = (feval(funfcn,x+Dx(:,i),X1,Xa,Xlam,atype) ...
        - feval(funfcn,x-Dx(:,i),X1,Xa,Xlam,atype))/(2*delta(i));
end

