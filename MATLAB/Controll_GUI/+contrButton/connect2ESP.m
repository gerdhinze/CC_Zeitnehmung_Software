function [parity, esp] = connect2ESP(comPort)
    esp = serial(comPort, 'BAUD', 115200);
    fopen(esp);
    parity = 1;
end