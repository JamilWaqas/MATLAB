function CIeqn=likeqn(mu)
global data
muhat=mean(data);
maxlik=explik(muhat);
CIeqn=explik(mu)-maxlik+0.5*3.841;
