function processCSV(inputFile, outputFile)
    % Read the *csv.file
    data = readtable(inputFile);
    
    % Delete rows with empty cells
    data(any(ismissing(data), 2), :) = [];

     % Delete ident rows
    data = unique(data, 'rows');
    
    writetable(data, outputFile);
end

