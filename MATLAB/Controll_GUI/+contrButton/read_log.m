function read_log()
    
    save('datalog.mat');
    
    if isvalid(esp1)
    fprintf(esp1, 'read_log');
    pause(0.5);
    while ESP1.NumBytesAvailable > 0
        data_log = fscanf(esp1, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_log, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('datalog.mat');
        save('datalog.mat', 'data');
    end
    elseif isvalid(esp2)
    fprintf(esp2, 'read_log');
    pause(0.5);
    while ESP1.NumBytesAvailable > 0
        data_log = fscanf(esp2, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_log, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('datalog.mat');
        save('datalog.mat', 'data');
    end
    elseif isvalid(esp3)
    fprintf(esp3, 'read_log');
    pause(0.5);
    while ESP1.NumBytesAvailable > 0
        data_log = fscanf(esp3, '%s');
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_log, ' ');

        data.station = str2double(splitstring{1});
        data.id = str2double(splitstring{2});
        data.timestamp = str2double(splitstring{3});
        
        % .mat-Datei speichern
        load('datalog.mat');
        save('datalog.mat', 'data');
    end
    end
end

