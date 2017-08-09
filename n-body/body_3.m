%Author: Benjamin Hagenau
%Created: 1/21/2017

%This script simulates the gravitational interactions between two celestial
%bodies (The 3-body problem).

clear all
close all
clc

%define constants
G = 6.67408 * 10^-11; %[m^3 kg^-1 s^-2]
m1 = 3*10^10; %[kg]
m2 = 1*10^8; %[kg]
m3 = 1*10^8; %[kg]

%define body 1 and 2(automatically centered at origin)
[x1,y1,z1] = sphere(100);
[x2,y2,z2] = sphere(100);
[x3,y3,z3] = sphere(100);

%%%%%%%%%%%%%%%%%%%%%%%%% DEFINE INTIAL CONTITIONS %%%%%%%%%%%%%%%%%%%%%%%%
%define initial position for each body as a vector 
pos1 = [0 0 0];
pos2 = [10 10 10];
pos3 = [20 20 20];
%define initial velocities
vel1 = [ 0 0 0 ];
vel2 = [ 1 0 0 ];
vel3 = [ 0 0 1 ];
%define time interval
dt = 1;
%set axis range
max = 100;
min = -100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b1 = surf(x1,y1,z1);
b2 = mesh(x2,y2,z2);
b3 = surf(x3,y3,z3);
check = 1;
count = 0;
timeSTART = cputime;
while check == 1
    delete(b1)
    delete(b2)
    delete(b3)
    timeCURRENT = cputime - timeSTART;
    fprintf('Run time: %3.3f\n',timeCURRENT);
    count = count + 1;
%define distance between bodies
    r12 = [abs(pos1(1)-pos2(1)),abs(pos1(2)-pos2(2)),abs(pos1(3)-pos2(3))];
    r13 = [abs(pos1(1)-pos3(1)),abs(pos1(2)-pos3(2)),abs(pos1(3)-pos3(3))];
    r23 = [abs(pos3(1)-pos2(1)),abs(pos3(2)-pos2(2)),abs(pos3(3)-pos2(3))];
%define directions of each force on bodies
    u12 = [pos2(1)-pos1(1),pos2(2)-pos1(2),pos2(3)-pos1(3)]/norm(r12);
    u21 = [pos1(1)-pos2(1),pos1(2)-pos2(2),pos1(3)-pos2(3)]/norm(r12);
    u13 = [pos3(1)-pos1(1),pos3(2)-pos1(2),pos3(3)-pos1(3)]/norm(r12);
    u31 = [pos1(1)-pos3(1),pos1(2)-pos3(2),pos1(3)-pos3(3)]/norm(r13);
    u23 = [pos3(1)-pos2(1),pos3(2)-pos2(2),pos3(3)-pos2(3)]/norm(r23);
    u32 = [pos2(1)-pos3(1),pos2(2)-pos3(2),pos2(3)-pos3(3)]/norm(r23);
%define magnitude of force summations for each body
    f12 = G*m1*m2./r12;
    f13 = G*m1*m3./r13;
    f23 = G*m2*m3./r23;
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
%define acceleration for each object
    acc1 = F1/m1;
    acc2 = F2/m2;
    acc3 = F3/m3;
%define new velocity and new postion
    for i = 1:3
        vel1(i) = vel1(i) + acc1(i)*dt;
        vel2(i) = vel2(i) + acc2(i)*dt;
        vel3(i) = vel3(i) + acc3(i)*dt;
        pos1(i) = pos1(i) + vel1(i)*dt;
        pos2(i) = pos2(i) + vel2(i)*dt;
        pos3(i) = pos3(i) + vel3(i)*dt;
    end
    
%plot system
    hold on
    b1 = surf(x1+pos1(1),y1+pos1(2),z1+pos1(3));
    b2 = mesh(x2+pos2(1),y2+pos2(2),z2+pos2(3));
    b3 = mesh(x3+pos3(1),y3+pos3(2),z3+pos3(3));
%plot trail
    plot3(pos1(1),pos1(2),pos1(3),'.k')
    plot3(pos2(1),pos2(2),pos2(3),'.r')
    plot3(pos3(1),pos3(2),pos3(3),'.b')
    colormap jet
    hold off
%set axis range
    xlim([min max])
    ylim([min max])
    zlim([min max])

    drawnow

%check if bodies go out of plot size
    if pos1(1) > max || pos1(1) < min
        check = 2;
    elseif pos1(2) > max || pos1(2) < min
        check = 2;
    elseif pos1(3) > max || pos1(3) < min
        check = 2;
    elseif pos2(1) > max || pos2(1) < min
        check = 2;
    elseif pos2(2) > max || pos2(2) < min
        check = 2;
    elseif pos2(3) > max || pos2(3) < min
        check = 2;
    elseif pos3(1) > max || pos3(1) < min
        check = 2;
    elseif pos3(2) > max || pos3(2) < min
        check = 2;
    elseif pos3(3) > max || pos3(3) < min
        check = 2;
    end
%stop if bodies collide
    if norm([pos1-pos2]) < 2
        check = 2;
    elseif norm([pos1 - pos2]) < 2
        check = 2;
    elseif norm([pos2 - pos3]) < 2
        check = 2;
    end
    clc
end
