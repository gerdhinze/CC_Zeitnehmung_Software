function[message] = delete_log(esp, parity)
    
    if parity == 1
        data = fscanf(esp, '%s');
        if isempty(data)
            message = 'Data log ist leer';
        elseif ~isempty(data)
        fprintf(esp, 'delete');
        message = 'Geloggte Daten wurden gelöscht';
        end
    end
end