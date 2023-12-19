function clearOutput()
    
    % Location of the files
    OutputFold = 'C:\Users\Philipp\OneDrive - FH JOANNEUM\FH Joanneum\5 Semester\ECE_Projekt\Embedded-Software\MATLAB\Data_Management\GUI Output';

    % Check to make sure that folder actually exists.  Warn user if it doesn't.
    if ~isdir(OutputFold)
        errorMessage = sprintf('Error: The following folder does not exist:\n%s', OutputFold);
        uiwait(warndlg(errorMessage));
        return;
    end

    % Get a list of all files in the folder with the desired file name pattern.
    filePattern = fullfile(OutputFold, '*.mat'); % Change to whatever pattern you need.
    theFiles = dir(filePattern);
    for k = 1 : length(theFiles)
        baseFileName = theFiles(k).name;
        fullFileName = fullfile(OutputFold, baseFileName);
        fprintf(1, 'Now deleting %s\n', fullFileName);
        delete(fullFileName);
    end

end