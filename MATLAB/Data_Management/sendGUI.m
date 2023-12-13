function [Ready] = sendGUI(Stored)

RaceDataA = readtable("GUI_Data_A.csv");
hA = height(RaceDataA);

RaceDataB = readtable("GUI_Data_B.csv");
hB = height(RaceDataB);

%%%%%%%%%%%%%% Data for Car A %%%%%%%%%%%%%%%%%%%

for k = 1:hA
    if k == 1
        if exist('GUI Output/firRndSplit1A.mat') == 0
            firRndSplit1A = RaceDataA(1,:);
            save('GUI Output/firRndSplit1A.mat','firRndSplit1A')   
        end
    elseif k == 2
        if exist('GUI Output/firRndSplit2A.mat') == 0
        firRndSplit2A = RaceDataA(2,:);
        save('GUI Output/firRndSplit2A.mat','firRndSplit2A')
        end
    elseif k == 3
        if exist('GUI Output/firRndA.mat') == 0
        firRndA = RaceDataA(3,:);
        save('GUI Output/firRndA.mat','firRndA')
        end
    elseif k == 4
        if exist('GUI Output/secRndSplit1A.mat') == 0
        secRndSplit1A = RaceDataA(4,:);
        save('GUI Output/secRndSplit1A.mat','secRndSplit1A')
        end
    elseif k == 5
        if exist('GUI Output/secRndSplit2A.mat') == 0
        secRndSplit2A = RaceDataA(5,:);
        save('GUI Output/secRndSplit2A.mat','secRndSplit2A')
        end
    elseif k == 6
        if exist('GUI Output/secRndA.mat') == 0
        secRndA = RaceDataA(6,:);
        save('GUI Output/secRndA.mat','secRndA')
        end
    elseif k == 7
        if exist('GUI Output/thiRndSplit1A.mat') == 0
        thiRndSplit1A = RaceDataA(7,:);
        save('GUI Output/thiRndSplit1A.mat','thiRndSplit1A')
        end
    elseif k == 8
        if exist('GUI Output/thiRndSplit2A.mat') == 0
        thiRndSplit2A = RaceDataA(8,:);
        save('GUI Output/thiRndSplit2A.mat','thiRndSplit2A')
        end
    elseif k == 9
        if exist('GUI Output/thiRndA.mat') == 0
        thiRndA = RaceDataA(9,:);
        save('GUI Output/thiRndA.mat','thiRndA')
        end
    end
    
end


%%%%%%%%%%%%%% Data for Car B %%%%%%%%%%%%%%%%%%%
for k = 1:hB
    if k == 1
        if exist('GUI Output/firRndSplit1B.mat') == 0
            firRndSplit1B = RaceDataB(1,:);
            save('GUI Output/firRndSplit1B.mat','firRndSplit1B')   
        end
    elseif k == 2
        if exist('GUI Output/firRndSplit2B.mat') == 0
        firRndSplit2B = RaceDataB(2,:);
        save('GUI Output/firRndSplit2B.mat','firRndSplit2B')
        end
    elseif k == 3
        if exist('GUI Output/firRndB.mat') == 0
        firRndB = RaceDataB(3,:);
        save('GUI Output/firRndB.mat','firRndB')
        end
    elseif k == 4
        if exist('GUI Output/secRndSplit1B.mat') == 0
        secRndSplit1B = RaceDataB(4,:);
        save('GUI Output/secRndSplit1B.mat','secRndSplit1B')
        end
    elseif k == 5
        if exist('GUI Output/secRndSplit2B.mat') == 0
        secRndSplit2B = RaceDataB(5,:);
        save('GUI Output/secRndSplit2B.mat','secRndSplit2B')
        end
    elseif k == 6
        if exist('GUI Output/secRndB.mat') == 0
        secRndB = RaceDataB(6,:);
        save('GUI Output/secRndB.mat','secRndB')
        end
    elseif k == 7
        if exist('GUI Output/thiRndSplit1B.mat') == 0
        thiRndSplit1B = RaceDataB(7,:);
        save('GUI Output/thiRndSplit1B.mat','thiRndSplit1B')
        end
    elseif k == 8
        if exist('GUI Output/thiRndSplit2B.mat') == 0
        thiRndSplit2B = RaceDataB(8,:);
        save('GUI Output/thiRndSplit2B.mat','thiRndSplit2B')
        end
    elseif k == 9
        if exist('GUI Output/thiRndB.mat') == 0
        thiRndB = RaceDataB(9,:);
        save('GUI Output/thiRndB.mat','thiRndB')
        end
    end
    
end