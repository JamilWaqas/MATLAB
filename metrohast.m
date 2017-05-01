% Program for Metropolis-Hastings analysis for driving school data
% X ~ Geo(p), prior: p~Beta(alpha,beta)

% Driving school data
%data=[71 39 14 10 7 3 0 0 3];
 data=[99 39 17 13 6 6 5 1];
% Prior parameters
alpha=113.6;
beta=205;

nocy=50000;

% Initalise the vector y
y=zeros(nocy+1,1);

% Inital value
y(1)=0.3;

for i=2:nocy+1
   b=y(i-1);
   a=rand;
   A=sum(data(1:8))+alpha-1;
   B=sum(data(1:8).*(1:8))+data(8)*8-sum(data(1:8))+beta-1;
   posta=a^A*(1-a)^B;
   postb=b^A*(1-b)^B;
   alphacrit=min(1,posta/postb);
   if alphacrit>rand
       y(i)=a;
   else
       y(i)=b;
   end
end

burnin=10000;
plot(0:nocy,y,'k')
axis([0 nocy 0.3 0.5])
xlabel('i')
ylabel('y^(^i^)')
postmean=mean(y(burnin+1:nocy+1))
poststd=std(y(burnin+1:nocy+1))


