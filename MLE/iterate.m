% Program for steepest ascent of Cauchy log-likelihood
%______________________________________________________
gr=1;
global data start gr
data=[1.09   -0.23    0.79    2.31   -0.81]
start=[.5 .5]
while norm(gr)>.0001
   gr=grad('cauchy', start)
   lambda=fminbnd('linesearch', -0.5,0.5);
   % Thus lambda maximises the function along the line of search
   start=start+lambda*gr'
end
