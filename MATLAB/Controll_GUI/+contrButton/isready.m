function [command, receive] = isready(esp, parity)

    receive = '';  % Initialize receive variable

    if parity == 1
        command = 'ready';
        fprintf(esp, command);
        pause(0.5);
                
        % Wait for and process the response from esp1
        while esp.BytesAvailable > 0
            string = fgets(esp);
    
            if contains(string, 'ir')
                % Eliminate first character
                receive = 'is ready';
            else
                receive = 'Bitte Wiederholen!';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Antwort';
    end
end
