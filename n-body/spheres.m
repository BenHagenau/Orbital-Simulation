function [ x,y,z ] = spheres( r )
%SPHERES generates lines that create a sphere
phi=linspace(0,pi,100);
theta=linspace(0,2*pi,100);
[phi,theta]=meshgrid(phi,theta);

x=r*sin(phi).*cos(theta);
y=r*sin(phi).*sin(theta);
z=r*cos(phi); 
end

