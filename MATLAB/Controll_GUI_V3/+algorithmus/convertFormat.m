function formattedTime = convertFormat(milliseconds)
    % Converts milliseconds to the format mm:ss:ttt

    % Extract minutes, seconds, and milliseconds
    minutes = floor(milliseconds / (60 * 1000));
    seconds = floor((milliseconds - minutes * 60 * 1000) / 1000);
    milliseconds = milliseconds - minutes * 60 * 1000 - seconds * 1000;

    % Generate the formatted time string
    formattedTime = sprintf('%02d:%02d:%03d', minutes, seconds, milliseconds);
end
