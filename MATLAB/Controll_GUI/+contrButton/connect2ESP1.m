function connect2ESP1()
    comPort = get(Port1, 'string');
    try
        % Versuche, eine Verbindung zum angegebenen COM-Port herzustellen
        esp1 = serialport(comPort, 115200);
        fopen(esp1);
        disp(['Verbindung zum COM-Port ' comPort ' hergestellt.']);
    catch
        % Wenn ein Fehler auftritt, zeige eine Fehlermeldung an
        disp(['Fehler beim Herstellen der Verbindung zum COM-Port ' comPort '.']);
    end
end
