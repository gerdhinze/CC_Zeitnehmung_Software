% Erstellen der seriellen Verbindung zum ESP über USB
esp = serial('COM3', 'BAUD', 115200);
fopen(esp);

while true

% Lesen der Daten vom Arduino
try
    % Warten auf Benutzereingabe in der MATLAB-Konsole
    userInput = input('Befehl eingeben (get/set Wert): ', 's');
    
    % Überprüfen, ob der Befehl 'exit' ist, um das Programm zu beenden
    if strcmpi(userInput, 'exit')
        break;
    end
    
    % Senden Sie den Befehl an den ESP8266
    fprintf(esp, userInput);
    
    % Warten auf eine Antwort vom ESP8266
    response = fscanf(esp, '%s');
    
    % Zeigen Sie die Antwort in der MATLAB-Konsole an
    disp(['Antwort vom ESP8266: ' response]);
catch
    disp('Fehler beim Lesen von Daten vom Arduino.');
   
end
end
% Schließen Sie die serielle Verbindung zum Arduino
fclose(esp);
delete(esp);
