% Program to produce graphs of log-likelihood for geometric model
%______________________________________________________________________
data1=[92 42 18 8 10 4 3 2 21]; %driving school 1 data 
s1=sum(data1(1:8));
data2=[115 23 4 4 2 1 0 0 1]; %driving school 2 data
s3=sum(data2(1:8));
int=0:8;			     % produces the vector, int=[0,1,...,8];
p=0.01:0.01:.99;		    % produces the vector,
s2=int*data1';			    % p=[0.01, 0.02, ..., 0.99];
s4=int*data2';			    % sums are formed without using loops
loglik1=s2*log(1-p)+log(p)*s1;  % now we form the two log-likelihoods
loglik2=s4*log(1-p)+log(p)*s3;
plot(p,loglik1, '-',p,loglik2,'--')  % plot the log-likelihood
legend('Driving school 1','Driving school 2')
xlabel ('p')
ylabel ('log-likelihood')
title ('Graph of log-likelihood versus p')


