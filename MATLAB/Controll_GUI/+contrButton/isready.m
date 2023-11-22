function [command, receive] = isready(esp, parity)

    receive = '';  % Initialize receive variable

    if parity == 1
        command = 'ready';
        fprintf(esp, command);
        pause(0.5);
                
        % Wait for and process the response from esp1
        while esp.BytesAvailable > 0
            string = fgets(esp);
    
            if startsWith(string, 'ir')
                % Eliminate first character
                string = extractAfter(string, 1);
                receive = string(2:10);
            else
                receive = 'Bitte Wiederholen!';
            end
        end

        % Load data from the file 'id_file.mat' and send it back to ESP
        data = load('id_file.mat');
        if isfield(data, 'Value')  
        % Extrahiere den Wert aus der zweiten Spalte und ersten Zeile
        extracted_string = data.Value{1, 2};
        fprintf(esp, extracted_string);
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Antwort';
    end
end
