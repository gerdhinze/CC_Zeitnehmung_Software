function get_time()

    if isvalid(esp1)
    fprintf(esp1, 'get_time');
    pause(0.5);
    while ESP1.NumBytesAvailable > 0
        time_esp1 = fscanf(esp1, '%s');
    end
    elseif isvalid(esp2)
    fprintf(esp2, 'get_time');
    pause(0.5);
    while ESP2.NumBytesAvailable > 0
        time_esp2 = fscanf(esp2, '%s');
    end
    elseif isvalid(esp3)
    fprintf(esp3, 'get_time');
    pause(0.5);
    while ESP3.NumBytesAvailable > 0
        time_esp3 = fscanf(esp3, '%s');
    end
    end
end

