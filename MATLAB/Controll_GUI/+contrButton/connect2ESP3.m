function connect2ESP3(comPort)
    global esp3;
    esp3 = serial(comPort, 'BAUD', 115200);
    fopen(esp3);
    disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
end
