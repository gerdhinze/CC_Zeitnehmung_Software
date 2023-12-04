function read_log(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)

    global esp1 esp2 esp3;
    global parity1 parity2 parity3;

    save('datalog.csv');
    
    if parity1 == 1 && parity2 == 1 && parity3 == 1
        command = 'read_log';

        txtAreaESP1_tx.Value = command;
        txtAreaESP2_tx.Value = command;
        txtAreaESP3_tx.Value = command;

        fprintf(esp1, command);
        fprintf(esp2, command);
        fprintf(esp3, command);

        txtAreaESP1_rx.Value = readLogData(esp3);
        txtAreaESP2_rx.Value = readLogData(esp3);
        txtAreaESP3_rx.Value = readLogData(esp3);

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
function [receive] = readLogData(esp)

receive = '';
while esp.BytesAvailable > 0
        data_esp = fgets(esp);
        disp(data_esp);

        if contains(data_esp, 'rld')
            % Assuming the format is 'ld [pos] [id] [timestamp]'
            dataArray = strsplit(data_esp, ' ');
            
            if numel(dataArray) >= 3
                pos = dataArray{1}(3);
                id = dataArray{2};
                timestamp = dataArray{3};

               disp(['Pos: ' pos ', ID: ' id ', Timestamp: ' timestamp]);
               receive = "read log";

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
                receive = ('Nicht genügend Elemente in gesendet');
            end
        else
            receive = ('Keine Antwort');
        end
end
end