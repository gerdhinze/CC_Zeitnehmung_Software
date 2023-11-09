%Datatable

% Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Connect to ESP1 (y/n): ', 's');
    if strcmpi(userInput, 'y')
        % Erstellen der seriellen Verbindung zum ESP über USB
        esp1 = serial('COM3', 'BAUD', 115200);
        fopen(esp1);
    elseif strcmpi(userInput, 'n')
        disp('No connection required');
    end

    userInput = input('Connect to ESP2 (y/n): ', 's');
    if strcmpi(userInput, 'y')
        % Erstellen der seriellen Verbindung zum ESP über USB
        esp2 = serial('COM4', 'BAUD', 115200);
        fopen(esp2);
    elseif strcmpi(userInput, 'n')
        disp('No connection required');
    end

    userInput = input('Connect to ESP3 (y/n): ', 's');
    if strcmpi(userInput, 'y')
        % Erstellen der seriellen Verbindung zum ESP über USB
        esp3 = serial('COM5', 'BAUD', 115200);
        fopen(esp3);
    elseif strcmpi(userInput, 'n')
        disp('No connection required');
    end

    % Erhalten Sie die aktuelle Systemzeit und Datum
    currentDateTime = clock;
    realtime = [num2str(currentDateTime(4)) ':' num2str(currentDateTime(5)) ':' num2str(currentDateTime(6))];
    % Anzeigen des aktuellen Datums und der Uhrzeit
    %disp(['Aktuelles Datum und Uhrzeit: ' num2str(currentDateTime(4)) ':' num2str(currentDateTime(5)) ':' num2str(currentDateTime(6))]);
    disp('Aktuelle Uhrzeit: ');
    disp(realtime);
    
%Loop
while not(strcmpi(userInput, 'exit'))

% Lesen der Daten vom ESP
%try
     % Überprüfen, ob der Befehl 'exit' ist, um das Programm zu beenden
    if strcmpi(userInput, 'exit')
        break;
    end
    
    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben: ', 's');
    switch userInput
        case 'set_time'
            % Send command to ESP8266
            if isvalid(esp1)
                fprintf(esp1, userInput);
                pause(0.5);
                fprintf(esp1, realtime);
            elseif isvalid(esp2)
                fprintf(esp2, userInput);
                pause(0.5);
                fprintf(esp2, realtime);
            elseif isvalid(esp3)
                fprintf(esp3, userInput);
                pause(0.5);
                fprintf(esp3, realtime);
            end
        case 'set_ID'
            fprintf(esp1, userInput);
            while esp1.BytesAvailable > 0 
                ids = fscanf(esp1, '%s');
                if isvalid(esp2)
                fprintf(esp2, ids);
                elseif isvalid(esp3)
                fprintf(esp3, ids);
                end
                disp(ids);
            end
        case 'file'
            station_nr = input('Geben Sie die Stat. Nr. ein (1/2/3): ', 's');
            if strcmpi(station_nr, '1')
                fprintf(esp1, userInput);
                while esp1.BytesAvailable > 0
                    disp(fscanf(esp1, '%s'));
                end
                command = input('Geben Sie einen Befehl ein (delete_all/choose ein: ', 's');
                if strcmpi(command, 'delete_all')
                    fprintf(esp1, command);
                    while esp1.BytesAvailable > 0
                    disp(fscanf(esp1, '%s'));
                    end
                elseif strcmpi(command, 'choose')
                    fprintf(esp1, command);
                    while esp1.BytesAvailable > 0
                        disp(fscanf(esp1, '%s'));
                    end
                    command = input('Geben Sie (1/2/3/..) ein: ', 's');
                        fprintf(esp1, command);
                        while esp1.BytesAvailable > 0
                            disp(fscanf(esp1, '%s'));
                        end
                    command = input("Geben Sie (delete/read) ein: ","s");
                        fprintf(esp1, command);
                        while esp1.BytesAvailable > 0
                            disp(fscanf(esp1, '%s'));
                        end
                end
            elseif strcmpi(station_nr, '2')
                fprintf(esp2, userInput);
                while esp2.BytesAvailable > 0
                    disp(fscanf(esp2, '%s'));
                end
                command = input('Geben Sie einen Befehl ein (delete_all/choose ein: ', 's');
                if strcmpi(command, 'delete_all')
                    fprintf(esp2, command);
                    while esp2.BytesAvailable > 0
                    disp(fscanf(esp2, '%s'));
                    end
                elseif strcmpi(command, 'choose')
                    fprintf(esp2, command);
                    while esp2.BytesAvailable > 0
                        disp(fscanf(esp2, '%s'));
                    end
                    command = input('Geben Sie (1/2/3/..) ein: ', 's');
                        fprintf(esp2, command);
                        while esp2.BytesAvailable > 0
                            disp(fscanf(esp2, '%s'));
                        end
                    command = input("Geben Sie (delete/read) ein: ","s");
                        fprintf(esp2, command);
                        while esp2.BytesAvailable > 0
                            disp(fscanf(esp2, '%s'));
                        end
                end
            elseif strcmpi(station_nr, '3')
                fprintf(esp3, userInput);
                while esp3.BytesAvailable > 0
                    disp(fscanf(esp3, '%s'));
                end
                command = input('Geben Sie einen Befehl ein (delete_all/choose ein: ', 's');
                if strcmpi(command, 'delete_all')
                    fprintf(esp3, command);
                    while esp3.BytesAvailable > 0
                    disp(fscanf(esp3, '%s'));
                    end
                elseif strcmpi(command, 'choose')
                    fprintf(esp3, command);
                    while esp3.BytesAvailable > 0
                        disp(fscanf(esp3, '%s'));
                    end
                    command = input('Geben Sie (1/2/3/..) ein: ', 's');
                        fprintf(esp3, command);
                        while esp3.BytesAvailable > 0
                            disp(fscanf(esp3, '%s'));
                        end
                    command = input("Geben Sie (delete/read) ein: ","s");
                        fprintf(esp3, command);
                        while esp3.BytesAvailable > 0
                            disp(fscanf(esp3, '%s'));
                        end
                end
            end
        case 'race'
        otherwise
    end
    
%catch
    %disp('Fehler beim Lesen von Daten vom ESP.');

end
%end
%Schließen der seriellen Verbindung zum Arduino
if isvalid(esp1)
    fclose(esp1);
    delete(esp1);
    clear esp1
elseif isvalid(esp2)
    fclose(esp2)
    delete(esp2);
    clear esp2;
elseif isvalid(esp3)
    fclose(esp3)
    delete(esp3);
    clear esp3;
end
