% simulating the deviance for lapwings 63--92
% from model V(Rain3)/V(Snow4)/Q(Year)

path(path,'/u1/users/mar/eac/Eagle')

global Ringed nrows ncols const ellmax raind3 snowd4a Year
global M_mc unrec_mc beta_mc lik_mc const_mc;

load lapwing

Years = 63:92;

lapwing_dat
covariate_dat
preproc

diary likmc_Vf3_Vs4_Qy.res

opts(1)=1; opts(2)=5e-4; opts(3)=1e-3; opts(14)=500;
%X1 = ones(nrows,1);
%X1 = [ones(nrows,1),mean_diff(raind3)];
X1 = [ones(nrows,1),mean_diff(frostd3)];
%Xa = ones(ncols-1,1);
Xa = [ones(ncols-1,1),mean_diff(snowd4a)];
%Xlam = ones(ncols,1);
Xlam = [ones(ncols,1),mean_diff(Year),mean_diff(Year).^2];
atype='time';

%beta = bs_C_C_C;
%    0.6171    0.8174    0.0107
%beta = bs_C_Vs4_Qy;
%    0.6285    1.6892   -0.1918   -4.4926   -0.0365    0.0017
%beta = bs_Vr3_Vs4_Qy;
%    0.6319   -0.0746    1.6862   -0.1908   -4.4933   -0.0371    0.0017
beta = bs_Vf3_Vs4_Qy;
%    0.6359   -0.1705    1.6881   -0.1913   -4.4965   -0.0373    0.0018

npars = length(beta);

Phat = probT(beta,X1,Xa,Xlam,atype);

nreps = 99;
beta_mc = zeros(npars,nreps);
lik_mc = zeros(1,nreps);
M_mc = zeros(nrows,ncols);

bstart = [0;0;1;0;-3;0;0];

for rep = 1:nreps,
   fprintf('iteration number %2d\n',rep)
   cm = zeros(1,ncols);  
   for i = 1:nrows,      
      cp = cumsum(Phat(i,:));
      r = rand(Ringed(i),1);     
      for j = i:ncols,
         cm(j) = sum(r < cp(j));
      end   
      M_mc(i,:) = [zeros(1,i-1),cm(i),diff(cm(i:ncols))];
   end;

   unrec_mc = Ringed - sum(M_mc')';
   const_mc = sum(lfact(Ringed)) - sum(sum(lfact(M_mc))) - sum(lfact(unrec_mc));
   
   beta_mc(:,rep) = fminu('likmc',bstart,opts,[],X1,Xa,Xlam,atype);
   lik_mc(rep) = likmc(beta_mc(:,rep),X1,Xa,Xlam,atype);

end

ellhat = likT(beta,X1,Xa,Xlam,atype)
  533.5072

dev_obs = 2*(ellhat+ellmax)
  410.1942

dev = 2*(lik_mc+ellmax);
hist(dev)
xlabel('deviance')
title('Lapwings 63--92 : 99 simulations from V(Nfrost3)/V(Snow4)/Q(Year)')
hold on         
plot(dev_obs,0,'*')
hold off

axis([300,500,0,30])
sum(dev>dev_obs)/100
    0.3000

diary off

nu = 458;
x = nu + sqrt(2*nu)*randn(10000,1); 
hist(x,20)
title('chi-square distribution with 458 df')  
hold on 
x0 = dev_obs;        
plot(x0,0,'*')
hold off
sum(x>x0)/10000
    0.9258

