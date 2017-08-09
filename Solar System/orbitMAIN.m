%PURPOSE: This script will simulate the orbits of our solar system.
%Author: Benjamin Karl Hagenau
%Date Created: 12/24/2016
%Date Modified: 12/28/2016

%Main Script

%House Keeping
clear all
close all
clc

%Welcome the user
fprintf('Welcome to a simulation of our Solar System! This program allows you to observe the graviational phenomenon of the\ninner solar and outer solar systems!\n')

%NOTE: planetary order: mercury,venus,earth,mars,jupiter,saturn,uranus,neptune,pluto

%Define angles of inclination [radians]
inclination = [0.1223476,0.059166662,0,0.0322885912,0.02286381,0.043458698,0.013439035,0.030892328,0.296706];

%Define aphelions and perihelions
aphelion = [70,108.21,152.1,249.2,817,1500,3000,4547.8,7375.2];
perihelion = [46,107.48,147.1,206.7,741,1400,2750,4458,4443.1];

%Define max heights of orbits from ecliptic plane
height = zeros(1,9);
for w = 1:9
    height(w) = aphelion(w) * sin(inclination(w));
end

%Define eccentricities of ellipses [apehelion and perihelion in millions of [km]
aMERCURY = @(t) aphelion(1)*cos(t);
bMERCURY = @(t) 20 + perihelion(1)*sin(t);
cMERCURY = @(t) height(1)*sin(t);
aVENUS = @(t) aphelion(2)*cos(t);
bVENUS = @(t) perihelion(2)*sin(t);
cVENUS = @(t) height(2)*sin(t);
aEARTH = @(t) aphelion(3)*cos(t);
bEARTH = @(t) perihelion(3)*sin(t);
cEARTH = @(t) height(3)*sin(t);
aMARS = @(t) aphelion(4)*cos(t);
bMARS = @(t) perihelion(4)*sin(t);
cMARS = @(t) height(4)*sin(t);
aJUPITER = @(t) aphelion(5)*cos(t);
bJUPITER = @(t) perihelion(5)*sin(t);
cJUPITER = @(t) height(5)*sin(t);
aSATURN = @(t) aphelion(6)*cos(t);
bSATURN = @(t) perihelion(6)*sin(t);
cSATURN = @(t) height(6)*sin(t);
aURANUS = @(t) aphelion(7)*cos(t);
bURANUS = @(t) perihelion(7)*sin(t);
cURANUS = @(t) height(7)*sin(t);
aNEPTUNE = @(t) aphelion(8)*cos(t);
bNEPTUNE = @(t) perihelion(8)*sin(t);
cNEPTUNE = @(t) height(8)*sin(t);
aPLUTO = @(t) aphelion(9)*cos(t);
bPLUTO = @(t) 1000 + perihelion(9)*sin(t);
cPLUTO = @(t) height(9)*sin(t);

%Define normalized velocity factor (relative to earth)
v = [1.607,1.174,1.0,0.802,0.434,0.323,0.228,0.182,0.159];

%Define step size
step = 10000;

%Define time domains
tNORMAL = linspace(0,200*pi,step);
tMERCURY = linspace(0,200*v(1)*pi,step);
tVENUS = linspace(0,200*v(2)*pi,step);
tEARTH = linspace(0,200*v(3)*pi,step);
tMARS = linspace(0,200*v(4)*pi,step);
tJUPITER = linspace(0,600*v(5)*pi,step);
tSATURN = linspace(0,600*v(6)*pi,step);
tURANUS = linspace(0,600*v(7)*pi,step);
tNEPTUNE = linspace(0,600*v(8)*pi,step);
tPLUTO = linspace(0,600*v(9)*pi,step);

%Display Menu

choice = menu('Choose a simulation!','Inner Solar System', 'Outer Solar System', 'Full Solar System', 'All Systems');
switch choice
    case 1
        %%%%%%%%%%%%%%%%%%%%%%%%%%%% INNER SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%
        innerSolar(step,tNORMAL,aMERCURY,bMERCURY,cMERCURY,tMERCURY,...
            aVENUS,bVENUS,cVENUS,tVENUS,aEARTH,bEARTH,cEARTH,tEARTH,...
            aMARS,bMARS,cMARS,tMARS);
    case 2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTER SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%
        outerSolar(step,tNORMAL,aJUPITER,bJUPITER,cJUPITER,tJUPITER,...
            aSATURN,bSATURN,cSATURN,tSATURN,aURANUS,bURANUS,cURANUS,tURANUS,...
            aNEPTUNE,bNEPTUNE,cNEPTUNE,tNEPTUNE,aPLUTO,bPLUTO,cPLUTO,tPLUTO);
    case 3
        %%%%%%%%%%%%%%%%%%%%%%%%%%%% FULL SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        step = 1000;
        tNORMAL = linspace(0,100*pi,step);
        tMERCURY = linspace(0,100*v(1)*pi,step);
        tVENUS = linspace(0,100*v(2)*pi,step);
        tEARTH = linspace(0,100*v(3)*pi,step);
        tMARS = linspace(0,100*v(4)*pi,step);
        tJUPITER = linspace(0,100*v(5)*pi,step);
        tSATURN = linspace(0,100*v(6)*pi,step);
        tURANUS = linspace(0,100*v(7)*pi,step);
        tNEPTUNE = linspace(0,100*v(8)*pi,step);
        tPLUTO = linspace(0,100*v(9)*pi,step);

        fullSolar(step,tNORMAL,aMERCURY,bMERCURY,cMERCURY,tMERCURY,...
            aVENUS,bVENUS,cVENUS,tVENUS,aEARTH,bEARTH,cEARTH,tEARTH,...
            aMARS,bMARS,cMARS,tMARS,aJUPITER,bJUPITER,cJUPITER,tJUPITER,...
            aSATURN,bSATURN,cSATURN,tSATURN,aURANUS,bURANUS,cURANUS,tURANUS,...
            aNEPTUNE,bNEPTUNE,cNEPTUNE,tNEPTUNE,aPLUTO,bPLUTO,cPLUTO,tPLUTO);
    case 4
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%% ALL SYSTEMS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        step = 1000;
        tNORMAL = linspace(0,100*pi,step);
        tMERCURY = linspace(0,100*v(1)*pi,step);
        tVENUS = linspace(0,100*v(2)*pi,step);
        tEARTH = linspace(0,100*v(3)*pi,step);
        tMARS = linspace(0,100*v(4)*pi,step);
        tJUPITER = linspace(0,100*v(5)*pi,step);
        tSATURN = linspace(0,100*v(6)*pi,step);
        tURANUS = linspace(0,100*v(7)*pi,step);
        tNEPTUNE = linspace(0,100*v(8)*pi,step);
        tPLUTO = linspace(0,100*v(9)*pi,step);

        allSolar(step,tNORMAL,aMERCURY,bMERCURY,cMERCURY,tMERCURY,...
            aVENUS,bVENUS,cVENUS,tVENUS,aEARTH,bEARTH,cEARTH,tEARTH,...
            aMARS,bMARS,cMARS,tMARS,aJUPITER,bJUPITER,cJUPITER,tJUPITER,...
            aSATURN,bSATURN,cSATURN,tSATURN,aURANUS,bURANUS,cURANUS,tURANUS,...
            aNEPTUNE,bNEPTUNE,cNEPTUNE,tNEPTUNE,aPLUTO,bPLUTO,cPLUTO,tPLUTO);
end