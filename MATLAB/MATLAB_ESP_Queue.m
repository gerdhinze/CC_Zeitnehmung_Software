% Erstellen der seriellen Verbindung zum ESP über USB
esp = serial('COM3', 'BAUD', 115200);
fopen(esp);

while true

pause(1);

% Lesen der Daten vom Arduino
try
    
    queue_size = 50; % Anpassen der Größe
    dataReceived = fscanf(esp, '%s', queue_size);

    % Ausgeben der Daten in der Console
    disp('Empfangene Daten vom Arduino:');
    disp(dataReceived);

catch
    disp('Fehler beim Lesen von Daten vom ESP.');
   
end
end
% Schließen Sie die serielle Verbindung zum Arduino
fclose(esp);
delete(esp);
