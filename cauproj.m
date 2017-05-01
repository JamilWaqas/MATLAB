% Program to produce the isometric projection
% of the Cauchy log-likelihood surface
%_________________________________________________________
data=[1.09,-0.23,0.79,2.31,-0.81];
n=length(data);
[a,b]=meshgrid(-1:0.01:2.5, 0.1:0.01:1.6);
loglik=n*log(b);
k=ones(size(a));
for i=1:n
  loglik=loglik-log(b .^2 +(data(i)*k-a) .^2); 
end
subplot(2,1,1)
  meshc(a,b,loglik); %plots an isometric projection of surface
  xlabel '\alpha'
  ylabel '\beta'
  zlabel 'log-likelihood'
subplot(2,1,2)
  [cs,h]=contour(a,b,loglik, 50);  %contour plot projected below
  xlabel '\alpha'
  ylabel '\beta'
  