function ident = compare_log(file1, file2)
    % Read data from the first CSV file
    data1 = readtable(file1);

    % Read data from the second CSV file
    data2 = readtable(file2);

    % Compare entire tables
    ident = isequal(data1, data2);
end

