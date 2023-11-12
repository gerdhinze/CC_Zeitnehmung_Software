% GUI erstellen
controll_gui = uifigure('Name', 'Controll-GUI');
controll_gui.ToolBar = 'none';
controll_gui.MenuBar = 'none';
controll_gui.Color = 'white';
controll_gui.Position = [50,50,750,600];

%ESP Connection
%Available comports
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
btnSync = uibutton(controll_gui, 'push', 'Text', 'Sync-Time', 'Position', [50 340 100 40], 'ButtonPushedFcn', @(btnSync, event) syncButtonCallback());

% Button to stop
btnStop = uibutton(controll_gui, 'push', 'Text', 'Stop', 'Position', [620 50 100 40], 'BackgroundColor', 'red', 'ButtonPushedFcn', @(btnStop, event) stopButtonCallback());

% Button to disconnect all
btnDisconnectAll = uibutton(controll_gui, 'push', 'Text', 'Disconnect All', 'Position', [160 460 100 40], 'ButtonPushedFcn', @(btnDisconnectAll, event) disconnectAllButtonCallback());

% Button to search for ports
btnSearchPorts = uibutton(controll_gui, 'push', 'Text', 'Search Ports', 'Position', [160 400 100 40], 'BackgroundColor', 'cyan', 'ButtonPushedFcn', @(btnSearchPorts, event) searchPortsCallback());

%textboxes for esp times
txtArea_time_esp1 = uitextarea(controll_gui, 'Position', [50 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp1_Label = uilabel(controll_gui, 'Position', [160,285,130,40], 'Text', '@ Station 1','FontSize',15);
txtArea_time_esp2 = uitextarea(controll_gui, 'Position', [280 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp2_Label = uilabel(controll_gui, 'Position', [390,285,130,40], 'Text', '@ Station 2','FontSize',15);
txtArea_time_esp3 = uitextarea(controll_gui, 'Position', [510 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp3_Label = uilabel(controll_gui, 'Position', [620,285,130,40], 'Text', '@ Station 3','FontSize',15);

%dropdownmenue for the teamname
serialPortDropdown = uidropdown(controll_gui, 'Position', [50 230 100 40], 'Items', {'Team1', 'Team2', 'Team3', 'Team4'}, 'ValueChangedFcn', @(dropdown, event) selectedTeamCallback(dropdown));

% Button for setting the IDs
btnSetID = uibutton(controll_gui, 'push', 'Text', 'Set ID', 'Position', [160 230 100 40], 'BackgroundColor', 'yellow', 'ButtonPushedFcn', @(btnSetID, event) setIDButtonCallback(serialPortDropdown));

%"Ready" button
btnReady = uibutton(controll_gui, 'push', 'Text', 'Ready', 'Position', [160 170 100 40], 'BackgroundColor', [1, 0.5, 0],'ButtonPushedFcn', @(btnReady, event) readyButtonCallback());

%"Start" button
btnStart = uibutton(controll_gui, 'push', 'Text', 'Start', 'Position', [160 110 100 40], 'BackgroundColor', 'green', 'ButtonPushedFcn', @(btnStart, event) startButtonCallback());

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

% Callback function for the "Search Ports" button
function searchPortsCallback()
    try
        % Get the list of available serial ports
        availablePorts = serialportlist("available");
        
        % Convert the cell array of port names to a string
        portsString = sprintf('Available Ports:\n%s\n', strjoin(availablePorts, '\n'));
        
        % Display the ports in the uitextarea
        txtAreaPorts.Value = portsString;
        
        disp('Serial ports list updated.');
    catch
        errordlg('Error updating the serial ports list.', 'Error');
    end
end

% Callback function for the  drop-down menu
function selectedTeamCallback(dropdown)
    selectedTeam = dropdown.Value;
    disp(['Ausgewähltes Team: ' selectedTeam]);
end

% Callback function for the "Set ID" button
function setIDButtonCallback(dropdown)
    try
        % Get the selected team from the dropdown menu
        selectedTeam = dropdown.Value;
        
        % Call the function to set the ID (replace with your actual set_ID logic)
        contrButton.set_ID(selectedTeam);
        disp(['ID successfully set for Team: ' selectedTeam]);
    catch
        errordlg('Error setting ID.', 'Error');
    end
end

% Callback function for the "Ready" button
function readyButtonCallback()
    try
        % Call the function to perform actions when the system is ready
        contrButton.isready();
        disp('System is ready.');
    catch
        errordlg('Error while preparing the system.', 'Error');
    end
end

% Callback function for the "Start" button
function startButtonCallback()
    try
        contrButton.start();
        disp('Start');
    catch
        errordlg('Error while preparing the system.', 'Error');
    end
end
