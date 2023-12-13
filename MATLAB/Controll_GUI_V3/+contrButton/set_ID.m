% function set_ID(selectedTeam, esp, parity, txtAreaESP1_tx, txtAreaESP1_rx)
% 
%     string_id = '';
%     id = '';
%     scan = 0;
%     station = 'Station 1';
%     file = './Output_Files/ID_file.csv';
% 
%     if parity == 1
%         command = 'set_ID';
%         txtAreaESP1_tx.Value = command;
% 
%         % Send the set_ID command to esp
%         fprintf(esp, command);
% 
%         % Wait for and process the response from esp
%         while esp.BytesAvailable > 0
%             string = fgets(esp);
%             display(string);
% 
%             if contains(string, 'id')
%                 txtAreaESP1_rx.Value = 'Ready to scan';
%                 scan = 1;
%             else
%                 txtAreaESP1_rx.Value = 'Bitte Wiederholen';
%                 continue;
%             end
%         end
% 
%         while scan
%             while esp.BytesAvailable > 0
%                 string_id = fgets(esp);
%                 %if  ~isempty(string_id)
%                     if startsWith(string_id, 'id') && ~contains(string_id, 'Ready')
%                         id = extractAfter(string_id, 2);
%                         txtAreaESP1_rx.Value = id;
%                         display(id);
%                     end
%                     scan = 0;
%                 % else
%                 %     scan = 1; 
%                 % end
%             end
%         end
% 
%         % save(file);
% 
%         % data_csv = {'Station Nr.', 'Teamname', 'ID'; 'Station 1', selectedTeam, id};
%         % 
%         % % Write the combined data back to the file
%         % writecell(data_csv, file);
% 
%        headers = {'Station', 'ID', 'Teamname'};
% 
%         newData = table({station}, {id}, {selectedTeam}, 'VariableNames', headers);
% 
%         if exist(file, 'file') == 0
%             % File doesn't exist, create it with headers
%             writetable(newData, file, 'WriteMode', 'overwrite');
%         else
%             % File exists, append data
%             writetable(newData, file, 'WriteMode', 'append', 'WriteVariableNames', false);
%         end
% 
%     elseif parity == 0
%         txtAreaESP1_tx.Value = 'Keine Verbindung';
%         txtAreaESP1_rx.Value = 'Keine Verbindung';
%     end
% end




function set_ID(selectedTeam, esp, parity, txtAreaESP1_tx, txtAreaESP1_rx)

    string_id = '';
    id = '';
    scan = 0;
    station = 'Station 1';
    file = './Output_Files/ID_file.csv';

    if parity == 1
        command = 'set_ID';
        txtAreaESP1_tx.Value = command;

        % Send the set_ID command to esp
        fprintf(esp, command);

        % Wait for and process the response from esp
        while esp.BytesAvailable > 0
            string = fgets(esp);
            display(string);

            if contains(string, 'id')
                if length(string) < 12
                    id = extractAfter(string_id, 2);
                    txtAreaESP1_rx.Value = id;
                    display(id);

                    headers = {'Station', 'ID', 'Teamname'};

                    newData = table({station}, {id}, {selectedTeam}, 'VariableNames', headers);
            
                    if exist(file, 'file') == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, file, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, file, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                else
                txtAreaESP1_rx.Value = 'Ready to scan';
                while esp.BytesAvailable > 0
                string_id = fgets(esp);

                    if startsWith(string_id, 'id') && ~contains(string_id, 'Ready')
                        id = extractAfter(string_id, 2);
                        txtAreaESP1_rx.Value = id;
                        display(id);
                    end
                    headers = {'Station', 'ID', 'Teamname'};

                    newData = table({station}, {id}, {selectedTeam}, 'VariableNames', headers);
            
                    if exist(file, 'file') == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, file, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, file, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end
                end
            else
                txtAreaESP1_rx.Value = 'Bitte Wiederholen';
                continue;
            end
        end

    elseif parity == 0
        txtAreaESP1_tx.Value = 'Keine Verbindung';
        txtAreaESP1_rx.Value = 'Keine Verbindung';
    end
end

