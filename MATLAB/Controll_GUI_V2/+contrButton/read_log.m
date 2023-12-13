function read_log(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, txtAreaLog)

    global esp1 esp2 esp3;
    global parity1 parity2 parity3;

    if parity1  && parity2  && parity3 
        command = 'read_log';

        txtAreaESP1_tx.Value = command;
        txtAreaESP2_tx.Value = command;
        txtAreaESP3_tx.Value = command;

        fprintf(esp1, command);
        fprintf(esp2, command);
        fprintf(esp3, command);

        txtAreaESP1_rx.Value = "Geloggte Daten werden gelesen";
        txtAreaESP2_rx.Value = "Geloggte Daten werden gelesen";
        txtAreaESP3_rx.Value = "Geloggte Daten werden gelesen";
        
        %First reading
        dataFile = './Output_Files/data_log_1.csv';

        readLogData(esp1, dataFile);
        readLogData(esp2, dataFile);
        readLogData(esp3, dataFile);
        
        %Second reading
        dataFile = './Output_Files/data_log_2.csv';

        readLogData(esp1, dataFile);
        readLogData(esp2, dataFile);
        readLogData(esp3, dataFile);

        %Comparing
        ident = compare_csv('./Output_Files/data_log_1.csv', './Output_Files/data_log_2.csv');

        if ident == 1
            txtAreaLog.Value = 'Erfolgreich';
            txtAreaLog.BackgroundColor = [0.8, 1, 0.8];

        elseif ident == 0
            txtAreaLog.Value = 'Fehler - Weiterer Versuch';
            txtAreaLog.BackgroundColor = [1, 0.8, 0.8];
            %First reading
            dataFile = './Output_Files/data_log_1.csv';

            readLogData(esp1, dataFile);
            readLogData(esp2, dataFile);
            readLogData(esp3, dataFile);
            
            %Second reading
            dataFile = './Output_Files/data_log_2.csv';
    
            readLogData(esp1, dataFile);
            readLogData(esp2, dataFile);
            readLogData(esp3, dataFile);
        end



    elseif parity == 0
        txtAreaESP1_tx.Value = 'Keine Verbindung';
        txtAreaESP2_tx.Value = 'Keine Verbindung';
        txtAreaESP3_tx.Value = 'Keine Verbindung';
        
        txtAreaESP1_rx.Value = 'Keine Verbindung';
        txtAreaESP2_rx.Value = 'Keine Verbindung';
        txtAreaESP3_rx.Value = 'Keine Verbindung';
    end
end

%##############################################################################
function readLogData(esp, dataFile)

while esp.BytesAvailable > 0
        data_esp = fgets(esp);
        disp('Geloggte Daten werden gelesen...');

        if contains(data_esp, 'ld')
            "Geloggte Daten werden gelesen";

            % Assuming the format is 'ld [pos] [id] [timestamp]'
            dataArray = strsplit(data_esp, ' ');
            
            if numel(dataArray) >= 3
                pos = dataArray{1}(3);
                id = dataArray{2};
                timestamp = dataArray{3};

                if contains(id, '1') && length(id)<3
                    id = 'Lichtschranke';
                elseif contains(id, '0') && length(id)<3
                    id = 'ID nicht erkannt';
                end
               
                headers = {'Station', 'ID', 'Timestamp'};
     
                newData = table({pos}, {id}, {timestamp}, 'VariableNames', headers);
                
                    if exist(dataFile, 'file') == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, dataFile, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, dataFile, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                    drawnow;
            else
                disp('Nicht genügend Elemente in gesendet');
            end
        else
            disp('Keine Antwort');
        end
        drawnow;
end
end

function ident = compare_csv(file1, file2)
    % Read data from the first CSV file
    data1 = readtable(file1);

    % Read data from the second CSV file
    data2 = readtable(file2);

    % Compare row by row
    [rows, cols] = size(data1);

    for i = 1:rows
        % Adjust the conditions for the comparison as needed
        if isequal(data1{i, :}, data2{i, :})
            disp('Row %d is identical.\n', i);
            ident = true;
        else
            disp('Row %d is different.\n', i);
            ident = false;
            break;
        end
        drawnow;
    end
end