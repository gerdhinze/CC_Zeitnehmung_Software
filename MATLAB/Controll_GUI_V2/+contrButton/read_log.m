function read_log(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, dataFile)

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
              
        readLogData(esp1, dataFile);
        readLogData(esp2, dataFile);
        readLogData(esp3, dataFile);
        
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
