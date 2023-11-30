function[command_esp1, receive_esp1, command_esp2, receive_esp2, command_esp3, receive_esp3] = start(dataFile)
    
    global esp1 esp2 esp3;
    global parity1 parity2 parity3;
    global stop_value;

    command_esp1 = '';
    command_esp2 = '';
    command_esp3 = '';

    receive_esp1 = '';
    receive_esp2 = '';
    receive_esp3 = '';

    data_esp1 = '';
    data_esp2 = '';
    data_esp3 = '';


    if parity1 && parity2 && parity3
        command_esp1 = 'start';
        command_esp2 = 'start';
        command_esp3 = 'start';

        fprintf(esp1, command_esp1);
        fprintf(esp2, command_esp2);
        fprintf(esp3, command_esp3);

        while stop_value == 0      
            while esp1.BytesAvailable > 0
                data_esp1 = fgets(esp1);
            end
            while esp2.BytesAvailable > 0
                data_esp2 = fgets(esp2);
            end
            while esp3.BytesAvailable > 0
                data_esp3 = fgets(esp3);
            end
            if contains(data_esp1, 'ld')
                string = extractAfter(data_esp1, 2);
                disp(string);

                % % Split the string into its components
                % splitstring = strsplit(string, ' ');
                % 
                % % % Überprüfen, ob genügend Elemente vorhanden sind, bevor auf das dritte Element zugegriffen wird
                % if numel(splitstring) >= 3
                %     pos = (string(1));
                %     id = (string(2));
                %     timestamp = (string(3));

                    % disp(pos);
                    % disp(id);
                    % disp(timestamp);

            % else
            %     % Falls nicht genügend Elemente vorhanden sind, eine Fehlermeldung ausgeben oder anders reagieren
            %     receive_esp1 = 'Nicht genügend Elemente in gesendet';
            % end
            % data_csv = {'Station Nr.', 'ID', 'Time'; data.pos, data.id, data.timestamp};
            % 
            % % Write data in .csv file
            % writecell(data_csv, dataFile);

            elseif contains(data_esp2, 'ld')
                string = extractAfter(data_esp2, 2);
                disp(string);

                % % Split the string into its components
                % splitstring = strsplit(string, ' ');

                % % % Überprüfen, ob genügend Elemente vorhanden sind, bevor auf das dritte Element zugegriffen wird
                % if numel(splitstring) >= 3
                %     pos = (string(1));
                %     id = (string(2));
                %     timestamp = (string(3));
                % 
                %     disp(pos);
                %     disp(id);
                %     disp(timestamp);
                % 
                % else
                %     % Falls nicht genügend Elemente vorhanden sind, eine Fehlermeldung ausgeben oder anders reagieren
                %     receive_esp1 = 'Nicht genügend Elemente in gesendet';
                % end
            elseif contains(data_esp3, 'ld')
                string = extractAfter(data_esp3, 2);
                disp(string);

                % % Split the string into its components
                % splitstring = strsplit(string, ' ');
                % 
                % % % Überprüfen, ob genügend Elemente vorhanden sind, bevor auf das dritte Element zugegriffen wird
                % if numel(splitstring) >= 3
                %     pos = (string(1));
                %     id = (string(2));
                %     timestamp = (string(3));
                % 
                %     disp(pos);
                %     disp(id);
                %     disp(timestamp);
                % 
                % else
                %     % Falls nicht genügend Elemente vorhanden sind, eine Fehlermeldung ausgeben oder anders reagieren
                %     receive_esp1 = 'Nicht genügend Elemente in gesendet';
            % end
            else
                receive_esp1 = 'Keine Antwort';
                receive_esp2 = 'Keine Antwort';
                receive_esp3 = 'Keine Antwort';
            end
        end

    else
        command_esp1 = 'Bitte alle Stationen verbinden';
        receive_esp1 = 'Bitte alle Stationen verbinden';

        command_esp2 = 'Bitte alle Stationen verbinden';
        receive_esp2 = 'Bitte alle Stationen verbinden';

        command_esp3 = 'Bitte alle Stationen verbinden';
        receive_esp3 = 'Bitte alle Stationen verbinden';
    end

end
