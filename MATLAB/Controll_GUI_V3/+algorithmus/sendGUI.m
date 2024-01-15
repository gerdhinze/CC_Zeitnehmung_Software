function sendGUI(Stored)


%%%%%%%%%%%%%% Data for Car DO %%%%%%%%%%%%%%%%%%%

if exist('./Output_GUI/GUI_Data_A.csv') == 2
    RaceDataA = readtable("./Output_GUI/GUI_Data_A.csv"); %./Output_GUI/CarA.csv
    hA = height(RaceDataA);

    columnIndex = 3; % Replace with the actual column index
  
    % Convert the selected column to numeric values
    RaceDataA.(RaceDataA.Properties.VariableNames{columnIndex}) = str2double(RaceDataA.(RaceDataA.Properties.VariableNames{columnIndex}));

    % Apply the convert function to the time table
    RaceDataA.Timestamp = arrayfun(@algorithmus.convertFormat, RaceDataA.(columnIndex), 'UniformOutput', false);

    for k = 1:hA
        if k == 1
            if exist('Output_GUI/rndOneSp1DO.mat') == 0
                rndOneSp1DO = RaceDataA(1,:);
                save('Output_GUI/rndOneSp1DO.mat','rndOneSp1DO')   
            end
        elseif k == 2
            if exist('Output_GUI/rndOneSp2DO.mat') == 0
                rndOneSp2DO = RaceDataA(2,:);
                save('Output_GUI/rndOneSp2DO.mat','rndOneSp2DO')
            end
        elseif k == 3
            if exist('Output_GUI/rndOneDO.mat') == 0
                rndOneDO = RaceDataA(3,:);
                save('Output_GUI/rndOneDO.mat','rndOneDO')
            end
        elseif k == 4
            if exist('Output_GUI/rndTwoSp1DO.mat') == 0
                rndTwoSp1DO = RaceDataA(4,:);
                save('Output_GUI/rndTwoSp1DO.mat','rndTwoSp1DO')
            end
        elseif k == 5
            if exist('Output_GUI/rndTwoSp2DO.mat') == 0
                rndTwoSp2DO = RaceDataA(5,:);
                save('Output_GUI/rndTwoSp2DO.mat','rndTwoSp2DO')
            end
        elseif k == 6
            if exist('Output_GUI/rndTwoDO.mat') == 0
                rndTwoDO = RaceDataA(6,:);
                save('Output_GUI/rndTwoDO.mat','rndTwoDO')
            end
        elseif k == 7
            if exist('Output_GUI/rndThreeSp1DO.mat') == 0
                rndThreeSp1DO = RaceDataA(7,:);
                save('Output_GUI/rndThreeSp1DO.mat','rndThreeSp1DO')
            end
        elseif k == 8
            if exist('Output_GUI/rndThreeSp2DO.mat') == 0
                rndThreeSp2DO = RaceDataA(8,:);
                save('Output_GUI/rndThreeSp2DO.mat','rndThreeSp2DO')
            end
        elseif k == 9
            if exist('Output_GUI/rndThreeDO.mat') == 0
                rndThreeDO = RaceDataA(9,:);
                save('Output_GUI/rndThreeDO.mat','rndThreeDO')
            end
        end
    
    end
end

%%%%%%%%%%%%%% Data for Car DT %%%%%%%%%%%%%%%%%%%

if exist('./Output_GUI/GUI_Data_B.csv') == 2
    RaceDataB = readtable("./Output_GUI/GUI_Data_B.csv");
    hB = height(RaceDataB);

    columnIndex = 3; % Replace with the actual column index
  
    % Convert the selected column to numeric values
    RaceDataB.(RaceDataB.Properties.VariableNames{columnIndex}) = str2double(RaceDataB.(RaceDataB.Properties.VariableNames{columnIndex}));

    % Apply the convert function to the time table
    RaceDataB.Timestamp = arrayfun(@algorithmus.convertFormat, RaceDataB.(columnIndex), 'UniformOutput', false);

    
    for k = 1:hB
        if k == 1
            if exist('Output_GUI/rndOneSp1DT.mat') == 0
                rndOneSp1DT = RaceDataB(1,:);
                save('Output_GUI/rndOneSp1DT.mat','rndOneSp1DT')   
            end
        elseif k == 2
            if exist('Output_GUI/rndOneSp2DT.mat') == 0
                rndOneSp2DT = RaceDataB(2,:);
                save('Output_GUI/rndOneSp2DT.mat','rndOneSp2DT')
            end
        elseif k == 3
            if exist('Output_GUI/rndOneDT.mat') == 0
                rndOneDT = RaceDataB(3,:);
                save('Output_GUI/rndOneDT.mat','rndOneDT')
            end
        elseif k == 4
            if exist('Output_GUI/rndTwoSp1DT.mat') == 0
                rndTwoSp1DT = RaceDataB(4,:);
                save('Output_GUI/rndTwoSp1DT.mat','rndTwoSp1DT')
            end
        elseif k == 5
            if exist('Output_GUI/rndTwoSp2DT.mat') == 0
                rndTwoSp2DT = RaceDataB(5,:);
                save('Output_GUI/rndTwoSp2DT.mat','rndTwoSp2DT')
            end
        elseif k == 6
            if exist('Output_GUI/rndTwoDT.mat') == 0
                rndTwoDT = RaceDataB(6,:);
                save('Output_GUI/rndTwoDT.mat','rndTwoDT')
            end
        elseif k == 7
            if exist('Output_GUI/rndThreeSp1DT.mat') == 0
                rndThreeSp1DT = RaceDataB(7,:);
                save('Output_GUI/rndThreeSp1DT.mat','rndThreeSp1DT')
            end
        elseif k == 8
            if exist('Output_GUI/rndThreeSp2DT.mat') == 0
                rndThreeSp2DT = RaceDataB(8,:);
                save('Output_GUI/rndThreeSp2DT.mat','rndThreeSp2DT')
            end
        elseif k == 9
            if exist('Output_GUI/rndThreeDT.mat') == 0
                rndThreeDT = RaceDataB(9,:);
                save('Output_GUI/rndThreeDT.mat','rndThreeDT')
            end
        end
    end    
end