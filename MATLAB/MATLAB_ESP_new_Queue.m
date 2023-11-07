% Erstellen der seriellen Verbindung zum ESP über USB
esp = serial('COM3', 'BAUD', 115200);
fopen(esp);

while true

pause(1);

% Lesen der Daten vom Arduino
try
    dateiname = 'daten.txt';
    datei = fopen(dateiname, 'w');

    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben: ', 's');
    % Senden Sie den Befehl an den ESP8266
    fprintf(esp, userInput);

    queue_size = 50; % Anpassen der Größe

    % Daten vom ESP8266 empfangen und in die Datei schreiben
    if strcmp(userInput, 'fill')
            % Datei zum Speichern der empfangenen Daten erstellen
            dateiname = 'daten.txt';
            datei = fopen(dateiname, 'w');
            
            condition = true;
            
            while condition           
                if esp.BytesAvailable > 0
                    daten = fscanf(esp, '%s'); % Daten vom ESP8266 lesen
                    fprintf(datei, '%s\n', daten); % Daten in die Datei schreiben
                    disp(daten);
                    % % Warten auf Benutzereingabe in der MATLAB-Konsole
                    % userInput = input('Befehl eingeben: ', 's');
                    % % Senden Sie den Befehl an den ESP8266
                    % fprintf(esp, userInput);
                end
            end
    elseif userInput == 'stop'
    condition = false;
    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben: ', 's');
    % Senden Sie den Befehl an den ESP8266
    fprintf(esp, userInput);
    elseif strcmp(userInput, 'clear')
    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben: ', 's');
    % Senden Sie den Befehl an den ESP8266
    fprintf(esp, userInput);
    end

catch
    disp('Fehler beim Lesen von Daten vom ESP.');
   
end
end
% Schließen Sie die serielle Verbindung zum Arduino
fclose(esp);
delete(esp);

