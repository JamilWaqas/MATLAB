function y=liky (p)
%
% Program to evaluate the log-likelihood:
% smokers data on times to conception;
% simple geometric model. Can be maximised by fminbnd.
%_________________________________________________________
data1=[29 16 17 4 3 9 4 5 1 1 1 3 7]; 
s1=sum(data1(1:12));
int=0:12;
s2=int*data1';
y=-s2*log(1-p)-log(p)*s1;

