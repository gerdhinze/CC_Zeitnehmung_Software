function isready(esp, parity)

    if parity == 1
        fprintf(esp, 'ready');
        pause(0.5);
        load('id_file.mat');
        dataString = sprintf('%s\n', data{:});
        fprintf(esp, dataString);
    end
end