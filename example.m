%% example BSM
S       = 100;      %spot price
q       = 0.08;     %dividend yield (eg, 0.03)
r       = 0.02;     %interest rate (eg, 0.03)
X       = 100;      %strike
tau     = 1;        %time to maturity
v       = 0.2^2;    %variance

tic, call =callBSMcf(S,X,tau,r,q,v); 
fprintf('BSM price with CF:\t %f, required time: %f seconds\n',call,toc)

tic, call = callBSM(S,X,tau,r,q,sqrt(v));
fprintf('BSM price with classic formula:\t %f, required time: %f seconds\n',call,toc)
disp(' -- ')

%% example Heston
S       = 100;
q       = 0.00;
r       = 0.03; 
X       = 100;
tau     = 2;
k       = 1.0;      % mean reversion speed (kappa in paper)
sigma   = 0.5;      % vol of vol
rho     = -0.7;     % correlation
v0      = 0.2^2;    % current variances
vT      = 0.2^2;    % long-run variance (theta in paper)

tic, call = callHestoncf(S,X,tau,r,q,v0,vT,rho,k,sigma);
fprintf('Heston with CF:\t %f, required time: %f seconds\n',call,toc)
disp(' -- ')

%% example Bates
S       = 100;
q       = 0.08;
r       = 0.02; 
X       = 100;
tau     = 2.5;
k       = 2.0;      % mean reversion speed (kappa in paper)
sigma   = 0.3;     % vol of vol
rho     = -0.3;     % correlation
v0      = 0.3^2;    % current variances
vT      = 0.3^2;    % long-run variance (theta in paper)
lambda  = 0.3;      % intensity of jumps;
muJ     = -0.1;     % mean of jumps;
vJ      = 0.3^2;    % variance of jumps;

tic, call = callBatescf(S,X,tau,r,q,v0,vT,rho,k,sigma,lambda,muJ,vJ);
fprintf('Bates with CF:\t %f, required time: %f seconds\n',call,toc)
disp(' -- ')

%% example Merton jump--diffusion
S       = 100;
q       = 0.01;
r       = 0.02; 
X       = 100;
tau     = 1;
v       = 0.3^2;    % variance
lambda  = 0.2;      % intensity of jumps;
muJ     = -0.1;     % mean of jumps;
vJ      = 0.3^2;    % variance of jumps;
N       = 20;       % number of jumps for classic formula

tic, call = callMertoncf(S,X,tau,r,q,v,lambda,muJ,vJ);
fprintf('Merton JD price with CF:\t %f, required time: %f seconds\n',call,toc)

tic,call = callMerton(S,X,tau,r,q,sqrt(v),lambda,muJ,vJ,N);
fprintf('Merton JD price with classic formula:\t %f, required time: %f seconds\n',call,toc)