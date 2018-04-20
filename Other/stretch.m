function x = stretch(x0,X1_null,Xa_null,Xlam_null,X1_alt,Xa_alt,Xlam_alt)
% stretch is used for a score test of H0: model "null"
% vs H1: model "alt" at x0.
%
% Note that x0 is given in terms of H0
% x is the "stretching" of x0 for H1.

global nrows ncols;

[dum1 n1null]   = size(X1_null);
[dum2 nanull]   = size(Xa_null);
[dum3 nlamnull] = size(Xlam_null);
[dum4 n1alt]    = size(X1_alt);
[dum5 naalt]    = size(Xa_alt);
[dum6 nlamalt]  = size(Xlam_alt);

if ~(dum1==nrows & dum4==nrows),
   fprintf('wrong size for X matrices for 1st yr survival probablities\n')
   fprintf('these matrices should have %3.0f rows\n',nrows)
   error('')
end
if ~(dum2==ncols-1 & dum5==ncols-1),
   fprintf('wrong size for X matrices for adult survival probablities\n')
   fprintf('these matrices should have %3.0f rows\n',ncols-1)
   error('')
end
if ~(dum3==ncols & dum6==ncols),
   fprintf('wrong size for X matrices for recovery probablities;\n')
   fprintf('these matrices should have %3.0f rows\n',ncols)
   error('')
end

if n1null+nanull+nlamnull ~= length(x0),
   fprintf('X matrices for null model have wrong number of columns\n')
   fprintf('or parameter vector is the wrong length\n')
   error('')
end

x01 = x0(1:n1null);
x0a = x0(n1null+1:n1null+nanull);
x0lam = x0(n1null+nanull+1:n1null+nanull+nlamnull);

xlam = Xlam_alt\(Xlam_null*x0lam);
x1 = X1_alt\(X1_null*x01);
xa = Xa_alt\(Xa_null*x0a);
xlam = Xlam_alt\(Xlam_null*x0lam);

x = [x1; xa; xlam];
