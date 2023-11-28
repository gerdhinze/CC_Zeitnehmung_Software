function[command, receive] = start(esp, parity, dataFile, stop)
    
    command = '';
    receive = '';
    data = struct('pos', 0, 'id', 0, 'timestamp', 0);

    if parity == 1
        command = 'start';
        fprintf(esp, command);
        pause(0.5);
 
        while stop == 0 && esp.BytesAvailable > 0
            data_esp = fgets(esp);

            if startsWith(data_esp, 'ld')

                receive = data_esp(2:6);
                data_esp = extractAfter(data_esp, 6);
                
                % Split the string into its components
                splitstring = strsplit(data_esp, ' ');

                % Überprüfen, ob genügend Elemente vorhanden sind, bevor auf das dritte Element zugegriffen wird
                if numel(splitstring) >= 3
                    data.pos = str2double(splitstring{1});
                    data.id = str2double(splitstring{2});
                    data.timestamp = str2double(splitstring{3});
                
                    % ... (weitere Verarbeitung)
                else
                    % Falls nicht genügend Elemente vorhanden sind, eine Fehlermeldung ausgeben oder anders reagieren
                    receive = 'Nicht genügend Elemente in gesendet';
                end
                data_csv = {'Station Nr.', 'ID', 'Time'; data.pos, data.id, data.timestamp};
                
                % Write data in .csv file
                writecell(data_csv, dataFile);
            else
                receive = 'Keine Antwort';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end

end
