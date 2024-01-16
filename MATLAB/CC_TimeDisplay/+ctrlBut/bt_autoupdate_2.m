function bt_autoupdate(src, callbackdata, autoUpdateLED)
    global stopUpdating;
    stopUpdating = false; % Initialize control variable

    % Loop to continuously check and update files
    while ~stopUpdating
        checkAndUpdateFiles();
        pause(0.5); % Pause to prevent system overload
    end
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
        filePath = fullfile('C:\RaceFiles\', strcat(fileName, '.mat'));

        % Check for file existence
        if exist(filePath, 'file') == 2
            loadedData = load(filePath);
            timeValue = loadedData.(fileName)(1,3); % Extracting time value

            % Find the UI element by its tag
            uiElement = findobj('Tag', fileName);

            % If the UI element is found, update its value and call edit_valChange
            if ~isempty(uiElement)
                set(uiElement, 'Value', timeValue);
                ctrlBut.edit_valChange();
end
end
end
end