function connect2ESP2(comPort)
    global esp2;
    global parity2;
    esp2 = serial(comPort, 'BAUD', 115200);
    fopen(esp2);
    parity2 = 1;
end
