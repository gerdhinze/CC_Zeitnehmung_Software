function connect2ESP3(comPort)
    esp3 = serial(comPort, 'BAUD', 115200);
    fopen(esp3);
    disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
end
