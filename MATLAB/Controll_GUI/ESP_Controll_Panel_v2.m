clear;

%Gloabal variables
global esp1 esp2 esp3;
global parity1 parity2 parity3;

% GUI erstellen
controll_gui = uifigure('Name', 'Controll-GUI');
controll_gui.ToolBar = 'none';
controll_gui.MenuBar = 'none';
controll_gui.Color = 'white';
controll_gui.Position = [50,50,750,600];

%Command window
% Create a uitextarea
txtCommand_Label = uilabel(controll_gui, 'Position', [280,450,200,40], 'Text', 'Controll window:','FontSize',20);
txtAreaCommand = uitextarea(controll_gui, 'Position', [280 340 330 120], 'Editable', false);

%Available comports
% Create a uitextarea
txtAreaPorts = uitextarea(controll_gui, 'Position', [50 400 100 100], 'Editable', false);
% Get the list of available serial ports
availablePorts = serialportlist("available");
% Convert the cell array of port names to a string
portsString = sprintf('Verfügb. Ports:\n%s\n', strjoin(availablePorts, '\n'));
txtAreaPorts.Value = portsString;

%%ESP Connection
txtPort1_Label = uilabel(controll_gui, 'Position', [50,560,130,40], 'Text', 'Station 1:','FontSize',20);
txtPort1 = uieditfield(controll_gui, 'text', 'Position', [50 510 100 50], 'Value', 'COMX');
btnConnect1 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [160 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton1Callback(txtPort1, txtAreaCommand));
btnDisConnect1 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [160 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton1Callback(txtPort1, txtAreaCommand));

txtPort2_Label = uilabel(controll_gui, 'Position', [280 560 130 40], 'Text', 'Station 2:', 'FontSize',20);
txtPort2 = uieditfield(controll_gui, 'text', 'Position', [280 510 100 50], 'Value', 'COMX');
btnConnect2 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [390 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton2Callback(txtPort2, txtAreaCommand));
btnDisConnect2 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [390 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton2Callback(txtPort2, txtAreaCommand));

txtPort3_Label = uilabel(controll_gui, 'Position', [510 560 130 40], 'Text', 'Station 3:', 'FontSize',20);
txtPort3 = uieditfield(controll_gui, 'text', 'Position', [510 510 100 50], 'Value', 'COMX');
btnConnect3 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [620 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton3Callback(txtPort3, txtAreaCommand));
btnDisConnect3 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [620 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton3Callback(txtPort3, txtAreaCommand));

%textbox for realtime times
txtArea_realtime = uitextarea(controll_gui, 'Position', [50 340 100 40], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
%textboxes for esp times
txtArea_time_esp1 = uitextarea(controll_gui, 'Position', [50 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp1_Label = uilabel(controll_gui, 'Position', [160,285,130,40], 'Text', '@ Station 1','FontSize',15);
txtArea_time_esp2 = uitextarea(controll_gui, 'Position', [280 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp2_Label = uilabel(controll_gui, 'Position', [390,285,130,40], 'Text', '@ Station 2','FontSize',15);
txtArea_time_esp3 = uitextarea(controll_gui, 'Position', [510 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp3_Label = uilabel(controll_gui, 'Position', [620,285,130,40], 'Text', '@ Station 3','FontSize',15);

% Button to synchronize time
btnSync = uibutton(controll_gui, 'push', 'Text', 'Sync-Time', 'Position', [160 340 100 40], 'ButtonPushedFcn', @(btnSync, event) syncButtonCallback(txtArea_realtime, txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3, txtAreaCommand));

% Button to stop
btnStop = uibutton(controll_gui, 'push', 'Text', 'Stop', 'Position', [620 50 100 40], 'BackgroundColor', 'red', 'ButtonPushedFcn', @(btnStop, event) stopButtonCallback(txtAreaCommand));

% Button to disconnect all
btnDisconnectAll = uibutton(controll_gui, 'push', 'Text', 'Disconnect All', 'Position', [160 460 100 40], 'ButtonPushedFcn', @(btnDisconnectAll, event) disconnectAllButtonCallback(txtAreaCommand));

% Button to search for ports
btnSearchPorts = uibutton(controll_gui, 'push', 'Text', 'Search Ports', 'Position', [160 400 100 40], 'BackgroundColor', 'cyan', 'ButtonPushedFcn', @(btnSearchPorts, event) searchPortsCallback(txtAreaPorts, txtAreaCommand));

%dropdownmenue for the teamname
CCTM = readtable('CCTM2023.csv'); %Crazy Car Teilnehmer
serialPortDropdown = uidropdown(controll_gui, 'Position', [50 230 100 40], 'Items', CCTM.Teamname, 'ValueChangedFcn', @(dropdown, event) selectedTeamCallback(dropdown, txtAreaCommand)); %Änderung Philipp

% Button for setting the IDs
btnSetID = uibutton(controll_gui, 'push', 'Text', 'Set ID', 'Position', [160 230 100 40], 'BackgroundColor', [1, 0.5, 0], 'ButtonPushedFcn', @(btnSetID, event) setIDButtonCallback(serialPortDropdown, txtAreaCommand));

%"Ready" button
btnReady = uibutton(controll_gui, 'push', 'Text', 'Ready', 'Position', [160 170 100 40], 'BackgroundColor', 'yellow','ButtonPushedFcn', @(btnReady, event) readyButtonCallback());

%"Start" button
btnStart = uibutton(controll_gui, 'push', 'Text', 'Start', 'Position', [160 110 100 40], 'BackgroundColor', 'green', 'ButtonPushedFcn', @(btnStart, event) startButtonCallback());

%"read_log" button
btnRead_log = uibutton(controll_gui, 'push', 'Text', 'read logged data', 'Position', [160 110 100 40], 'ButtonPushedFcn', @(btnRead_log, event) read_logButtonCallback());
%##########################################################################
%       CALLBACK - Functions
%##########################################################################

% Callback-functions for the connect buttons
function connectButton1Callback(txtPort1, txtAreaCommand)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port1Number = txtPort1.Value;
        contrButton.connect2ESP1(port1Number);
        disp(['Verbindung zum COM-Port ' port1Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton2Callback(txtPort2, txtAreaCommand)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port2Number = txtPort2.Value;
        contrButton.connect2ESP2(port2Number);
        disp(['Verbindung zum COM-Port ' port2Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton3Callback(txtPort3, txtAreaCommand)
    try
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port3Number = txtPort3.Value;
        contrButton.connect2ESP3(port3Number);
        disp(['Verbindung zum COM-Port ' port3Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

%Callback function for the disconnect button
function disconnectButton1Callback(txtPort1, txtAreaCommand)
    try
        port1Number = txtPort1.Value;
        contrButton.disconnect2ESP1(port1Number);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' abgebrochen.'];
       
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function disconnectButton2Callback(txtPort2, txtAreaCommand)
    try
        port2Number = txtPort2.Value;
        contrButton.disconnect2ESP2(port2Number);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' abgebrochen.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function disconnectButton3Callback(txtPort3, txtAreaCommand)
    try
        port3Number = txtPort3.Value;
        contrButton.disconnect2ESP3(port3Number);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' abgebrochen.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

% Callback function for the Sync button
function syncButtonCallback(txtArea_realtime, txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3, txtAreaCommand)
    try
        % Call the function to synchronize time
        [realtime, realtime_esp1, realtime_esp2, realtime_esp3]= contrButton.sync_time();
        txtArea_realtime.Value = realtime;
        txtArea_time_esp1.Value = realtime_esp1;
        txtArea_time_esp2.Value = realtime_esp2;
        txtArea_time_esp3.Value = realtime_esp3;
        
        txtAreaCommand.Value = 'Zeit erfolgreich aktualisiert.';
        disp('Zeit erfolgreich aktualisiert');
    catch
         % Handle errors if the synchronization fails
         errordlg('Fehler beim Synchronisieren der Zeit.', 'Error');
    end
end

%Callback function for the stop button
function stopButtonCallback(txtAreaCommand)
    try
        contrButton.stop();
        txtAreaCommand.Value = 'Vorgang gestoppt.';
        disp('Vorgang gestoppt.');
    catch
        errordlg('Fehler beim Stoppen.', 'Fehler');
    end
end

% Callback function for the "disconnect" button
function disconnectAllButtonCallback(txtAreaCommand)
    try
        contrButton.disconnect_esp_all();
        disp('Alle Verbindungen getrennt.');
        txtAreaCommand.Value = 'Alle Verbindungen getrennt.';
    catch
    errordlg('Fehler beim Trennen aller Verbindungen.', 'Fehler');
    end
end

% Callback function for the "Search Ports" button
function searchPortsCallback(txtAreaPorts, txtAreaCommand)
    try
        % Get the list of available serial ports
        availablePorts = serialportlist("available");
        
        % Convert the cell array of port names to a string
        portsString = sprintf('Verfügb. Ports:\n%s\n', strjoin(availablePorts, '\n'));
        
        % Display the ports in the uitextarea
        txtAreaPorts.Value = portsString;
        txtAreaCommand.Value = 'Serial ports aktualisiert.';
        disp('Serial ports aktualisiert.');
    catch
        errordlg('Fehler beim Aktualisieren der Serial Ports.', 'Error');
    end
end

% Callback function for the  drop-down menu
function selectedTeamCallback(dropdown, txtAreaCommand)
    selectedTeam = dropdown.Value;
    txtAreaCommand.Value = ['Ausgewähltes Team: ' selectedTeam];
    disp(['Ausgewähltes Team: ' selectedTeam]);
end

% Callback function for the "Set ID" button
function setIDButtonCallback(dropdown, txtAreaCommand)
    try
        % Get the selected team from the dropdown menu
        selectedTeam = dropdown.Value;
        
        % Call the function to set the ID (replace with your actual set_ID logic)
        contrButton.set_ID(selectedTeam);
        txtAreaCommand.Value = ['ID erfolgreich gesetzt for Team: ' selectedTeam];
        disp(['ID erfolgreich gesetzt for Team: ' selectedTeam]);
    catch
         errordlg('Fehler beim ID-Setting.', 'Error');
    end
end

% Callback function for the "Ready" button
function readyButtonCallback()
    try
        % Call the function to perform actions when the system is ready
        contrButton.isready();
        disp('System ist bereit.');
    catch
        errordlg('Fehler beim Vorbereiten des Systems.', 'Error');
    end
end

% Callback function for the "Start" button
function startButtonCallback()
    try
        contrButton.start();
        disp('Start');
    catch
        errordlg('Fehler beim Vorbereiten des Systems.', 'Error');
    end
end

%Callback function for the "read_log" button
function read_logButtonCallback()
    try

    catch

    end
end
