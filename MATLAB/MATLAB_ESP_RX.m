% Erstellen der seriellen Verbindung zum ESP über USB
esp = serial('COM3', 'BAUD', 115200);
fopen(esp);

while true

% Lesen der Daten vom Arduino
try
    a = input('Befehl eingeben:');
    fprintf(esp,a);

    size = 20; % Anpassen der Größe
    dataReceived = fscanf(esp, '%s', size);
    disp(dataReceived);
  
catch
    disp('Fehler beim Lesen von Daten vom Arduino.');
   
end
end
% Schließen Sie die serielle Verbindung zum Arduino
fclose(esp);
delete(esp);
