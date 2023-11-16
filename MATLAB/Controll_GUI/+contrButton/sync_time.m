function[realtime] = sync_time(esp, parity)
    
    % Get the current system time and date
    currentDateTime = clock;

    hours = sprintf('%02d', currentDateTime(4));    % Add leading zero if needed
    minutes = sprintf('%02d', currentDateTime(5));  % Add leading zero if needed
    seconds = sprintf('%02d', floor(currentDateTime(6)));  % Add leading zero if needed

    realtime = [hours ':' minutes ':' seconds];
    
        if parity == 1
            fprintf(esp, 'sync_time');
            fprintf(esp, realtime);
        end
end
