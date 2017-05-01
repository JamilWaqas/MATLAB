
%
% WEATHER fits a linear regression model and a Poisson GLM to the weather
% example on slide 2 of chapter 8.
%

% y is the number of claims and x is the mean temperature.
y=[146 97 59 52 14 1 2 1 2 20 59 121 305 182 139 60 4 2 3 1 4 3 67 269 129 76 42 24 9 6 2 5 6 21 39 127 190 234 47 24 12 2 1 1 6 24 42 137];
x=[4.9 6.3 7.6 7.8 12.1 15.1 15.5 16.6 14.7 10.3 7 5.8 3.2 4.4 5.2 7.7 12.6 14.3 17.2 16.8 13.4 13.3 7.5 3.6 5.5 7 7.6 9.3 11.8 14.4 16 17 14.4	10.1 8.5 5.7 4.5 3.9 7.5 9.6 12.1 16.1 17.6 18.3 14.3 9.2 8.4 5.2];

% NB There are other options for fitting a linear regression model in MATLAB
display('linear model, const + temp')
b = glmfit(x,y,'normal');
xx=0:1:20;
yfit=b(1)+b(2)*xx;
plot(x,y,'x',xx,yfit,'-')
xlabel('mean temperature, x')
ylabel('number of claims, y')


figure;
display('generalised linear model, const + temp')
[b,dev,stats] = glmfit(x,y,'poisson');
pars=stats.beta
se=stats.se
dev=dev
tstat=[stats.t stats.p]
xx=0:1:20;
yfit=exp(b(1)+b(2)*xx);
plot(x,y,'x',xx,yfit,'-')
xlabel('mean temperature, x')
ylabel('number of claims, y')

%Additional corvariate age of claimant.
x2=[45	20	44	50	49	26	46	23	60	20	22	66	68	34	20	23	36	37	21	69	36	43	48	59	80	34	52	31	92	58	27	20	53	20	20	64	59	44	69	38	20	26	58	70	63	20	20	28];
display('generalised linear model, const + temp + age')
[b,dev,stats] = glmfit([x' x2'],y','poisson');
pars=stats.beta
se=stats.se
dev=dev
tstat=[stats.t stats.p]

display('Constant model')
[b,dev] = glmfit(ones(48,1),y,'poisson','constant','off')