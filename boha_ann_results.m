% Program to take a number of random starts for the Bohachevsky surface, and
% for each of these perform simulated annealing. Noote that the particular
% program used is annealing_boha.m. The points reached, from each of the starts,
% are plotted on the countour surface, this having been previously plotted
% using the boha_countres.m program.
%_____________________________________________________________________________
for i=1:20
x=(2*(rand(1,2)-0.5));
w= annealing_boha('boha_surface', x);
plot(w(1),w(2),'.')
end


