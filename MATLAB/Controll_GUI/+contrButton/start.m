function[command, receive] = start(esp, parity, dataFile)
    
    save(dataFile);
    command = '';
    receive = '';

    if parity == 1
        command = 'start';
        fprintf(esp, command);
        pause(0.5);

        while esp.BytesAvailable > 0
            data_esp = fgets(esp);

            if startsWith(data_esp, 'ld')

                receive = data_esp(2:6);
                data_esp = extractAfter(data_esp, 6);
                
                % Split the string into its components
                splitstring = strsplit(data_esp, ' ');

                data.pos = str2double(splitstring{1});
                data.id = str2double(splitstring{2});
                data.timestamp = str2double(splitstring{3});

                data_csv = {'Station Nr.', 'ID', 'Time'; data.pos, data.id, data.timestamp};
                
                % Write data in .csv file
                writecell(data_csv, 'Data-Log.csv');
            else
                receive = 'Keine Antwort';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end

end
