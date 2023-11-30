function set_ID(selectedTeam, esp, parity, txtAreaESP1_tx, txtAreaESP1_rx)

    id = '';
    scan = 0;
    file = 'ID_file.csv';

    if parity == 1
        command = 'set_ID';
        txtAreaESP1_tx.Value = command;
        
        % Send the set_ID command to esp
        fprintf(esp, command);

        % Wait for and process the response from esp
        while esp.BytesAvailable > 0
            string = fgets(esp);
            display(string);
            
            if contains(string, 'id')
                txtAreaESP1_rx.Value = 'Ready to scan';
                scan = 1;
            else
                txtAreaESP1_rx.Value = 'Bitte Wiederholen';
                continue;
            end
        end

        while scan
            while esp.BytesAvailable > 0
                string_id = fgets(esp);

                if  ~isempty(string_id)
                    if startsWith(string_id, 'id')
                        id = extractAfter(string_id, 2);
                        txtAreaESP1_rx.Value = id;
                        display(id);
                    end
                    scan = 0;
                else
                    scan = 1; 
                end
            end
        end

        data.teamname = selectedTeam;  
        data.id = id;
        data.pos = 'Station 1';           

        data_csv = {'Station Nr.', 'Teamname', 'ID'; data.pos, data.teamname, data.id};

        save(file);

        
        % Write the combined data back to the file
        writecell(data_csv, file);
        

    elseif parity == 0
        txtAreaESP1_tx.Value = 'Keine Verbindung';
        txtAreaESP1_rx.Value = 'Keine Verbindung';
    end
end
