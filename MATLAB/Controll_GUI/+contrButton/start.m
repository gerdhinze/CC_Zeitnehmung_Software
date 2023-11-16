function start(esp, parity, dataFile)

    save(dataFile);

    if parity == 1
        fprintf(esp, 'start');
        pause(0.5);

        while esp.BytesAvailable > 0
            data_esp = fgets(esp);
            % Split the string into its components
            splitstring = strsplit(data_esp, ' ');

            data.station = str2double(splitstring{1});
            data.id = str2double(splitstring{2});
            data.timestamp = str2double(splitstring{3});
        end

        % Save data to the specified file
        load(dataFile);
        save(dataFile, 'data');
    end
end
