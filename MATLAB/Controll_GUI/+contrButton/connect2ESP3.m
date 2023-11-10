function connect2ESP3()
    comPort = get(Port3, 'string');
    try
        % Versuche, eine Verbindung zum angegebenen COM-Port herzustellen
        esp3 = serialport(comPort, 115200);
        fopen(esp3);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        % Wenn ein Fehler auftritt, zeige eine Fehlermeldung an
        disp(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort '.']);
    end
end
