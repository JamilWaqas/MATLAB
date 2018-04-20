function A = mexpT(x,X1,Xa,Xlam,atype)   
% expected numbers of recoveries

global Ringed Mobs unrec nrows ncols const Toe ellmax;

P = probT(x,X1,Xa,Xlam,atype);

for i = 1:nrows,
  for j = 1:ncols,
    A(i,j) = Ringed(i)*P(i,j);
  end
end

