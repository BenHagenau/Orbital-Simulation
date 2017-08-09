%PURPOSE: This script will simulate the orbits of our solar system.
%Author: Benjamin Karl Hagenau
%Date Created: 12/24/2016
%Date Modified: 12/24/2016

%Main Script
function allSolar(step,tNORMAL,aMERCURY,bMERCURY,cMERCURY,tMERCURY,...
    aVENUS,bVENUS,cVENUS,tVENUS,aEARTH,bEARTH,cEARTH,tEARTH,...
    aMARS,bMARS,cMARS,tMARS,aJUPITER,bJUPITER,cJUPITER,tJUPITER,...
    aSATURN,bSATURN,cSATURN,tSATURN,aURANUS,bURANUS,cURANUS,tURANUS,...
    aNEPTUNE,bNEPTUNE,cNEPTUNE,tNEPTUNE,aPLUTO,bPLUTO,cPLUTO,tPLUTO)

%Play interstellar
[y f]=audioread('Interstellar.mp3');
player = audioplayer(y,f);
play(player);


%NOTE: planetary order: mercury,venus,earth,mars,jupiter,saturn,uranus,neptune,pluto

%Define iterative values
j = 1;
tSTART = cputime;

while j == 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%% INNER SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:step
        subplot(1,3,1)
        plot3(aMERCURY(tMERCURY(i)),bMERCURY(tMERCURY(i)),cMERCURY(tMERCURY(i)),'co',aVENUS(tVENUS(i)),bVENUS(tVENUS(i)),cVENUS(tVENUS(i)),'go',aEARTH(tEARTH(i)),bEARTH(tEARTH(i)),cEARTH(tEARTH(i)),'bo',aMARS(tMARS(i)),bMARS(tMARS(i)),cMARS(tMARS(i)),'ro',...
            aMERCURY(tNORMAL),bMERCURY(tNORMAL),cMERCURY(tNORMAL),'r',...
            aVENUS(tNORMAL),bVENUS(tNORMAL),cVENUS(tNORMAL),'r',...
            aEARTH(tNORMAL),bEARTH(tNORMAL),cEARTH(tNORMAL),'r',...
            aMARS(tNORMAL),bMARS(tNORMAL),cMARS(tNORMAL),'r',...
            0,0,0,'r*');
        title('Inner Solar System')
        legend('Mercury','Venus', 'Earth', 'Mars', 'Location', 'Best')
        
%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTER SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        subplot(1,3,2)
         plot3(aJUPITER(tJUPITER(i)),bJUPITER(tJUPITER(i)),cJUPITER(tJUPITER(i)),'co',aSATURN(tSATURN(i)),bSATURN(tSATURN(i)),cSATURN(tSATURN(i)),'go',aURANUS(tURANUS(i)),bURANUS(tURANUS(i)),cURANUS(tURANUS(i)),'bo',aNEPTUNE(tNEPTUNE(i)),bNEPTUNE(tNEPTUNE(i)),cNEPTUNE(tNEPTUNE(i)),'o',aPLUTO(tPLUTO(i)),bPLUTO(tPLUTO(i)),cPLUTO(tPLUTO(i)),'o',...
            aJUPITER(tNORMAL),bJUPITER(tNORMAL),cJUPITER(tNORMAL),'k',...
            aSATURN(tNORMAL),bSATURN(tNORMAL),cSATURN(tNORMAL),'k',...
            aURANUS(tNORMAL),bURANUS(tNORMAL),cURANUS(tNORMAL),'k',...
            aNEPTUNE(tNORMAL),bNEPTUNE(tNORMAL),cNEPTUNE(tNORMAL),'k',...
            aPLUTO(tNORMAL),bPLUTO(tNORMAL),cPLUTO(tNORMAL),'k',...
            0,0,0,'r*');
        title('Outer Solar System')
        legend('Jupiter','Uranus', 'Neptune', 'Pluto', 'Location', 'Best')
        
%%%%%%%%%%%%%%%%%%%%%%%%%%%% FULL SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%%
        subplot(1,3,3)
        plot3(aMERCURY(tMERCURY(i)),bMERCURY(tMERCURY(i)),cMERCURY(tMERCURY(i)),'co',aVENUS(tVENUS(i)),bVENUS(tVENUS(i)),cVENUS(tVENUS(i)),'go',aEARTH(tEARTH(i)),bEARTH(tEARTH(i)),cEARTH(tEARTH(i)),'bo',aMARS(tMARS(i)),bMARS(tMARS(i)),cMARS(tMARS(i)),'ro',...
            aJUPITER(tJUPITER(i)),bJUPITER(tJUPITER(i)),cJUPITER(tJUPITER(i)),'co',aSATURN(tSATURN(i)),bSATURN(tSATURN(i)),cSATURN(tSATURN(i)),'go',aURANUS(tURANUS(i)),bURANUS(tURANUS(i)),cURANUS(tURANUS(i)),'bo',aNEPTUNE(tNEPTUNE(i)),bNEPTUNE(tNEPTUNE(i)),cNEPTUNE(tNEPTUNE(i)),'o',aPLUTO(tPLUTO(i)),bPLUTO(tPLUTO(i)),cPLUTO(tPLUTO(i)),'o',...
            aMERCURY(tNORMAL),bMERCURY(tNORMAL),cMERCURY(tNORMAL),'r',...
            aVENUS(tNORMAL),bVENUS(tNORMAL),cVENUS(tNORMAL),'r',...
            aEARTH(tNORMAL),bEARTH(tNORMAL),cEARTH(tNORMAL),'r',...
            aMARS(tNORMAL),bMARS(tNORMAL),cMARS(tNORMAL),'r',...
            aJUPITER(tNORMAL),bJUPITER(tNORMAL),cJUPITER(tNORMAL),'k',...
            aSATURN(tNORMAL),bSATURN(tNORMAL),cSATURN(tNORMAL),'k',...
            aURANUS(tNORMAL),bURANUS(tNORMAL),cURANUS(tNORMAL),'k',...
            aNEPTUNE(tNORMAL),bNEPTUNE(tNORMAL),cNEPTUNE(tNORMAL),'k',...
            aPLUTO(tNORMAL),bPLUTO(tNORMAL),cPLUTO(tNORMAL),'k',...
            0,0,0,'r*');
        text(-7000,-2000,-2500,sprintf('Time Elapsed: %3.3f', cputime-tSTART))
        title('Full Solar System')
        legend('Mercury','Venus', 'Earth', 'Mars','Jupiter','Saturn','Uranus', 'Neptune', 'Pluto', 'Location', 'Best')
        drawnow
    end
end


