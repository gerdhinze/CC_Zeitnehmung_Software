function time_esp = get_time(esp, parity)
    % Initialize output variable
    time_esp = [];

    if parity == 1
        fprintf(esp, 'get_time');
        pause(0.5);
        while esp.BytesAvailable > 0
            time_esp = fgets(esp);
        end
    else
        % Handle the case where parity is not equal to 1
        time_esp = '00:00:00';
    end
end

