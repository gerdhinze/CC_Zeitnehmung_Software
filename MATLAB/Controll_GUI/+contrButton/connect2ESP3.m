function connect2ESP3(comPort)
    global esp3;
    global parity3;
    esp3 = serial(comPort, 'BAUD', 115200);
    fopen(esp3);
    parity3 = 1;
end
