function[command, receive] = delete_log(esp, parity)
    command = '';
    receive = '';
    
    if parity
        command = 'delete_log';
        fprintf(esp, command);
        pause(0.5);

        while esp.BytesAvailable > 0
            data_esp = fgets(esp);
            disp('Geloggte Daten vom ESP wurden gelöscht');

            if contains(data_esp, 'del')
                receive = 'Delete Log';
            else
                receive = 'Keine Antwort';
            end
        end
       
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Antwort';
    end
end