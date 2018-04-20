
%
%LOGIT Calculates the negative log-likelihood for a logistic
%  model and quantal response data
%  x is the 'dose'
%  n is the number of individuals at each 'dose'
%  r is the number of individuals that respond at each 'dose'
%  x,n and r are global variables, set in the driving program
%_____________________________________________________________

%Question 3
x = [49.06,52.99,56.91,60.84,64.76,68.69,72.61,76.54]
 n = [59 60 62 56 63 59 62 60];
 r=  [6 13 18 28 52 53 61 60]
 
 %part(b)
 
 scatter(x,r./n)
 xlabel('number of doses(x_i)');ylabel('response ratio(r_i divided by n_i)');
 title('Response ratio against doses');
 %part (c)
 hold;
 h=ones(size(x));
 alpha=-14.8085;
 beta=0.2492;
 y=h./(1+exp(-(alpha + beta*x)));
 plot(x,y)
 %As we can see from the graph it is a good fit
 
  
