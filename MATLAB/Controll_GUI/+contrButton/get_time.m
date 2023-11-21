function [time_esp, command] = get_time(esp, parity)
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
            else
            time_esp = 'Keine Antwort';
            end
        end
    else
        command = 'Keine Verbindung';
        % Handle the case where parity is not equal to 1
        time_esp = '00:00:00';
    end
end

