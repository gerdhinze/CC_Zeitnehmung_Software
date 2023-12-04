% % Dateipfad zur CSV-Datei
% csvFilePath = 'file.csv';
% 
% % Spaltenüberschriften
% headers = {'Station', 'ID', 'Zeit'};
% 
% id_1 = 'A01cadfsdf';
% id_2 = 'B45lkjdsfk';
% 
% if rand() < 0.5
%     id = id_1;
% else
%     id = id_2;
% end
% 
% station_1 = 'Station 1';
% station_2 = 'Station 2';
% station_3 = 'Station 3';
% 
% if rand() < 1/3
%     station = station_1;
% elseif rand() < 2/3
%     station = station_2;
% else
%     station = station_3;
% end
% 
% % Daten zum Hinzufügen
% newData = {station, id, datetime('now')};
% 
% % Überprüfen, ob die Datei vorhanden ist
% if exist(csvFilePath, 'file') == 0
%     % Datei existiert nicht, erstelle die Datei mit Spaltenüberschriften
%     fid = fopen(csvFilePath, 'w');
%     fprintf(fid, '%s,%s,%s\n', headers{:});
%     fclose(fid);
% end
% 
% % Öffne die CSV-Datei im Append-Modus und füge neue Daten hinzu
% fid = fopen(csvFilePath, 'a');
% fprintf(fid, '%s,%s,%s\n', newData{:});
% fclose(fid);
% 
% disp('Neue Daten wurden zur CSV-Datei hinzugefügt.');


headers = {'Station', 'ID', 'Zeit'};

id_1 = 'A01cadfsdf';
id_2 = 'B45lkjdsfk';

if rand() < 0.5
    id = id_1;
else
    id = id_2;
end

station_1 = 'Station 1';
station_2 = 'Station 2';
station_3 = 'Station 3';

if rand() < 1/3
    station = station_1;
elseif rand() < 2/3
    station = station_2;
else
    station = station_3;
end

newData = table({station}, {id}, {datestr(datetime('now'), 'HH:MM:SS')}, 'VariableNames', headers);

if exist(csvFilePath, 'file') == 0
    % File doesn't exist, create it with headers
    writetable(newData, csvFilePath, 'WriteMode', 'overwrite');
else
    % File exists, append data
    writetable(newData, csvFilePath, 'WriteMode', 'append', 'WriteVariableNames', false);
end

disp('Neue Daten wurden zur CSV-Datei hinzugefügt.');

