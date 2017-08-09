%----------------------------------------------------
% Generate sphere at specific location given radius
%----------------------------------------------------
% Benjamin Karl Hagenau
%----------------------------------------------------
% Created: 6/1/17
% Edited: 6/1/17
%----------------------------------------------------
%INPUTS: inital x,y,z and radius of sphere
%OUTPUTS: coordinates of sphere at starting location with given radius

function [x,y,z] = generate(xi,yi,zi,r)
addpath /Users/Benjamin/Documents/MATLAB/functions

% generate sphere with given radius
[x,y,z] = spheres(r);
% locate to starting position
x = x+xi;
y = y+yi;
z = z+zi;
end