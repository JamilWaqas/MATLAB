% Program to form the Bohachevsky surface.
%_________________________________________________________
function z=boha(w)
x=w(1); y=w(2);
z=x.*x+2*y.*y-0.3*cos(3*pi*x)-0.4*cos(4*pi*y)+0.7;





