function bt_autoupdate(src, callbackdata, autoUpdateLED)
    global stopUpdating;
    stopUpdating = false; % Initialize control variable

    % Retrieve the LED from application data
    %autoUpdateLED = getappdata(ccHandle, 'autoUpdateLED');
    %autoUpdateLED.Color = 'green'; % Indicate auto update is on

    % Loop to continuously check and update files
    while ~stopUpdating
        checkAndUpdateFiles();
        pause(0.5); % Pause to prevent system overload
    end

    %autoUpdateLED.Color = 'red'; % Indicate auto update is off
end

function checkAndUpdateFiles()
    % Define file names corresponding to GUI components
    fileNames = {'rndOneSp1DO', 'rndOneSp2DO', 'rndOneDO', 'rndTwoSp1DO', 'rndTwoSp2DO', 'rndTwoDO',
                 'rndThreeSp1DO', 'rndThreeSp2DO', 'rndThreeDO', 'MeterOneDO', 'MeterTwoDO', 'MeterThreeDO',
                 'rndOneSp1DT', 'rndOneSp2DT', 'rndOneDT', 'rndTwoSp1DT', 'rndTwoSp2DT', 'rndTwoDT',
                 'rndThreeSp1DT', 'rndThreeSp2DT', 'rndThreeDT', 'MeterOneDT', 'MeterTwoDT', 'MeterThreeDT'};

    % Loop through file names to check and load data
    for i = 1:length(fileNames)
        fileName = fileNames{i};
        filePath = fullfile('C:\RaceFiles', strcat(fileName, '.mat'));

        % Check for file existence
        if exist(filePath, 'file') == 2
            loadedData = load(filePath);
            timeValue = loadedData.(fileName)(1,3); % Extracting time value

            % Creating a mock UI element for calling edit_valChange
            mockSrc = struct('Tag', fileName, 'Value', timeValue);

            % Invoke edit_valChange with the mock element
            ctrlBut.edit_valChange(mockSrc, []);
        end
    end
end