function w=linesearch(x)
%
% LINESEARCH calculates the Cauchy log-likleihood along a particular
% line in the parameter space.
% This is a stage in the method of steepest ascent applied to this
% surface.
%___________________________________________________________________
global data start gr
w=cauchy(start+x*gr');
