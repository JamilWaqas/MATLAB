
global data

mu=1.4;
beta=0.06;
alpha=mu/beta;
datasize=20;
nosims=100;

muv1=[];
muv2=[];

for i=1:nosims
   data=gamrnd(alpha,beta,datasize,1);
   stpars=[1.4 0.06];
   pars=fminsearch('gammalike1',stpars);
   muv1=[muv1 pars(1)];
   pars=fminsearch('gammalike2',stpars);
   muv2=[muv2 pars(1)];
end
subplot(1,2,1)
hist(muv1)
colormap([1 1 1])
title('gammalike1')
xlabel('\mu')
ylabel('freq')
subplot(1,2,2)
hist(muv2)
colormap([1 1 1])
xlabel('\mu')
ylabel('freq')
title('gammalike2')


