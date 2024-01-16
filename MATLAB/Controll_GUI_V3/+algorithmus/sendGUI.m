function sendGUI(Stored)

%%%%%%%%%%%%%% Data for Car DO %%%%%%%%%%%%%%%%%%%

if exist('./Output_GUI/GUI_Data_A.csv') == 2
    % Generated Data for the GUI
    RaceDataA = readtable("./Output_GUI/GUI_Data_A.csv"); %./Output_GUI/CarA.csv
    hA = height(RaceDataA);

    columnIndex = 3; % Column index of Timestamp
  
    % Convert the column of the Timestamp to numeric values
    RaceDataA.(RaceDataA.Properties.VariableNames{columnIndex}) = str2double(RaceDataA.(RaceDataA.Properties.VariableNames{columnIndex}));

    % Checks if the Race file exist
    if exist("Race") == 2

        Race = readtable("./Output_Files/data_race.csv");

        % Convert the column of the Timestamp to numeric values
        Race.(Race.Properties.VariableNames{3}) = str2double(Race.(Race.Properties.VariableNames{3}));

        % Select the Race Start time
        startTimeRace = Race{1,3};  

        % Subtracts the start time from the race times
        RaceDataA.Timestamp = RaceDataA.Timestamp - startTimeRace;

    % Checks if the Log file exist
    elseif exist("Log_data") == 2
    
        Log_data = readtable("./Output_Files/data_log_2_sort.csv");

        % Convert the column of the Timestamp to numeric values
        Log_data.(Log_data.Properties.VariableNames{3}) = str2double(Log_data.(Log_data.Properties.VariableNames{3}));

        % Select the Race Start time
        startTimeLog = Log_data{1,3};  

        % Subtracts the start time from the race times
        RaceDataA.Timestamp = RaceDataA.Timestamp - startTimeLog;
    end

    % Apply the convert function to the Timestamp column
    RaceDataA.Timestamp = arrayfun(@algorithmus.convertFormat, RaceDataA.(columnIndex), 'UniformOutput', false);

    % Generation of the mat files for the GUI
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
    % Generated Data for the GUI
    RaceDataB = readtable("./Output_GUI/GUI_Data_B.csv");
    hB = height(RaceDataB);

    columnIndex = 3; % Column index of Timestamp
  
    % Convert the column of the Timestamp to numeric values
    RaceDataB.(RaceDataB.Properties.VariableNames{columnIndex}) = str2double(RaceDataB.(RaceDataB.Properties.VariableNames{columnIndex}));

    % Checks if the Race file exist
    if exist("Race") == 2

        Race = readtable("./Output_Files/data_race.csv");

        % Convert the column of the Timestamp to numeric values
        Race.(Race.Properties.VariableNames{3}) = str2double(Race.(Race.Properties.VariableNames{3}));

        % Select the Race Start time
        startTimeRace = Race{1,3};  

        % Subtracts the start time from the race times
        RaceDataB.Timestamp = RaceDataB.Timestamp - startTimeRace;
    
    % Checks if the Log file exist
    elseif exist("Log_data") == 2
    
        Log_data = readtable("./Output_Files/data_log_2_sort.csv");

        % Convert the column of the Timestamp to numeric values
        Log_data.(Log_data.Properties.VariableNames{3}) = str2double(Log_data.(Log_data.Properties.VariableNames{3}));

        % Select the Race Start time
        startTimeLog = Log_data{1,3};  

        % Subtracts the start time from the race times
        RaceDataB.Timestamp = RaceDataB.Timestamp - startTimeLog;
    end

    % Apply the convert function to the Timestamp column
    RaceDataB.Timestamp = arrayfun(@algorithmus.convertFormat, RaceDataB.(columnIndex), 'UniformOutput', false);

    % Generation of the mat files for the GUI
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