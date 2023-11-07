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
    
    
while true

% Lesen der Daten vom ESP
try
     % Überprüfen, ob der Befehl 'exit' ist, um das Programm zu beenden
    if strcmpi(userInput, 'exit')
        break;
    end

    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben: ', 's');
    fprintf(esp1, userInput);
    fprintf(esp2, userInput);
    
    while esp1.BytesAvailable > 0
        daten = fscanf(esp1, '%s'); % Daten vom ESP8266 lesen
        fprintf(datei, '%s\n', daten); % Daten in die Datei schreiben
        disp(['Antwort vom ESP1: ' daten]);
    end

    while esp2.BytesAvailable > 0
        daten = fscanf(esp2, '%s'); % Daten vom ESP8266 lesen
        fprintf(datei, '%s\n', daten); % Daten in die Datei schreiben
        disp(['Antwort vom ESP2: ' daten]);
    end

catch
    disp('Fehler beim Lesen von Daten vom ESP.');

end
end
%Schließen der seriellen Verbindung zum Arduino
fclose(esp1);
fclose(esp2);
