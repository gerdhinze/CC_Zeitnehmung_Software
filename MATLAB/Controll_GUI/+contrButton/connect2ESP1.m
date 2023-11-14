function connect2ESP1(comPort)
    global esp1;
    global parity1;
    esp1 = serial(comPort, 'BAUD', 115200);
    fopen(esp1);
    parity1 = 1;
end
