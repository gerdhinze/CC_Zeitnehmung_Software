function [realtime_esp1, realtime_esp2, realtime_esp3] = sync_time(esp1, esp2, esp3)
    % Get the current system time and date
    currentDateTime = clock;
    realtime = [num2str(currentDateTime(4)) ':' num2str(currentDateTime(5)) ':' num2str(currentDateTime(6))];
    
    % Initialize output variables
    realtime_esp1 = '';
    realtime_esp2 = '';
    realtime_esp3 = '';

    try
        if isvalid(esp1)
            fprintf(esp1, 'sync_time\n');
            pause(0.5);
            realtime_esp1 = fscanf(esp1, '%s');
            disp(['Realtime from esp1: ', realtime_esp1]);
        end
        
        if isvalid(esp2)
            fprintf(esp2, 'sync_time\n');
            pause(0.5);
            realtime_esp2 = fscanf(esp2, '%s');
            disp(['Realtime from esp2: ', realtime_esp2]);
        end
        
        if isvalid(esp3)
            fprintf(esp3, 'sync_time\n');
            pause(0.5);
            realtime_esp3 = fscanf(esp3, '%s');
            disp(['Realtime from esp3: ', realtime_esp3]);
        end
        
        disp('Time successfully synchronized.');
    catch
        % Handle errors if the synchronization fails
        errordlg('Error synchronizing time.', 'Error');
    end
end
