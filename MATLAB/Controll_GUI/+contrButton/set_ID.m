function set_ID(selectedTeam)
    global esp1;

    % Save the team name to a file
    save('id_file.mat', 'selectedTeam');

     % Send the set_ID command to esp1
    fprintf(esp1, 'set_ID');

    % Wait for and process the response from esp1
    while esp1.BytesAvailable > 0
        data_esp = fgets(esp1);
        % Split the string into its components
        splitstring = strsplit(data_esp, ' ');

        % Ensure that there are enough elements in splitstring
        if numel(splitstring) >= 3
        data.teamname = splitstring{1};  % Assuming teamname is a string
        data.id = str2double(splitstring{2});
        data.pos = str2double(splitstring{3});

        % Display the data
        disp([data.teamname, num2str(data.id), num2str(data.pos)]);

        % Load the existing data and update it
        load('id_file.mat');
        save('id_file.mat', 'data');
        end
    end
end