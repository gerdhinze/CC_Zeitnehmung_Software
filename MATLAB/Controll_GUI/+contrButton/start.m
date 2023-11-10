function start()
    
    save('data_race.mat');

    if isvalid(esp1)
    fprintf(esp1, 'start');
    pause(0.5);
    while ESP1.NumBytesAvailable > 0
        data_esp1 = fscanf(esp1, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_esp1, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('data_race.mat');
        save('data_race.mat', 'data');
    end
    elseif isvalid(esp2)
    fprintf(esp2, 'start');
    pause(0.5);
    while ESP2.NumBytesAvailable > 0
        data_esp2 = fscanf(esp2, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_esp2, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('data_race.mat');
        save('data_race.mat', 'data');
    while ESP3.NumBytesAvailable > 0
        data_esp3 = fscanf(esp3, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_esp3, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('data_race.mat');
        save('data_race.mat', 'data');
    end
    end
end

