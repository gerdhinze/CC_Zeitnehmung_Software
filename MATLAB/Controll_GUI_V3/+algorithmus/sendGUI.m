function sendGUI(Stored)

RaceDataA = readtable("./Output_GUI/CarA.csv");
hA = height(RaceDataA);

RaceDataB = readtable("./Output_GUI/CarB.csv");
hB = height(RaceDataB);

%%%%%%%%%%%%%% Data for Car A %%%%%%%%%%%%%%%%%%%

for k = 1:hA
    if k == 1
        if exist('Output_GUI/firRndSplit1A.csv') == 0
            firRndSplit1A = RaceDataA(1,:);
            save('Output_GUI/firRndSplit1A.csv','firRndSplit1A')   
        end
    elseif k == 2
        if exist('Output_GUI/firRndSplit2A.csv') == 0
        firRndSplit2A = RaceDataA(2,:);
        save('Output_GUI/firRndSplit2A.csv','firRndSplit2A')
        end
    elseif k == 3
        if exist('Output_GUI/firRndA.csv') == 0
        firRndA = RaceDataA(3,:);
        save('Output_GUI/firRndA.csv','firRndA')
        end
    elseif k == 4
        if exist('Output_GUI/secRndSplit1A.csv') == 0
        secRndSplit1A = RaceDataA(4,:);
        save('Output_GUI/secRndSplit1A.csv','secRndSplit1A')
        end
    elseif k == 5
        if exist('Output_GUI/secRndSplit2A.csv') == 0
        secRndSplit2A = RaceDataA(5,:);
        save('Output_GUI/secRndSplit2A.csv','secRndSplit2A')
        end
    elseif k == 6
        if exist('Output_GUI/secRndA.csv') == 0
        secRndA = RaceDataA(6,:);
        save('Output_GUI/secRndA.csv','secRndA')
        end
    elseif k == 7
        if exist('Output_GUI/thiRndSplit1A.csv') == 0
        thiRndSplit1A = RaceDataA(7,:);
        save('Output_GUI/thiRndSplit1A.csv','thiRndSplit1A')
        end
    elseif k == 8
        if exist('Output_GUI/thiRndSplit2A.csv') == 0
        thiRndSplit2A = RaceDataA(8,:);
        save('Output_GUI/thiRndSplit2A.csv','thiRndSplit2A')
        end
    elseif k == 9
        if exist('Output_GUI/thiRndA.csv') == 0
        thiRndA = RaceDataA(9,:);
        save('Output_GUI/thiRndA.csv','thiRndA')
        end
    end
    
end


%%%%%%%%%%%%%% Data for Car B %%%%%%%%%%%%%%%%%%%
for k = 1:hB
    if k == 1
        if exist('Output_GUI/firRndSplit1B.mat') == 0
            firRndSplit1B = RaceDataB(1,:);
            save('Output_GUI/firRndSplit1B.mat','firRndSplit1B')   
        end
    elseif k == 2
        if exist('Output_GUI/firRndSplit2B.mat') == 0
        firRndSplit2B = RaceDataB(2,:);
        save('Output_GUI/firRndSplit2B.mat','firRndSplit2B')
        end
    elseif k == 3
        if exist('Output_GUI/firRndB.mat') == 0
        firRndB = RaceDataB(3,:);
        save('Output_GUI/firRndB.mat','firRndB')
        end
    elseif k == 4
        if exist('Output_GUI/secRndSplit1B.mat') == 0
        secRndSplit1B = RaceDataB(4,:);
        save('Output_GUI/secRndSplit1B.mat','secRndSplit1B')
        end
    elseif k == 5
        if exist('Output_GUI/secRndSplit2B.mat') == 0
        secRndSplit2B = RaceDataB(5,:);
        save('Output_GUI/secRndSplit2B.mat','secRndSplit2B')
        end
    elseif k == 6
        if exist('Output_GUI/secRndB.mat') == 0
        secRndB = RaceDataB(6,:);
        save('Output_GUI/secRndB.mat','secRndB')
        end
    elseif k == 7
        if exist('Output_GUI/thiRndSplit1B.mat') == 0
        thiRndSplit1B = RaceDataB(7,:);
        save('Output_GUI/thiRndSplit1B.mat','thiRndSplit1B')
        end
    elseif k == 8
        if exist('Output_GUI/thiRndSplit2B.mat') == 0
        thiRndSplit2B = RaceDataB(8,:);
        save('Output_GUI/thiRndSplit2B.mat','thiRndSplit2B')
        end
    elseif k == 9
        if exist('Output_GUI/thiRndB.mat') == 0
        thiRndB = RaceDataB(9,:);
        save('Output_GUI/thiRndB.mat','thiRndB')
        end
    end  
end