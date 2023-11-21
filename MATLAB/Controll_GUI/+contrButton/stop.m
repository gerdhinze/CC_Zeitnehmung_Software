function [command, receive] = stop(esp, parity)
    
    receive = '';
    command = '';
    if parity == 1
        command = 'q';
        fprintf(esp, command);
        pause(0.5);

        while esp.BytesAvailable > 0
            string = fgets(esp);
            if startsWith(string, 'q')
                % Eliminate the first character
                receive = extractAfter(string, 1);
            else
                receive = 'Keine Antwort';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end
end

