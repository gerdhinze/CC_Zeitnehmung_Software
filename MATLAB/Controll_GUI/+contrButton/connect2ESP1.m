function connect2ESP1(comPort)
    try
        esp1 = serial(comPort, 'BAUD', 115200);
        fopen(esp1);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        errordlg(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort], 'Fehler');
    end
end
