function connect2ESP3(comPort)
    try
        esp3 = serial(comPort, 'BAUD', 115200);
        fopen(esp3);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        errordlg(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort], 'Fehler');
    end
end
