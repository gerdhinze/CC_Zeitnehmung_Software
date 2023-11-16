function read_log(esp, parity)
    
    save('datalog.mat');
    
    if parity == 1
    fprintf(esp, 'read_log');
    pause(0.5);
    while esp.BytesAvailable > 0
        data_log = fscanf(esp, '%s');
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

