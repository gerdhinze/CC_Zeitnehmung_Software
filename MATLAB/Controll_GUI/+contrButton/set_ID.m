function set_ID
    teamname = get(team, 'string');
    save('id_file.mat');

    fprintf(esp1, 'set_ID');
    while esp1.Numbytesavailable > 0
        data_esp = fscanf(esp1, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_esp, ' ');
        data.teamname = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.pos = str2double(splitstring{3});
        
        load('id_file.mat');
        save('id_file.mat', 'data');
    end
end

