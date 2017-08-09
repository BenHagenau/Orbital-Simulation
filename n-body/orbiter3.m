%Author: Benjamin Hagenau
%Created: 1/23/17

%This program simulates landing on a celestial body

%Main
close all
clear all
clc

%define constans
G = 6.67408 * 10^-11; %[m^3 kg^-1 s^-2]

%define plot size
min = -320; %[m]
max = 320; %[m]

%define main body
[x1,y1,z1] = spheres(100);
m1 = 1*10^13; %[kg]
c1 = [0 0 0]; %[m]
v1 = [0 0 0]; %[m/s]

%define secondary body
[x2,y2,z2] = spheres(3);
m2 = 1*10^11; %[kg]
c2 = [260 0 0]; %[m]
v2 = [0 20 20]; %[m/s]

%define secondary body's satellite
[x3,y3,z3] = spheres(1);
m3 = 1*10^3; %[kg]
c3 = [250 10 0]; %[m]
v3 = [3 20 20]; %[m/s]

figure
dt = .1;
check = 1;
while check == 1
    c20 = c1;
    c30 = c2;
%define directions and distances between the two bodies
    r12 = norm([c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]);
    u12 = ([c2(1) - c1(1),c2(2) - c1(2),c2(3) - c1(3)])/r12;
    u21 = [c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]/r12;
    
    r13 = norm([c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]);
    u13 = [c3(1) - c1(1),c3(2) - c1(2),c3(3) - c1(3)]/r13;
    u31 = [c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]/r13;
    
    r23 = norm([c2(1) - c3(1),c2(2) - c3(2),c2(3) - c3(3)]);
    u23 = [c3(1) - c2(1),c3(2) - c2(2),c3(3) - c2(3)]/r23;
    u32 = [c2(1) - c3(1),c2(2) - c3(2),c2(3) - c3(3)]/r23;
    
%define magnitude of force summations for each body
    f12 = G*m1*m2./r12^2;
    f13 = G*m1*m3./r13^2;
    f23 = G*m2*m3./r23^2;
%define force vectors
    F12 = f12.*u12;
    F21 = f12.*u21;
    F13 = f13.*u13;
    F31 = f13.*u31;
    F23 = f23.*u23;
    F32 = f23.*u32;
%sum forces for each object
    F1 = F12 + F13;
    F2 = F21 + F23;
    F3 = F32 + F31;
%define acceleration as vectors
    a1 = F1/m1;
    a2 = F2/m2;
    a3 = F3/m3;
%calculate velocity as vectors
    v1 = v1 + a1*dt;
    v2 = v2 + a2*dt;
    v3 = v3 + a3*dt;
%calculate position
    c1 = c1 + v1*dt;
    c2 = c2 + v2*dt;
    c3 = c3 + v3*dt;
%plot
    hold on
    colormap autumn
    xlim([min max]);
    ylim([min max]);
    zlim([min max]);
    b1 = mesh(x1+c1(1),y1+c1(2),z1+c1(3));
    b2 = surf(x2+c2(1),y2+c2(2),z2+c2(3));
    b3 = surf(x3+c3(1),y3+c3(2),z3+c3(3));
    plot3(c2(1),c2(2),c2(3),'.r')
    plot3(c3(1),c3(2),c3(3),'.b')

    
    fprintf('Velocity Planet: %3.3f m/s\n', norm(v2))
    fprintf('Acceleration Planet: %3.3f m/s^2\n', norm(a2));
    drawnow
    delete(b1)
    delete(b2)
    delete(b3)
    hold off
    clc
end








