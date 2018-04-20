function loglik=binomial(p)
global data
n=length(data);
loglik=0;
for i=1:n
    pr(i)=(factorial(n)/(factorial(n-i)*factorial(i)))*p^i*(1-p)^(n-i);
   loglik=loglik+data(i)*log(pr(i));
end

loglik=-loglik;
 
