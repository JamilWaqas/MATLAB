% Program to maximise the beta-geometric log-likelihood
% while holding the first variable (t) fixed, and then repeating
% this over a grid of t-values in order to obtain a profile
% log-likelihood with respect to the first variable.
% The scalar 't' is global, so that the function 'beopt' can access
% the value at which 't' is fixed. 'n' is the grid size.
% Calls FMINBND, BEOPT.
%____________________________________________________________________
global t data
data=[29 16 17 4 3 9 4 5 1 1 1 3 7];    % for smokers
%data=[198 107 55 38 18 22 7 9 5 3 6 6 12] % for non-smokers
n=100;
t=0;
for i=1:n
  t=t+.01;
  x(i)=fminbnd('beopt',0.001,0.999);		% this obtains the value of the
					                        % second parameter,
					                        % which maximises the
					                        % log-likelihood when the first
					                        % parameter is fixed at t.
  y(i)=beopt(x(i));			                % this is the value for the profile
					                        % log-likelihood.
end
t1=.01:.01:1;				                % the grid of t-values for plotting
subplot(2,1,1)
plot(x,t1);	
xlabel('\mu');ylabel('\theta')			    % this is the path traced in the
					                        % parameter space, as we move along 
					                        % the profile-log-likelihood
subplot(2,1,2)
plot(y,t1)
xlabel('- log-likelihood');ylabel('\theta') % this is the profile log-likelihood





