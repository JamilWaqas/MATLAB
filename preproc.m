global Ringed Mobs unrec nrows ncols const Toe ellmax lik_max opts

[nrows ncols] = size(Mobs);
unrec = Ringed - sum(Mobs')';			  % unrecovered birds
const = sum(lfact(Ringed)) - sum(sum(lfact(Mobs))) - sum(lfact(unrec));
Toe = toeplitz([0,ones(1,nrows-1)],zeros(1,ncols));

ellmax = ( const + sum(sum(Mobs(Mobs>0).*log(Mobs(Mobs>0)))) ...
            + sum(unrec(unrec>0).*log(unrec(unrec>0))) ...
            - sum(Ringed(Ringed>0).*log(Ringed(Ringed>0))) );
lik_max = ellmax;
df = sum(sum(Mobs > 0));

% fprintf('Loglikelihood for maximal model is\n')
% fprintf(' lik_max = %10.4f on %4.0f d.f.\n\n',ellmax,df)

opts = zeros(1,18);
opts(2) = 5e-4;
opts(3) = 5e-4;
opts(14) = 1000;

