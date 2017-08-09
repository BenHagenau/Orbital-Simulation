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
rMAIN = 80;
[x1,y1,z1] = spheres(rMAIN);
m1 = 1*10^14; %[kg]
c1 = [0 0 0]; %[m]
v1 = [0 0 0]; %[m/s]

%define orbiting body
[x2,y2,z2] = spheres(3);
m2 = 1*10^8; %[kg]
c2 = [200 0 0]; %[m]
v2 = [0 5 4]; %[m/s]

%define lander
[x3,y3,z3] = spheres(3);
m3 = 1*10^0; %[kg]
rs = .5; %release speed [m/s]

startTIME = cputime;
on = 0;
dt = 1;
stage = 1;
landed = 1;

fprintf('Stage 1: Incertion\n')
%ORBIT TO LANDING
while stage == 1
    if cputime - startTIME <= 5
        c3 = c2;
        v3 = v2;
    end
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
    c2 = c2 + v2*dt; %send lander
    r13 = norm([c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]);
    u13 = [c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]/r13;
    a3 = (G*m1/r13^2)*u13;
    if cputime - startTIME > 17  %after # seconds of running
        v3 = (v3 + u13*rs) + a3*dt;
        c3 = c3 + v3*dt;
        on = 1;
    else 
        v3 = v2;
        c3 = c2;
    end  
%plot
    hold on
    colormap autumn
    xlim([min max]);
    ylim([min max]);
    zlim([min max]);
    b1 = mesh(x1+c1(1),y1+c1(2),z1+c1(3));
    b2 = surf(x2+c2(1),y2+c2(2),z2+c2(3));
    b3 = surf(x3+c3(1),y3+c3(2),z3+c3(3));
    plot3(c2(1),c2(2),c2(3),'.k')
    if on > 0 
        plot3(c3(1),c3(2),c3(3),'.r')  
    end
    drawnow
    hold off
%stop when lander hits
    if r13 <= rMAIN
        stage = 2;
        delete(b1)
        delete(b2)
        disp('The Eagle has landed')
        %save position of orbiter when landing occurs
        landpos = c2;
    else
        delete(b1)
        delete(b2)
        delete(b3)
    end
end

%ORBIT WHILE LANDED
fprintf('Stage 2: Orbit\n')
newTIME = cputime;
while stage == 2
    time = cputime - newTIME;
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
    c2 = c2 + v2*dt; %send lander
    %plot
    hold on
    colormap autumn
    xlim([min max]);
    ylim([min max]);
    zlim([min max]);
    b1 = mesh(x1+c1(1),y1+c1(2),z1+c1(3));
    b2 = surf(x2+c2(1),y2+c2(2),z2+c2(3));
    plot3(c2(1),c2(2),c2(3),'.k')

    drawnow
    hold off
    delete(b1)
    delete(b2)
    %start rendevu when the orbiter returns to the position it was when
    %lander landed
    if time > 20 %seconds after landing
        stage = 3;
    end
end

%ORBIT TO RENDEVU
%%%%%%% NOTES: Make thrust a function of distance to orbiter so that it
%%%%%%% slows down on approach
fprintf('Stage 3: Rendevu\n')
delete(b3)
v3 = [0 0 0];
%define distacne from lander to launcher at launch
dist1 = norm([c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]);
while stage == 3
     %define directions and distances between the two bodies
    r12 = norm([c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]);
    u21 = [c1(1) - c2(1),c1(2) - c2(2),c1(3) - c2(3)]/r12;
    u12 = ([c2(1) - c1(1),c2(2) - c1(2),c2(3) - c1(3)])/r12; 
    %define direction from planet to lander
    r13 = norm([c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]);
    u13 = [c1(1) - c3(1),c1(2) - c3(2),c1(3) - c3(3)]/r13;
    %define direction from orbiter to lander
    r23 = norm([c3(1) - c2(1),c3(2) - c2(2),c3(3) - c2(3)]);
    u23 = [c2(1) - c3(1),c2(2) - c3(2),c2(3) - c3(3)]/r23;
    %calculate acceleration as vectors
    a1 = (G*m1/r12^2)*u21;
    a2 = (G*m2/r12^2)*u12;
    a3 = (G*m1/r13^2)*u13;
    %Define lander acceleration due to thrust. (propraportional do
    %distnce to orbiter
    aT = u23*3;
%calculate velocity as vectors
    v1 = v1 + a2*dt;
    v2 = v2 + a1*dt;
    v3 = v3 + a3*dt + vT ;
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
    plot3(c2(1),c2(2),c2(3),'.k')
    plot3(c3(1),c3(2),c3(3),'.r') 

    drawnow
    hold off
    delete(b1)
    delete(b2)
    delete(b3)
end
    
    
    
    