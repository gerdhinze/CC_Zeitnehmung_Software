function  start(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, dataFile)
    
    global esp1 esp2 esp3;
    global parity1 parity2 parity3;
    global stop_value;

    if parity1 && parity2 && parity3
        command_esp1 = 'start';
        command_esp2 = 'start';
        command_esp3 = 'start';

        txtAreaESP1_tx.Value = 'start';
        txtAreaESP2_tx.Value = 'start';
        txtAreaESP3_tx.Value = 'start';

        txtAreaESP1_rx.Value = 'Erkenne Zeiten';
        txtAreaESP2_rx.Value = 'Erkenne Zeiten';
        txtAreaESP3_rx.Value = 'Erkenne Zeiten';

        fprintf(esp1, command_esp1);
        fprintf(esp2, command_esp2);
        fprintf(esp3, command_esp3);

        % Daten aus der CSV-Datei lesen
        data = readtable('./Output_Files/ID_file_cleared.csv');
        
        % Die vorletzte und letzte Zeile auswählen
        prelast_row = data(end-1, :);
        last_row = data(end, :);
        
        % Die ID aus der zweiten Spalte der vorletzten und letzten Zeile extrahieren
        id_A = (prelast_row.ID);
        id_B = (last_row.ID);

        disp(id_A);
        disp(id_B);

        while stop_value == 0
            % Process data from esp1
            txtAreaESP1_rx.Value = processEspData(esp1, dataFile);

            % Process data from esp2
            txtAreaESP2_rx.Value = processEspData(esp2, dataFile);

            % Process data from esp3
            txtAreaESP3_rx.Value = processEspData(esp3, dataFile);
            drawnow;
              
            %Algorithmus function
            isfinish = algorithmus.newEntry(id_A, id_B, 1, dataFile);
            
            %Send to GUI
            algorithmus.sendGUI(isfinish);
        end

    else
        txtAreaESP1_rx.Value = 'Bitte alle Stationen verbinden';
        txtAreaESP2_rx.Value = 'Bitte alle Stationen verbinden';
        txtAreaESP3_rx.Value = 'Bitte alle Stationen verbinden';
    end
end

%##############################################################################
function [receive] = processEspData(esp, dataFile)
    receive = '';
    while esp.BytesAvailable > 0
        data_esp = fgets(esp);
        disp(data_esp);

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

               disp(['Pos: ' pos ', ID: ' id ', Timestamp: ' timestamp]);

               receive = ('Aktualisiert...');

                headers = {'Station', 'ID', 'Timestamp'};
     
                newData = table({pos}, {id}, {timestamp}, 'VariableNames', headers);
                
                    if exist(dataFile, 'file') == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, dataFile, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, dataFile, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
            else
                disp('Nicht genügend Elemente in gesendet');
            end
        else
            disp('Keine Antwort');
        end
        drawnow;
    end
end

