function connect2ESP2(comPort)
    try
        esp2 = serial(comPort, 'BAUD', 115200);
        fopen(esp2);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        errordlg(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort], 'Fehler');
    end
end
