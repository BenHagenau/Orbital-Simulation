%PURPOSE: This script will simulate the orbits of our outer solar system.
%Author: Benjamin Karl Hagenau
%Date Created: 12/24/2016
%Date Modified: 12/24/2016

function outerSolar(step,tNORMAL,aJUPITER,bJUPITER,cJUPITER,tJUPITER,...
    aSATURN,bSATURN,cSATURN,tSATURN,aURANUS,bURANUS,cURANUS,tURANUS,...
    aNEPTUNE,bNEPTUNE,cNEPTUNE,tNEPTUNE,aPLUTO,bPLUTO,cPLUTO,tPLUTO)

%Play interstellar
[y f]=audioread('Interstellar.mp3');
player = audioplayer(y,f);
play(player);

%Define iterative values
j = 1;
tSTART = cputime;

while j == 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%% INNER SOLAR SYSTEM %%%%%%%%%%%%%%%%%%%%%%%%%%%
    for i = 1:step
         plot3(aJUPITER(tJUPITER(i)),bJUPITER(tJUPITER(i)),cJUPITER(tJUPITER(i)),'co',aSATURN(tSATURN(i)),bSATURN(tSATURN(i)),cSATURN(tSATURN(i)),'go',aURANUS(tURANUS(i)),bURANUS(tURANUS(i)),cURANUS(tURANUS(i)),'bo',aNEPTUNE(tNEPTUNE(i)),bNEPTUNE(tNEPTUNE(i)),cNEPTUNE(tNEPTUNE(i)),'o',aPLUTO(tPLUTO(i)),bPLUTO(tPLUTO(i)),cPLUTO(tPLUTO(i)),'o',...
            aJUPITER(tNORMAL),bJUPITER(tNORMAL),cJUPITER(tNORMAL),'k',...
            aSATURN(tNORMAL),bSATURN(tNORMAL),cSATURN(tNORMAL),'k',...
            aURANUS(tNORMAL),bURANUS(tNORMAL),cURANUS(tNORMAL),'k',...
            aNEPTUNE(tNORMAL),bNEPTUNE(tNORMAL),cNEPTUNE(tNORMAL),'k',...
            aPLUTO(tNORMAL),bPLUTO(tNORMAL),cPLUTO(tNORMAL),'k',...
            0,0,0,'r*');
        title('Outer Solar System')
        legend('Jupiter','Saturn','Uranus', 'Neptune', 'Pluto', 'Location', 'Best')
        text(6000,-2000,-2500,sprintf('Time Elapsed: %3.3f', cputime-tSTART))
        drawnow
    end
end