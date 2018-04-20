function y=preference(x)
%
%PREFERENCE calculates the negative log-likelihood for
%   the fecundability model, allowing for digit preference
%   into 6 and 12 months.
%   'data' are global, and are set in the driving program.
%________________________________________________________________________
global data
al=-14.8085; b1=0.492;m1=x(3); t1=x(4);
a=1/(1+exp(al));			% logistic transformation
b=1/(1+exp(b1));			% to keep parameters in the
m=1/(1+exp(m1));			% 0-1 range. Not generally
t=1/(1+exp(t1));			% useful for t, but 
p(1)=m;					% satisfactory in this case
for i=2:17
  p(i)=p(i-1)*(1-(m+t)/(1+(i-1)*t));	% sets up the basic beta-geometrics
end
s1=0;					% now we add the confusion
for i=1:5				% probabilities
  p(i)=p(i)*(1-a^abs(i-6));
  s1=s1+p(i);
end
for i=7:11
  p(i)=p(i)*(1-a^abs(i-6)-b^abs(12-i));
  s1=s1+p(i);
end
s=0;
for i=1:11
  s=s+p(i)*a^abs(i-6);
end
p(6)=s;
s=0;
for i=7:17
  s=s+p(i)*b^abs(i-12);
end
p(12)=s;
p(13)=1-s1-p(6)-p(12);
p=log(p);
y=-data*p(1:13)';


