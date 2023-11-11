% GUI erstellen
controll_gui = uifigure('Name', 'Controll-GUI');
controll_gui.ToolBar = 'none';
controll_gui.MenuBar = 'none';
controll_gui.Color = 'white';
controll_gui.Position = [50,50,750,600];

%ESP Connection
%Which Comports are available
% Create a uitextarea
txtAreaPorts = uitextarea(controll_gui, 'Position', [50 400 100 100], 'Editable', false);
% Get the list of available serial ports
availablePorts = serialportlist("available");
% Convert the cell array of port names to a string
portsString = sprintf('Available Ports:\n%s\n', strjoin(availablePorts, '\n'));
txtAreaPorts.Value = portsString;

txtPort1_Label = uilabel(controll_gui, 'Position', [50,560,130,40], 'Text', 'Station 1:','FontSize',20);
txtPort1 = uieditfield(controll_gui, 'text', 'Position', [50 520 100 40], 'Value', 'COMX');
btnConnect1 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [160 520 100 40], 'ButtonPushedFcn', @(btnConnect, event) connectButton1Callback(txtPort1));

txtPort2_Label = uilabel(controll_gui, 'Position', [280 560 130 40], 'Text', 'Station 2:', 'FontSize',20);
txtPort2 = uieditfield(controll_gui, 'text', 'Position', [280 520 100 40], 'Value', 'COMX');
btnConnect2 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [390 520 100 40], 'ButtonPushedFcn', @(btnConnect, event) connectButton2Callback(txtPort2));

txtPort3_Label = uilabel(controll_gui, 'Position', [510 560 130 40], 'Text', 'Station 3:', 'FontSize',20);
txtPort3 = uieditfield(controll_gui, 'text', 'Position', [510 520 100 40], 'Value', 'COMX');
btnConnect3 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [620 520 100 40], 'ButtonPushedFcn', @(btnConnect, event) connectButton3Callback(txtPort3));

% Button to synchronize time
btnSync = uibutton(controll_gui, 'push', 'Text', 'Sync-Time', 'Position', [50 350 70 40], 'ButtonPushedFcn', @(btnSync, event) syncButtonCallback());

% Button to stop
btnStop = uibutton(controll_gui, 'push', 'Text', 'Stop', 'Position', [560 20 70 40], 'BackgroundColor', 'red', 'ButtonPushedFcn', @(btnStop, event) stopButtonCallback());

% Button to disconnect all
btnDisconnectAll = uibutton(controll_gui, 'push', 'Text', 'Disconnect All', 'Position', [160 460 100 40], 'ButtonPushedFcn', @(btnDisconnectAll, event) disconnectAllButtonCallback());

%##########################################################################
%       CALLBACK - Functions
%##########################################################################
% Callback-functions for the connect buttons
function connectButton1Callback(txtPort1)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port1Number = txtPort1.Value;
        contrButton.connect2ESP1(port1Number);
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton2Callback(txtPort2)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port2Number = txtPort2.Value;
        contrButton.connect2ESP1(port2Number);
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton3Callback(txtPort3)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port3Number = txtPort3.Value;
        contrButton.connect2ESP1(port3Number);
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

% Callback function for the Sync button
function syncButtonCallback()
    try
        % Call the function to synchronize time
        contrButton.sync_time();
        disp('Zeit erfolgreich synchronisiert.');
    catch
        % Handle errors if the synchronization fails
        errordlg('Fehler beim Synchronisieren der Zeit.', 'Fehler');
    end
end

function stopButtonCallback()
    try
        contrButton.stop();
        disp('Vorgang gestoppt.');
    catch
        errordlg('Fehler beim Stoppen.', 'Fehler');
    end
end

function disconnectAllButtonCallback()
    try
        contrButton.disconnect_esp_all();
        disp('Alle Verbindungen getrennt.');
    catch
        errordlg('Fehler beim Trennen aller Verbindungen.', 'Fehler');
    end
end
