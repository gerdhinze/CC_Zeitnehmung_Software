function [realtime, realtime_esp1, realtime_esp2, realtime_esp3] = sync_time(esp1, parity1, esp2, parity2, esp3, parity3)
    
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
    
        if parity1 == 1
            fprintf(esp1, 'sync_time\n');
            fprintf(esp1, realtime);
            fprintf(esp1, 'get_time\n');
            realtime_esp1 = fgets(esp1);
            disp(['Realtime from esp1: ', realtime_esp1]);
        end
        
        if parity2 == 1
            fprintf(esp2, 'sync_time\n');
            fprintf(esp2, realtime);
            fprintf(esp2, 'get_time\n');
            realtime_esp2 = fgets(esp2);
            disp(['Realtime from esp2: ', realtime_esp2]);
        end

        if parity3 == 1
            fprintf(esp3, 'sync_time\n');
            fprintf(esp3, realtime);
            fprintf(esp3, 'get_time\n');
            realtime_esp3 = fgets(esp3);
            disp(['Realtime from esp3: ', realtime_esp3]);
        end
end
