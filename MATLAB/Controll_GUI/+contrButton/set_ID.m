function set_ID(dropdown)
        % Get the selected team from the dropdown menu
        selectedTeam = dropdown.Value;
        
        % Save the team name to a file
        save('id_file.mat', 'selectedTeam');
        
        % Send the set_ID command to esp1
        fprintf(esp1, 'set_ID');
        
        % Wait for and process the response from esp1
        while esp1.NumBytesAvailable > 0
            data_esp = fscanf(esp1, '%s');
            % Split the string into its components
            splitstring = strsplit(data_esp, ' ');
            data.teamname = str2double(splitstring{1});
            data.id = str2double(splitstring{2});
            data.pos = str2double(splitstring{3});

            % Load the existing data and update it
            load('id_file.mat');
            save('id_file.mat', 'data');
        end
end
