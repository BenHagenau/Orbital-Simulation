%Author: Benjamin Hagenau
%Created: 2/24/17

%The purpose of this script is to simulate the interactions of the n-body
%problem with a variable number of bodies via numerical methods.

clear all
close all
clc

% define initial conditions
%number of bodies
n = 30;
%radius of bodies
r = 10; %[m]
%percent of domain volume available for body generation
percgen = .5;
%mass generation: random(1), uniform(2), or gigantua(3)
massgen = 2;
%define magnitude of initial velocities
v_mag = 100;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SYSTEM GENERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define gravitational constant
G = 6.67408 * 10^-11; %[m^3 kg^-1 s^-2]
%define a time step
dt = .1; %[seconds]

time = 0;
%mass of bodies (if constant mass)
m = zeros(1,100);
for i = 1:n
   if massgen == 1 %random
       ex = randi(17,13,1);                                     
       m(i) = 10^ex(5); %[kg]
   end
   if massgen == 2 %uniform
       m(i) = 10^15;
   end
   if massgen == 3 %gigantua
       if i ~= n
           m(i) = 10^14;
       else
           m(i) = 10^16;
       end
   end
   body = sprintf('b%d',i);
   MASS.(body) = m(i);
end

%define domain 
domain = [-1000 1000]; %[m]

%randomly generate each body with the give radius and place it in a
%location on the domain so that no spheres are overlapping
for i = 1:n 
    check = 0;
    move = 1;
    while check == 0
        primary = sprintf('b%d',i);
%define shift factor (within percgen% of domain)
        SHIFT.(primary).x = randi((domain*percgen) - r);
        SHIFT.(primary).y = randi((domain*percgen) - r);
        SHIFT.(primary).z = randi((domain*percgen) - r);
%define sphere values with shift
        [xp,yp,zp] = spheres(r);
        BODIES.(primary).x = xp + SHIFT.(primary).x;
        BODIES.(primary).y = yp + SHIFT.(primary).y;
        BODIES.(primary).z = zp + SHIFT.(primary).z;

%define distances between spheres (not for the sphere itself)
        for j = 1:i
            if j == i
                check = 1;
                break
            end
            secondary = sprintf('b%d',j);
            DIST.(primary).(secondary) = norm([SHIFT.(primary).x - SHIFT.(secondary).x,...
                SHIFT.(primary).y - SHIFT.(secondary).y, SHIFT.(primary).z - SHIFT.(secondary).z]);
%check for overlap
            if DIST.(primary).(secondary) > 2*r 
                check = 1;
            else
                check = 0;
                break
            end
        end
    end           
end

%replace shift structure with positions stucture
for i = 1:n
    primary = sprintf('b%d',i);
    POS.(primary) = [SHIFT.(primary).x, SHIFT.(primary).y, SHIFT.(primary).z];
end
clear SHIFT

%define initial velocities for each body (right now it is setting as zero)
for i = 1:n
    primary = sprintf('b%d',i);
    %define direction vector for velocity
    dir = cross(POS.(primary), [0 0 1]);
    VEL.(primary) = dir/norm(dir)*v_mag ;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%% SIMULATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% run = 1;
figure 
set(gcf,'Visible', 'on'); 
% while run == 1
for run = 1:200
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% DISTANCES %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    step = 1;
    for i = 1:n
        primary = sprintf('b%d',i);
        for j = 1:n
            if j ~= i
                secondary = sprintf('b%d',j);
                DIST.(primary).(secondary) = norm([POS.(primary)(1) - POS.(secondary)(1),...
                    POS.(primary)(2) - POS.(secondary)(2), POS.(primary)(3) - POS.(secondary)(3)]);
            end
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ACCELERATION %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%define unit vectors for each body going to all other bodies
    for i = 1:n
        primary = sprintf('b%d',i);
        for j = 1:n
            if j ~= i
                secondary = sprintf('b%d',j);
                UNIT.(primary).(secondary) = [POS.(secondary)(1) - POS.(primary)(1),...
                        POS.(secondary)(2) - POS.(primary)(2), POS.(secondary)(3)...
                        - POS.(primary)(3)]/DIST.(primary).(secondary);
            end
        end
    end

    %define gravitational acceleration vector summations for each body
    for i = 1:n
        primary = sprintf('b%d',i);
        ACC.(primary) = [0 0 0];
        for j = 1:n
            if j ~= i
            secondary = sprintf('b%d',j);
            ACC.(primary) = ACC.(primary) + (G*MASS.(secondary)/(DIST.(primary).(secondary))^2).*...
                UNIT.(primary).(secondary);
            end
        end
    end
    
%%%%%%%%%%%%%%%%%%%%%%%%%% VELOCITY & POSTITION %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:n
        primary = sprintf('b%d',i);
        VEL.(primary) = VEL.(primary) + ACC.(primary)*dt;
        POS.(primary) = POS.(primary) + VEL.(primary)*dt;
    end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PLOT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:n
        primary = sprintf('b%d',i);
        hold on
        colormap winter
        view(3)
        b(i) = mesh(BODIES.(primary).x + POS.(primary)(1),BODIES.(primary).y + POS.(primary)(2)...
            ,BODIES.(primary).z + POS.(primary)(3));

        xlim(domain);
        ylim(domain);
        zlim(domain);
    end
    drawnow
    frame(move) = getframe;
    for i = 1:n
        delete(b(i))
    end
    move = move + 1;
    time = time + dt;
    
    %output progress
    fprintf('Percent Completed: %.3f\n',(run/200)*100)
end
clc; close all;
%Play interstellar
[y f]=audioread('Interstellar.mp3');
player = audioplayer(y,f);
play(player);
disp('Complete!')

%watch replay
cont = 1;
while cont == 1
    input = menu('Watch n-Body Simulation','Watch','Exit');
    if input == 1
        movie(frame)
    elseif input == 2
        cont = 0;
    end
end




