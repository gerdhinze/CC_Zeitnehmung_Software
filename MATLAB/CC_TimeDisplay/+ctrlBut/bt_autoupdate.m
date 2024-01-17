function bt_autoupdate(src, callbackdata)
    global stopUpdating;
    stopUpdating = false; % Initialize control variable

    folderPath = '../Controll_GUI_V3/Output_GUI'; % Path to your files
    lampArray = getappdata(0, 'lampArray'); % Retrieve LED Lampen

    set(findall(0,'Tag','AutoupdateLED'),'color','green');

    % Retrieve the main data structure from the base workspace
    data = guidata(src.Parent);

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
                set(findall(0,'Tag','Lamp1'),'color','green');
                %set(findall(0,'Tag','Lamp2'),'color','yellow');
                
            case 'rndOneSp2DO'
                data.TNData.firRndSplit2BO(data.idx) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeOneSp2DODuelDisp'),'Text',string(formattedTimeValue))
                
                % Update LED colors
                set(findall(0,'Tag','Lamp2'),'color','green');
               % set(findall(0,'Tag','Lamp3'),'color','yellow');
    
            case 'rndOneDO'
                data.TNData.firRndBO(data.idx) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeOneDODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp3'),'color','green');
                %set(findall(0,'Tag','Lamp4'),'color','yellow');
    
            case 'rndTwoSp1DO'
                data.TNData.secRndSplit1BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoSp1DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp4'),'color','green');
                %set(findall(0,'Tag','Lamp5'),'color','yellow');
    
            case 'rndTwoSp2DO'
                data.TNData.secRndSplit2BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoSp2DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp5'),'color','green');
                %set(findall(0,'Tag','Lamp6'),'color','yellow');
      
            case 'rndTwoDO'
                data.TNData.secRndBO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeTwoDODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp6'),'color','green');
                %set(findall(0,'Tag','Lamp7'),'color','yellow');
    
            case 'rndThreeSp1DO'
                data.TNData.thiRndSplit1BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeSp1DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp7'),'color','green');
                %set(findall(0,'Tag','Lamp8'),'color','yellow');
    
            case 'rndThreeSp2DO'
                data.TNData.thiRndSplit2BO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeSp2DODuelDisp'),'Text',string(formattedTimeValue))
    
                % Update LED colors
                set(findall(0,'Tag','Lamp8'),'color','green');
                %set(findall(0,'Tag','Lamp9'),'color','yellow');
    
            case 'rndThreeDO'
                data.TNData.thiRndBO(data.idx) = formattedTimeValue; 
                set(findall(0,'Tag','lblTimeThreeDODuelDisp'),'Text',string(formattedTimeValue))
    
                set(findall(0,'Tag','Lamp9'),'color','green');
    
            case 'rndOneSp1DT'
                data.TNData.firRndSplit1BO(data.idx+1) = formattedTimeValue;   
                set(findall(0,'Tag','lblTimeOneSp1DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp10'),'color','green');
                %set(findall(0,'Tag','Lamp11'),'color','yellow');

            case 'rndOneSp2DT'
                data.TNData.firRndSplit2BO(data.idx+1) = formattedTimeValue;    
                set(findall(0,'Tag','lblTimeOneSp2DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp11'),'color','green');
                %set(findall(0,'Tag','Lamp12'),'color','yellow');

            case 'rndOneDT'
                data.TNData.firRndBO(data.idx+1) = formattedTimeValue;    
                set(findall(0,'Tag','lblTimeOneDTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp12'),'color','green');
                %set(findall(0,'Tag','Lamp13'),'color','yellow');
    
            case 'rndTwoSp1DT'
                data.TNData.secRndSplit1BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoSp1DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp13'),'color','green');
                %set(findall(0,'Tag','Lamp14'),'color','yellow');

            case 'rndTwoSp2DT'
                data.TNData.secRndSplit2BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoSp2DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp14'),'color','green');
                %set(findall(0,'Tag','Lamp15'),'color','yellow');

            case 'rndTwoDT'
                data.TNData.secRndBO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeTwoDTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp15'),'color','green');
                %set(findall(0,'Tag','Lamp16'),'color','yellow');
    
            case 'rndThreeSp1DT'
                data.TNData.thiRndSplit1BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeSp1DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp16'),'color','green');
                %set(findall(0,'Tag','Lamp17'),'color','yellow');

            case 'rndThreeSp2DT'
                data.TNData.thiRndSplit2BO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeSp2DTDuelDisp'),'Text',string(formattedTimeValue))

                % Update LED colors
                set(findall(0,'Tag','Lamp17'),'color','green');
                %set(findall(0,'Tag','Lamp18'),'color','yellow');

            case 'rndThreeDT'
                data.TNData.thiRndBO(data.idx+1) = formattedTimeValue;
                set(findall(0,'Tag','lblTimeThreeDTDuelDisp'),'Text',string(formattedTimeValue))

                set(findall(0,'Tag','Lamp18'),'color','green');
    
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
                %drawnow; 

                delete(fullfile(folderPath, fileName)); % Delete the processed file
            end
        end

        pause(1); % Pause to prevent system overload
    end
end
