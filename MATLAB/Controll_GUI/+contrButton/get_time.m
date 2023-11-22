function [time_esp, command, receive] = get_time(esp, parity)
    % Initialize output variable
    time_esp = [];
    
    if parity == 1
        command = 'get_time';
        fprintf(esp, command);
        pause(0.5);
        while esp.BytesAvailable > 0
            string = fgets(esp);

            if startsWith(string, 't')
                % Eliminate first charakter
                time_esp = extractAfter(string, 1);
                receive = 'Realtime gesendet';
            else
            time_esp = '00:00:00';
            receive = 'Keine Antwort';
            end
        end
    else
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
        % Handle the case where parity is not equal to 1
        time_esp = '00:00:00';
    end
end

