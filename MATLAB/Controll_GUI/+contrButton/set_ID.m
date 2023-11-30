function [command, receive] = set_ID(selectedTeam, esp, parity)

    receive = '';
    command = '';
    id = '';
    scan = 0;

    if parity == 1
        command = 'set_ID';

        % Send the set_ID command to esp
        fprintf(esp, command);

        % Wait for and process the response from esp
        while esp.BytesAvailable > 0
            string = fgets(esp);
            display(string);
            
            if contains(string, 'id')
                receive = 'Ready to scan';
                scan = 1;
            else
                receive = 'Bitte Wiederholen';
                continue;
            end
        end

        while scan
            while esp.BytesAvailable > 0
                string_id = fgets(esp);

                if  ~isempty(string_id)
                    if startsWith(string_id, 'id')
                        id = extractAfter(string_id, 2);
                        receive = id;
                        display(id);
                    end
                    scan = 0;
                else
                    scan = 1; 
                end
            end
        end

        % Ensure that there are enough elements in splitstring
        % data.teamname = selectedTeam;  
        % data.id = id;
        % data.pos = 'Station 1';           
        % 
        % data_csv = {'Station Nr.', 'Teamname', 'ID'; data.pos, data.teamname, data.id};

        % Write data in .csv file
        % writecell(data_csv, 'ID-file.csv');

    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end
end
