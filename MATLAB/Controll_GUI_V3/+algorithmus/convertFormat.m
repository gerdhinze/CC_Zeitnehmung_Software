function convertedTimestamp = convertFormat(milliseconds)
     % Convert milliseconds to seconds
    totalSeconds = milliseconds / 1000;

    % Calculate minutes, seconds, and milliseconds
    minutes = floor(totalSeconds / 60);
    seconds = rem(round(totalSeconds), 60);
    milliseconds = rem(milliseconds, 1000);

    % Format the result in mm:ss:SSS
    convertedTimestamp = sprintf('%02d:%02d:%03d', minutes, seconds, milliseconds);
end
