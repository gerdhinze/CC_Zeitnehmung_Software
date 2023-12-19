% Beispiel-Daten erstellen
data = {'Name', 'Alter', 'Stadt'; 'Alice', 25, 'Berlin'; 'Bob', 30, 'München'; 'Charlie', 22, 'Hamburg'};

% Daten in eine CSV-Datei schreiben
writecell(data, 'meineDaten.csv');