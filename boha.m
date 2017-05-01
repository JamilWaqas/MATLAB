% Program to produce the isometric projection
% of Bohachevsky surface
%_________________________________________________________
[x,y]=meshgrid(-1:0.01:1.0, -1:0.01:1.0);
z=x.*x+2*y.*y-0.3*cos(3*pi*x)-0.4*cos(4*pi*y)+0.7;
meshc(x,y,z); 
xlabel('x')
ylabel('y')
zlabel('z')

