function bt_autoupdate(src, callbackdata)
    global stopUpdating;
    stopUpdating = false; % Initialize control variable

    folderPath = '../Controll_GUI_V3/Output_GUI'; % Path to your files
    lampArray = getappdata(0, 'lampArray'); % Retrieve LED Lampen

    % Retrieve the main data structure from the base workspace
    data = guidata(src.Parent);

    % Loop to continuously check for new files
    % Loop to continuously check for new files
    while ~stopUpdating
        files = dir(fullfile(folderPath, '*.mat'));
        for i = 1:length(files)
            fileName = files(i).name;
            variableName = erase(fileName, '.mat'); % Convert file name to variable name

            fileData = load(fullfile(folderPath, fileName));
            if isfield(fileData, variableName)
                timeTable = fileData.(variableName); % Extract the table
                timeString = timeTable{1, 3}; % Assuming the time value is a string in the third column
            
                % Replace the last colon with a decimal point for milliseconds
                timeString = regexprep(timeString, ':(?=\d+$)', '.');
                formattedTimeValue = timeString;% = duration(timeString, 'InputFormat', 'mm:ss.SSS'); % Convert to duration
                
                % Process and update based on variableName
                switch variableName
                    % Include cases for each file name, for example:
            case 'rndOneSp1DO'
                % Update TNData and GUI elements here
                data.TNData.firRndSplit1BO(data.idx) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeOneSp1DODuelDisp'),'Text',string(formattedTimeValue))
                
                % Update LED colors
                set(lampArray(1), 'Color', 'green'); % Set current LED to green
                set(lampArray(2), 'Color', 'yellow'); % Set current LED to yellow
                
            case 'rndOneSp2DO'
                data.TNData.firRndSplit2BO(data.idx) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeOneSp2DODuelDisp'),'Text',string(formattedTimeValue))
                
                % Update LED colors
                set(lampArray(2), 'Color', 'green'); % Set current LED to green
                set(lampArray(3), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndOneDO'
                data.TNData.firRndBO(data.idx) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeOneDODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(3), 'Color', 'green'); % Set current LED to green
                set(lampArray(4), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndTwoSp1DO'
                data.TNData.secRndSplit1BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoSp1DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(4), 'Color', 'green'); % Set current LED to green
                set(lampArray(5), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndTwoSp2DO'
                data.TNData.secRndSplit2BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoSp2DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(5), 'Color', 'green'); % Set current LED to green
                set(lampArray(6), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndTwoDO'
                data.TNData.secRndBO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoDODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(6), 'Color', 'green'); % Set current LED to green
                set(lampArray(7), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndThreeSp1DO'
                data.TNData.thiRndSplit1BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeSp1DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(7), 'Color', 'green'); % Set current LED to green
                set(lampArray(8), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndThreeSp2DO'
                data.TNData.thiRndSplit2BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeSp2DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(lampArray(8), 'Color', 'green'); % Set current LED to green
                set(lampArray(9), 'Color', 'yellow'); % Set current LED to yellow
    
            case 'rndThreeDO'
                data.TNData.thiRndBO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeDODuelDisp'),'Text',string(formattedTimeValue))
    
                set(lampArray(9), 'Color', 'green'); % Set current LED to green
    
            case 'rndOneSp1DT'
                data.TNData.firRndSplit1BO(data.idx+1) = formattedTimeValue;   
                set(findall(0,'Tag','lblTimeOneSp1DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndOneSp2DT'
                data.TNData.firRndSplit2BO(data.idx+1) = formattedTimeValue;    
                set(findall(0,'Tag','lblTimeOneSp2DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndOneDT'
                data.TNData.firRndBO(data.idx+1) = formattedTimeValue;    
                set(findall(0,'Tag','lblTimeOneDTDuelDisp'),'Text',string(formattedTimeValue))

    
            case 'rndTwoSp1DT'
                data.TNData.secRndSplit1BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoSp1DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndTwoSp2DT'
                data.TNData.secRndSplit2BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoSp2DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndTwoDT'
                data.TNData.secRndBO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoDTDuelDisp'),'Text',string(formattedTimeValue))
    
            case 'rndThreeSp1DT'
                data.TNData.thiRndSplit1BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeSp1DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndThreeSp2DT'
                data.TNData.thiRndSplit2BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeSp2DTDuelDisp'),'Text',string(formattedTimeValue))

            case 'rndThreeDT'
                data.TNData.thiRndBO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeDTDuelDisp'),'Text',string(formattedTimeValue))
    
            case 'MeterOneDO'
                data.TNData.firRndBOMT(data.idx) = str2double(src.Value);    
            case 'MeterTwoDO'
                data.TNData.secRndBOMT(data.idx) = str2double(src.Value);       
            case 'MeterThreeDO'
                data.TNData.thiRndBOMT(data.idx) = str2double(src.Value);      
            case 'MeterOneDT'
                data.TNData.firRndBOMT(data.idx+1) = str2double(src.Value);       
            case 'MeterTwoDT'
                data.TNData.secRndBOMT(data.idx+1) = str2double(src.Value);      
            case 'MeterThreeDT'
                data.TNData.thiRndBOMT(data.idx+1) = str2double(src.Value);     
            end

                 % Update the main data structure in the base workspace
                guidata(src,data);
                drawnow; 

                delete(fullfile(folderPath, fileName)); % Delete the processed file
            end
        end

        pause(1); % Pause to prevent system overload
    end
end
