%Kernel density for yeast cell reproduction times

% Cell reproduction times in hours
data=[
1.2
1.35
1.5
1.45
1.45
1.25
1.35
1.6
1.4
1.15
1.1
1.35
1.4
1.3
1.35
1.25
1.25
1.4
1.2
1.4
1.25
1.3
1.15
1.2
1.6
1.45
1.4
1.1
1.15
1.35
0.8
1.35
0.95
1.45
1.2
1.3
1.1
1.2
1.1
1.2
0.95
1.2
1.3
1.2
1
1.25
0.95
1.15
1.3
0.9
0.95
1
0.95
1.4
1.25
1.1
1.3
0.95
1.35
1.066666667
1.15
1.3
1.15
1.7
1.15
0.85
1.3
1.15
1.65
1.05
1.033333333
1.033333333
1.2
1.033333333
1.166666667
0.9
1.233333333
1
1
1.133333333
1.1
];

n=length(data);

pars=gamfit(data); % finds the gamma maximum liklihood estimates for data
x=0.6:0.01:1.9;
fx=gampdf(x,pars(1),pars(2)); % find the gamma pdf for x

% Find the kernel density for x 
k1=0.4;
nn=length(x);
for i=1:nn
      fK(i)=kernel(x(i),data,k1);
end

% Find second the kernel density for x
k1=0.9;
nn=length(x);
for i=1:nn
      fK2(i)=kernel(x(i),data,k1);
end

hist(data, 0.7:0.1:1.8) %plots histogram of data
colormap([1 1 1])
hold on
plot(x,fx*n*0.1,'-k')
plot(x,fK*n*0.1,'--k')
plot(x,fK2*n*0.1,':k')
xlabel('time')
ylabel('freq')