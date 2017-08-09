%Author: Benjamin Hagenau
%Created: 1/16/2017

%This script simulates the gravitational interactions between two celestial
%bodies (The 2-body problem).

clear all
clc

%define constants
G = 6.67408 * 10^-11; %[m^3 kg^-1 s^-2]
m1 = 1*10^11; %[kg]
m2 = 1*10^10; %[kg]

%define body 1 and 2(automatically centered at origin)
[x1,y1,z1] = sphere(100);
[x2,y2,z2] = sphere(100);

%%%%%%%%%%%%%%%%%%%%%%%%% DEFINE INTIAL CONTITIONS %%%%%%%%%%%%%%%%%%%%%%%%
%define initial position for each body as a vector 
pos1 = [-180 -180 -180];
pos2 = [-190 -190 -190];
%define initial velocities
vel1 = [ 1 1 1 ];
vel2 = [ 0 2 0 ];
%define time interval
dt = 1;
%set axis range
max = 200;
min = -200;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
b1 = surf(x1,y1,z1);
b2 = mesh(x2,y2,z2);
check = 1;
count = 0;
timeSTART = cputime;
figure('Visible','on')
while check == 1
    delete(b1)
    delete(b2)
    timeCURRENT = cputime - timeSTART;
    fprintf('Run time: %3.3f\n',timeCURRENT);
    count = count + 1;
%define distance between the two bodies
    r = [abs(pos1(1)-pos2(1)),abs(pos1(2)-pos2(2)),abs(pos1(3)-pos2(3))];
%define acceleration acting on each body as a vector
    acc1mag = (G*m2)/sqrt(r(1)^2 + r(2)^2 + r(3)^2);
    acc2mag = (G*m1)/sqrt(r(1)^2 + r(2)^2 + r(3)^2);
    acc1dir = [pos2(1)-pos1(1),pos2(2)-pos1(2),pos2(3)-pos1(3)]/norm([pos2(1)-pos1(1),pos2(2)-pos1(2),pos2(3)-pos1(3)]);
    acc2dir = [pos1(1)-pos2(1),pos1(2)-pos2(2),pos1(3)-pos2(3)]/norm([pos1(1)-pos2(1),pos1(2)-pos2(2),pos1(3)-pos2(3)]);
    acc1 = acc1mag*acc1dir;
    acc2 = acc2mag*acc2dir;
    
%define new velocity and new postion
    for i = 1:3
        vel1(i) = vel1(i) + acc1(i)*dt;
        vel2(i) = vel2(i) + acc2(i)*dt;
        pos1(i) = pos1(i) + vel1(i)*dt;
        pos2(i) = pos2(i) + vel2(i)*dt;
    end
%define velocity magnitudes for each body
    vel1mag = norm(vel1);
    vel2mag = norm(vel2);
    
%plot system
    hold on
    b1 = surf(x1+pos1(1),y1+pos1(2),z1+pos1(3));
    b2 = mesh(x2+pos2(1),y2+pos2(2),z2+pos2(3));
%plot trail
    plot3(pos1(1),pos1(2),pos1(3),'.k')
    plot3(pos2(1),pos2(2),pos2(3),'.r')
    colormap jet
    hold off
%set axis range
    xlim([min max])
    ylim([min max])
    zlim([min max])

    drawnow
%   F(count) = getframe;

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
    end
%stop if bodies collide
    if norm([pos1-pos2]) < 5
        check = 2;
    end
    clc
end

%Play the figures that were saved in real time
close Figure 1
% movie(F)