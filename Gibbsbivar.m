%
% A program to preform Gibbs sampling for the bivariate normal distribution
% with with zero mean and unit variance for the marginals, but a 
% correlation of rho between the two variables. 
%

nocy=1000;
rho=0.28;

% Initalise the vectors x1 and x2
x1=zeros(nocy+1,1);
x2=zeros(nocy+1,1);

%Inital values
x1(1)=0;
x2(1)=0;

for i=2:nocy+1
   x1(i)=normrnd(rho*x2(i-1),sqrt(1-rho^2));
   x2(i)=normrnd(rho*x1(i),sqrt(1-rho^2));
end

burnin=30;
figure;
subplot(1,2,1); plot(x1);title('1000 iterations  with burnin of 30'); xlabel('i');  ylabel('x_1^(^i^)'); 
subplot(1,2,2); plot(x2);title('1000 iterations  with burnin of 30'); xlabel('i');  ylabel('x_2^(^i^)'); 

figure;
colormap([1 1 1])

subplot(1,2,1); hist(x1(burnin+1:nocy+1));title('1000 iterations with burnin of 30'); xlabel('x_1^(^i^)'); ylabel('freq')
subplot(1,2,2); hist(x2(burnin+1:nocy+1));title('1000 iterations with burnin of 30'); xlabel('x_2^(^i^)'); ylabel('freq')

