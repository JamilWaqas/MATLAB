function VaRBOA(NbTraj)
 %Function computing the portfolio's value at risk.
 %Initial values of the indices and the exchange rate.
 FTSE = 6752.40;
 SEuroNext = 1008.81;
 e=1.42;
 %Computation of the indices proportions that we buy.
 NbFTSE = 50000/(e*FTSE);
 NbEuroNext = 50000/SEuroNext;
 %250 working days per year
 NbSteps=250;
 DeltaT=1;
 %Cholesky decomposition of the covariance matrix.
 L=chol([1,0.86118,-0.12536;0.86118,1,-0.21609;-0.12536,-0.21609,1])';
 %Vector keeping the simulated values for the portfolio.
 PortfolioValue=zeros(NbTraj,1);
 %Loop simulating the trajectories.
 for i=1:NbTraj
    %Re-initialization of the indices values and exchange rate.
    FTSE = 6752.40;
    SEuroNext = 1008.81;
    e=1.43;
    %Loop simulating the indices and exchange rates dynamic.
    for k=1:NbSteps
        Z=L*randn(3,1);
        FTSE=FTSE*(1+0.001303+0.00885*Z(1,1));
        SEuroNext = SEuroNext*(1+0.002611+0.01285*Z(2,1));
        e = e*(1+0.0011777+0.004001*Z(3,1));
    end
    %Computation of the portfolio's final value.
    PortfolioValue(i,1)=NbEuroNext*SEuroNext+NbFTSE*FTSE*e;
   end
 %Sorting of the final value of the portfolio and computation of the
 %value at risk.
 PortfolioValue=sort(PortfolioValue);
 VaR=mean(PortfolioValue) - PortfolioValue(floor(NbTraj*0.01),1);
 disp(VaR);
 
end
 
 
