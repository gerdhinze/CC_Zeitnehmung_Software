function [realtime, realtime_esp1, realtime_esp2, realtime_esp3] = sync_time(esp1, esp2, esp3)
    global esp1;
    global esp2;
    global esp3;

    % Initialize output variables
    realtime_esp1 = '';
    realtime_esp2 = '';
    realtime_esp3 = '';

    % Get the current system time and date
    currentDateTime = clock;

    hours = sprintf('%02d', currentDateTime(4));    % Add leading zero if needed
    minutes = sprintf('%02d', currentDateTime(5));  % Add leading zero if needed
    seconds = sprintf('%02d', floor(currentDateTime(6)));  % Add leading zero if needed

    realtime = [hours ':' minutes ':' seconds];
    
        if isvalid(esp1) && isequal(esp1.Status, 'open')
            fprintf(esp1, 'sync_time\n');
            pause(1);
            fprintf(esp1, realtime);
            pause(1);
            fprintf(esp1, 'get_time\n');
            realtime_esp1 = fscanf(esp1, '%s');
            disp(['Realtime from esp1: ', realtime_esp1]);
        end
        
        if isvalid(esp2) && isequal(esp2.Status, 'open')
            fprintf(esp2, 'sync_time\n');
            pause(1);
            fprintf(esp2, realtime);
            pause(1);
            fprintf(esp2, 'get_time\n');
            realtime_esp2 = fscanf(esp2, '%s');
            disp(['Realtime from esp2: ', realtime_esp2]);
        end

        if isvalid(esp3) && isequal(esp3.Status, 'open')
            fprintf(esp3, 'sync_time\n');
            pause(1);
            fprintf(esp3, realtime);
            pause(1);
            fprintf(esp3, 'get_time\n');
            realtime_esp3 = fscanf(esp3, '%s');
            disp(['Realtime from esp3: ', realtime_esp3]);
        end
end
