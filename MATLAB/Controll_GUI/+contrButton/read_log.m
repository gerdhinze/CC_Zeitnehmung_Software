function read_log(esp, parity)
    
    save('datalog.mat');
    
    if parity == 1
    fprintf(esp, 'read_log');
    pause(0.5);
    while esp.BytesAvailable > 0
        data_log = fgets(esp);
        % Den String in seine Bestandteile aufteilen
        splitstring = strsplit(data_log, ' ');
        
        if numel(splitstring) >= 3
            data.station = str2double(splitstring{1});
            data.id = str2double(splitstring{2});
            data.timestamp = str2double(splitstring{3});
            % Rest of your code
        else
            % Handle the case when the expected number of elements is not present
            fprintf('Error: Unexpected data format.\n');
        end
        
        % .mat-Datei speichern
        load('datalog.mat');
        save('datalog.mat', 'data');
    end
    end
end

