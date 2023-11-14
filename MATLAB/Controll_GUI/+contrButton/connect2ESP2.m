function connect2ESP2(comPort)
    global esp2;
    esp2 = serial(comPort, 'BAUD', 115200);
    fopen(esp2);
    disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
end
