function x=annealing_boha(funfcn,x0)

%  ANNEALING Performs General Simulated Annealing,
%  to minimise a function of several variables, specified in 'funfcn'.
%  Code due to Paul Terrill.
%_____________________________________________________________________
%  x0 contains the initial parameter estimates
%  T is the current temperature
%  N is the number of iterations at each temperature
%  s is the number of times we accept a new point for a given temperature
%  r defines the annealing schedule
%  p is the number of parameters
%__________________________________________________________
p=length(x0);
T=1; N=5000; r=0.90;
x=x0;
Eold=feval(funfcn,x0);
s=1;
while s>0
  s=0;
  for i=1:N
    rand('state',sum(100*clock));% sets a different seed for 
                                 % the random number generator.
    u1=rand;                     % u1 is used to select a particular
                                 % parameter.
    for i=1:p
      if u1 < i/p                % sets a new value for one
        x(i)=0.25*((rand-0.5));  % of the parameters according
        u1=2;                    % to the range of x(i). This needs
      end			             % careful consideration for each
    end				             % problem considered. Cf. 'fminbnd'.
    Enew=feval(funfcn,x);
    u2=rand;
    del=Enew-Eold;
    crit=exp(-del/T);
    if u2<=crit                  % checks criterion for accepting
      x0=x;                      % new point. If the point is accepted,
      Eold=feval(funfcn,x0);     % we set s=s+1.
      s=s+1;
    end
  end
  T=r*T;
end
x=x0;

