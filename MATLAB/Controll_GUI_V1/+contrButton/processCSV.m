function processCSV(inputFile, outputFile)
    % Lese die CSV-Datei
    data = readtable(inputFile);
    
    % Entferne Zeilen mit leeren Zellen in einer der drei Spalten
    data(any(ismissing(data), 2), :) = [];

     % Entferne doppelte Zeilen
    data = unique(data, 'rows');
    
    % Speichere den bearbeiteten Table in einer neuen CSV-Datei
    writetable(data, outputFile);
end

