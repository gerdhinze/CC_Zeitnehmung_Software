function [command, receive] = set_ID(selectedTeam, esp, parity)

    receive = '';
    command = '';

    if parity == 1
        command = 'set_ID';

        % Send the set_ID command to esp
        fprintf(esp, command);

        % Wait for and process the response from esp
        while esp.BytesAvailable > 0
            string = fgets(esp);

            % Uncomment the following line if checking for a response starting with 'id'
            if startsWith(string, 'id')
                % Eliminate the first character
                string = extractAfter(string, 1);
                receive = string(2:14);

                display(receive);

                % Ensure that there are enough elements in splitstring
                data.teamname = selectedTeam;  
                data.id = str2double(receive);
                data.pos = 'Station 1';           

                data_csv = {'Station Nr.', 'Teamname', 'ID'; data.pos, data.teamname, data.id};
                
                % Write data in .csv file
                writecell(data_csv, 'ID-file.csv');
            else
                receive = 'Bitte Wiederholen!';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end
end
