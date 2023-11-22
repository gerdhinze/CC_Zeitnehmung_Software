function[command, receive] = delete_log(esp, parity)
    
    command = '';
    receive = '';

    if parity == 1
        command = 'delete';
        fprintf(esp, command);
        pause(0.5);

        while esp.BytesAvailable > 0
            data_esp = fgets(esp);

            if startsWith(data_esp, 'dld')
                receive = data_esp;
            else
                receive = 'Keine Antwort';
            end
        end
    elseif parity == 0
        command = 'Keine Verbindung';
        receive = 'Keine Antwort';
    end
end