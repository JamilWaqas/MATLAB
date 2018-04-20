% Program to select a number of random points in the parameters space
% and then perform a simplex search of the surface starting from each of those
% points. Whenever the selected optimum is the global minimum, then the starting
% point is plotted on the Bohachevsky surface, this having already been plotted
% using the program boha_contours.m and the plot held, using the hold command
% The count counter records how many of the starting points are plotted in this
% way.
%_______________________________________________________________________________
count=0;
for i=1:10000
w=(2*(rand(1,2)-0.5));z=w';x=w;
w=fminsearch('boha_surface', x);
if(abs(w)<0.001)
    count=count+1;
plot(x(1),x(2),'.')
else
end
end
count


