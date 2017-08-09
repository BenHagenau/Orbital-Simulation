%PURPOSE: This script will simulate the orbits of our inner solar system.
%Author: Benjamin Karl Hagenau
%Date Created: 12/24/2016
%Date Modified: 12/24/2016

function innerSolar(step,tNORMAL,aMERCURY,bMERCURY,cMERCURY,tMERCURY,...
    aVENUS,bVENUS,cVENUS,tVENUS,aEARTH,bEARTH,cEARTH,tEARTH,...
    aMARS,bMARS,cMARS,tMARS)
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
        plot3(aMERCURY(tMERCURY(i)),bMERCURY(tMERCURY(i)),cMERCURY(tMERCURY(i)),'co',aVENUS(tVENUS(i)),bVENUS(tVENUS(i)),cVENUS(tVENUS(i)),'go',aEARTH(tEARTH(i)),bEARTH(tEARTH(i)),cEARTH(tEARTH(i)),'bo',aMARS(tMARS(i)),bMARS(tMARS(i)),cMARS(tMARS(i)),'ro',...
            aMERCURY(tNORMAL),bMERCURY(tNORMAL),cMERCURY(tNORMAL),'r',...
            aVENUS(tNORMAL),bVENUS(tNORMAL),cVENUS(tNORMAL),'r',...
            aEARTH(tNORMAL),bEARTH(tNORMAL),cEARTH(tNORMAL),'r',...
            aMARS(tNORMAL),bMARS(tNORMAL),cMARS(tNORMAL),'r',...
            0,0,0,'r*');
        title('Inner Solar System')
        legend('Mercury','Venus', 'Earth', 'Mars', 'Location', 'Best')
        text(50,-300,-6,sprintf('Time Elapsed: %3.3f', cputime-tSTART))
        drawnow
    end
end
