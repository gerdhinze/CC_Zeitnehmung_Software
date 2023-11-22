function [command, receive] = set_ID(selectedTeam, esp, parity)

    receive = '';
    command = '';

    if parity == 1
    command = 'set_ID';
    % Save the team name to a file
    save('id_file.mat', 'selectedTeam');

     % Send the set_ID command to esp1
    fprintf(esp, command);
    
    % Wait for and process the response from esp1
    while esp.BytesAvailable > 0
        string = fgets(esp);

        if startsWith(string, 'id')
            % Eliminate first charakter
            string = extractAfter(string, 2);
            receive = string(2:14);
            string = extractAfter(string, 14);

            % Split the string into its components
            data_esp = strsplit(string, ' ');
            display(data_esp);
            
            % % Ensure that there are enough elements in splitstring
            data.teamname = data_esp{1};  % Assuming teamname is a string
            data.id = str2double(data_esp{2});
            data.pos = str2double(data_esp{3});
           
            % Display the data
            disp([data.teamname, num2str(data.id), num2str(data.pos)]);
    
            % Load the existing data and update it
            load('id_file.mat');
            save('id_file.mat', 'data');
        else
            receive = 'Bitte Wiederholen!';
        end
    end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end
end