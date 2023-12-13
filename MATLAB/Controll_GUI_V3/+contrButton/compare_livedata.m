function ident = compare_livedata(file1, file2)
    ident = true;
    % Read data from the first CSV file
    data1 = readtable(file1);

    % Read data from the second CSV file
    data2 = readtable(file2);

    % Check if the number of rows in both tables is the same
    ident = size(data1, 1) == size(data2, 1);
end


