%----------------------------------------------------
% Simulate planetary transfer from Earth to Mars using patched conics. 
%----------------------------------------------------
% Benjamin Karl Hagenau
%----------------------------------------------------
% Created: 6/1/17
% Edited: 6/1/17
%----------------------------------------------------

% Units: kg, m, s, rad

% Masses: 
    % Mass of Earth: 5.972 × 10^24 [kg]
    % Mass of Mars:  6.39 × 10^23  [kg]
    % Mass of Sun:   1.989 × 10^30 [kg]
% Distances: 
    % Radius of Earth: 6,371     [km]
    % Radius of Mars:  3,390     [km]
    % Radius of Sun:   695,700   [km]
    % Sun to Earth:    149600000 [km]
    % Sun to Mars:     227900000 [km]
    
% Coordinate system
    % Z: orthogonal to Earth's orbital plane
    % X: towards Earth's perihelion

    
%% --------------------------- House Keeping ---------------------------
close all; clear all; clc;
addpath /Users/Benjamin/Documents/MATLAB/functions

% Allocation
Earth.toSun = zeros(3); 
Mars.toSun = zeros(3);

%% -------------------------- Define Constants -------------------------
% size magnification factor
earthmag = 10^2.4;
marsmag = 10^2.6;
sunmag = 10^1.5;

% General
G = 6.67408*10^(-11);

% Sun
Sun.m = 1.989*10^30;
Sun.r = 695700*10^3 * sunmag;
Sun.u = Sun.m*G;
% Earth
Earth.m = 5.982*10^24;          % mass
Earth.r = 6371*10^3 * earthmag; % radius
Earth.u = Earth.m*G;            % gravitational parameter
Earth.a = 1.496*10^11;          % semi major axis
Earth.E = -(Sun.u/(2*Earth.a)); % Specific Mechanical Energy
% Mars
Mars.m = 6.39*10^23;
Mars.r = 3390*10^3 * marsmag;
Mars.u = Mars.m*G;
Mars.a = 2.27389*10^11;
Mars.E = -(Sun.u/(2*Mars.a));
Mars.i = 1.85*pi/180;           % Orbital inclination

%% ---------------------- Generate Celestial Bodies -----------------------
% Define posing locations
Earth.pos = [Earth.a, 0, 0];
Mars.pos = [-Mars.a*cos(Mars.i), 0, -Mars.a*sin(Mars.i)];
Sun.pos = [0, 0, 0];
% Define spheres at posing locations
[Earth.x,Earth.y,Earth.z] = generate(Earth.pos(1),...
    Earth.pos(2),...
    Earth.pos(3),Earth.r);
[Mars.x,Mars.y,Mars.z] = generate(Mars.pos(1),...
    Mars.pos(2),...
    Mars.pos(3),Mars.r);
[Sun.x,Sun.y,Sun.z] = generate(Sun.pos(1),...
    Sun.pos(2),...
    Sun.pos(3),Sun.r);

%% ----------------- Define Initial State of Planets -----------------
% Distances from sun
Earth.toSun(1,:) = Earth.pos - Sun.pos;                   % vector from sun to planet
Earth.toSun(2,1) = norm(Earth.toSun(1,:));                % magnitude
Earth.toSun(3,:) = Earth.toSun(1,:)/Earth.toSun(2,1);     % direction 

Mars.toSun(1,:) = Mars.pos - Sun.pos;           
Mars.toSun(2,1) = norm(Mars.toSun(1,:));         
Mars.toSun(3,:) = Mars.toSun(1,:)/Mars.toSun(2,1);

% Velocity
Earth.v = sqrt(2*(Earth.E + Earth.u/Earth.toSun(2)));
Mars.v = sqrt(2*(Mars.E + Mars.u/Mars.toSun(2)));

% Acceleration




figure
lim = [-Mars.a - 6*Mars.r Mars.a + 6*Mars.r];
hold on
mesh(Earth.x,Earth.y,Earth.z)
mesh(Mars.x,Mars.y,Mars.z)
mesh(Sun.x,Sun.y,Sun.z)
xlim(lim)
ylim(lim)
zlim(lim)
hold off









