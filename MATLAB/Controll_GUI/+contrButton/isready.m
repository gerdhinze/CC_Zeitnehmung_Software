function isready()
    
    if isvalid(esp1)
    fprintf(esp1, 'ready');
    pause(0.5);
    load('id_file.mat');
    data = id_file.mat;
    dataString = sprintf('%s\n', data{:});
    fprintf(esp1, dataString);
    elseif isvalid(esp2)
    fprintf(esp2, 'ready');
    pause(0.5);
    load('id_file.mat');
    data = id_file.mat;
    dataString = sprintf('%s\n', data{:});
    fprintf(esp2, dataString);
    elseif isvalid(esp3)
    fprintf(esp3, 'ready');
    pause(0.5);
    load('id_file.mat');
    data = id_file.mat;
    dataString = sprintf('%s\n', data{:});
    fprintf(esp3, dataString);
    end
end
