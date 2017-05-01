function lik=ringinglik(pars)
% Finds the likelihood for the standard yearly model
% currently parameters are phi1 (first year survival) phia (adult survival)
% lambda (reporting probability)
Datamatrix=[113 64  29 
              0 124 45 
              0  0  95 ];
F=[1155
   1131
    906];
F=F-sum(Datamatrix,2);

phi1=1/(1+exp(-pars(1)));
phia=1/(1+exp(-pars(2)));
lambda=1/(1+exp(-pars(3)));

sizeData=size(Datamatrix);

nprob=ones(sizeData(1),1);

lik=0;
for i=1:sizeData(1)
    for j=i:sizeData(2)
        if i==j
            prob=(1-phi1)*lambda;
        else
            prob=phi1*phia^(j-i-1)*(1-phia)*lambda;
        end
        nprob(i)=nprob(i)-prob;
        lik=lik+Datamatrix(i,j)*log(prob);
    end
    lik=lik+F(i)*log(nprob(i));
end
lik=-lik;
