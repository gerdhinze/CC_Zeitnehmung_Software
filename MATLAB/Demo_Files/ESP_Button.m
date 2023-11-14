% GUI erstellen
fig = uifigure('Name', 'ESP8266 Verbindung');
txtPort = uieditfield(fig, 'text', 'Position', [10 50 100 22], 'Value', 'COM1');
btnConnect = uibutton(fig, 'push', 'Text', 'Connect', 'Position', [120 50 70 22], 'ButtonPushedFcn', @(btnConnect, event) connectButtonCallback(txtPort.Value));

% Callback-Funktion für den Connect-Knopf
function connectButtonCallback(port)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        portNumber = port;
        contrButton.connect2ESP1(portNumber);
        disp('Verbindung erfolgreich hergestellt.');
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
 end