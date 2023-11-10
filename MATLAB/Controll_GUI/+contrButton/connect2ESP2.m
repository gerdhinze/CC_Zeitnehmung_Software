function connect2ESP2()
    comPort = get(Port2, 'string');
    try
        % Versuche, eine Verbindung zum angegebenen COM-Port herzustellen
        esp2 = serialport(comPort, 115200);
        fopen(esp2);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        % Wenn ein Fehler auftritt, zeige eine Fehlermeldung an
        disp(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort '.']);
    end
end
