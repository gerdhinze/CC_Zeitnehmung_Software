function [time_esp, command, receive] = get_time(esp, parity)
    % Initialize output variable
    time_esp = [];
    
    if parity == 1
        command = 'get_time';
        fprintf(esp, command);
        pause(0.5);
        while esp.BytesAvailable > 0
            string_time = fgets(esp);

            if startsWith(string_time, 't')
                % Eliminate first charakter
                receive = 'Realtime gesendet';
                time_esp = extractAfter(string_time, 1);
                
            else
            time_esp = '00:00:00';
            end
        end
    else
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
        % Handle the case where parity is not equal to 1
        time_esp = '00:00:00';
    end
end

