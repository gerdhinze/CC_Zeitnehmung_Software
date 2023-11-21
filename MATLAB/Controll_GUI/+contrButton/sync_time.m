function[realtime, command, receive] = sync_time(esp, parity)
    
    % Get the current system time and date
    currentDateTime = clock;
    receive = '';  % Initialize receive variable
    
    hours = sprintf('%02d', currentDateTime(4));    % Add leading zero if needed
    minutes = sprintf('%02d', currentDateTime(5));  % Add leading zero if needed
    seconds = sprintf('%02d', floor(currentDateTime(6)));  % Add leading zero if needed

    realtime = [hours ':' minutes ':' seconds];
    
        if parity == 1
            command = 'sync_time';
            fprintf(esp, command);
            fprintf(esp, realtime);
            receive = 'Realtime gesendet';
        else
            command = 'Keine Verbindung';
            receive = 'Keine Verbindung';
        end
end
