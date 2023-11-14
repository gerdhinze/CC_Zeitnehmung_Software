function connect2ESP1(comPort)
    global esp1;
    esp1 = serial(comPort, 'BAUD', 115200);
    fopen(esp1);
    disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
end
