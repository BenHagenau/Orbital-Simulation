%Author: Benjamin Hagenau
%Created: 1/27/17

%This program simulates landing on a celestial body

%Main
close all
clear all
clc

%NOTE: EVERYTHING NEEDS TO BE SCALED SO THAT THE TIME IT TAKES IS NOT REAL

%define constans
G = 6.67408 * 10^-11; %[m^3 kg^-1 s^-2]

%define plot size
min =  -15*10^6; %[m]
max =  15*10^6; %[m]

%define main body
r1 = 6.371*10^6; %radius of earth [m]
[x1,y1,z1] = spheres(r1);
m1 = 5.972 * 10^24; %mass of earth [kg]
c1 = [0 0 0]; %[m]
v1 = [0 0 0]; %[m/s]

%define orbiting body
[x2,y2,z2] = spheres(10^4);
m2 = 45702; % Apollo 11 launch mass [kg]
c2 = [r1 0 0]; %[m]
%determine escape velocity
vESC = sqrt(2*G*m1/r1);
%define velocity due to earth's angular rate
wEARTH = 2*pi/86164.1;
vROT = wEARTH*r1;
v2 = [vESC/100 vROT*50 0]; %[m/s]

%determine escape velocity

startTIME = cputime;
on = 0;
dt = 1;
check = 1;
while check == 1
%define directions and distances between the two bodies
    r12 = norm([c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]);
    u21 = [c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]/r12;
    u12 = ([c2(1) - c1(1),c2(2) - c1(2),c2(3) - c1(3)])/r12;  
%calculate acceleration as vectors
    a1 = (G*m1/r12^2)*u21;
    a2 = (G*m2/r12^2)*u12;
%calculate velocity as vectors
    v1 = v1 + a2*dt;
    v2 = v2 + a1*dt;
%calculate position
    c1 = c1 + v1*dt;
    c2 = c2 + v2*dt; 
%plot
    hold on
    colormap autumn
    xlim([min max]);
    ylim([min max]);
    zlim([min max]);
    xlabel('X');
    ylabel('Y');
    zlabel('Z');
    b1 = mesh(x1+c1(1),y1+c1(2),z1+c1(3));
    b2 = surf(x2+c2(1),y2+c2(2),z2+c2(3));
    plot3(c2(1),c2(2),c2(3),'.k')
    theta = linspace(1,2*pi,1000);
%define space line
    plot3((6.371*10^6+100*10^3)*sin(theta),(6.371*10^6+100*10^3)*cos(theta),zeros(1,1000),'k--')
%define ISS orbit line
    plot3((6.371*10^6+400*10^3)*sin(theta),(6.371*10^6+400*10^3)*cos(theta),zeros(1,1000),'r--')
    txtv2 = text(max-.5*max, max-.5*max, max-.5*max,sprintf('Velocity: %3.3f m/s', norm(v2)));
    txta2 = text(max-.6*max, max-.6*max, max-.6*max,sprintf('Acceleration: %3.3f m/s^2', norm(a1)));
    drawnow
    hold off
    delete(b1)
    delete(b2)
    delete(txtv2)
    delete(txta2)
end