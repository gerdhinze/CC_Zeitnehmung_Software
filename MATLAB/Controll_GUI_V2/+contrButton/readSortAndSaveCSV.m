function readSortAndSaveCSV(inputFile, outputFile)
    % Read data from the input CSV file
    data = readtable(inputFile);

    % Remove rows where 'id' is 'stop'
    data = data(~strcmp(data.ID, 'stop'), :);

    % Remove duplicate rows
    data = unique(data, 'rows');

    % Sort the table by the 'timestamp' column in ascending order
    sortedData = sortrows(data, 'Timestamp');

     % Check if the last row in the first data file has "Lichtschranke" in the "ID" column
     if isequal(inputFile, './Output_Files/data_log_2.csv')
         if strcmp(sortedData.ID(end), 'Lichtschranke')
            % If true, remove the last row
            sortedData(end, :) = [];
         end
    end

    % Save the sorted data to a new CSV file
    writetable(sortedData, outputFile);
end


