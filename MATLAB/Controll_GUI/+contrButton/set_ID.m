function set_ID
    teamname = get(team, 'string');
    save('datafile.mat');

    fprintf(esp1, 'set_ID');
    while esp1.Numbytesavailable > 0
        Id = fscanf(esp1, '%s');
        load('datafile.mat');
        combinedData = [teamname, Id];
        save('datafile.mat', 'combinedData');
    end
end

