function y=delta(u)
%
% DELTA calculates a normal kernel
%_____________________________________
y=(exp(-u*u/2))/sqrt(2*pi);

% Alternative code for kernel with K(x)=1/2 if |x|<1 or 0 otherwise
%if abs(u) < 1
%    y=0.5
%else
%    y=0
%end


