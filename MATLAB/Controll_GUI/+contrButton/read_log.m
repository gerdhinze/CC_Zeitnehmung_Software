function[command, receive] = read_log(esp, parity)
    
    receive = '';
    command = '';
    save('datalog.mat');
    
    if parity == 1
        command = 'read_log';
        fprintf(esp, command);
        pause(0.5);

        while esp.BytesAvailable > 0
            string = fgets(esp);
            
            if startsWith(string, 'rld')
                % Eliminate first charakter
                string = extractAfter(string, 3);
                receive = string(3:17);
                string = extractAfter(string, 17);
    
                % Split the string into its components
                data_esp = strsplit(string, ' ');
                
                % % Ensure that there are enough elements in splitstring
                data.teamname = data_esp{1};  % Assuming teamname is a string
                data.id = str2double(data_esp{2});
                data.pos = str2double(data_esp{3});
               
                % Display the data
                disp([data.teamname, num2str(data.id), num2str(data.pos)]);
        
                % Load the existing data and update it
                load('datalog.mat');
                save('datalog.mat', data);
            else
                receive = 'Keine Antwort';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Verbindung';
    end
end

