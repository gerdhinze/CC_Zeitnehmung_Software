clear;

%Gloabal variables
global esp1 esp2 esp3;
global parity1 parity2 parity3;
global timer_bit;

% GUI erstellen
controll_gui = uifigure('Name', 'Controll-GUI');
controll_gui.ToolBar = 'none';
controll_gui.MenuBar = 'none';
controll_gui.Color = 'white';
controll_gui.Position = [50,50,750,600];

%Command window
% Create a uitextarea
txtCommand_Label = uilabel(controll_gui, 'Position', [280,450,200,40], 'Text', 'Commandline:','FontSize',20);
txtAreaCommand = uitextarea(controll_gui, 'Position', [280 340 440 120], 'Editable', false, 'FontSize', 15);

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
txtPort1 = uieditfield(controll_gui, 'text', 'Position', [50 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect1 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [160 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton1Callback(txtPort1, txtAreaCommand));
btnDisConnect1 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [160 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton1Callback(txtPort1, txtAreaCommand));

txtPort2_Label = uilabel(controll_gui, 'Position', [280 560 130 40], 'Text', 'Station 2:', 'FontSize',20);
txtPort2 = uieditfield(controll_gui, 'text', 'Position', [280 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect2 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [390 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton2Callback(txtPort2, txtAreaCommand));
btnDisConnect2 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [390 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton2Callback(txtPort2, txtAreaCommand));

txtPort3_Label = uilabel(controll_gui, 'Position', [510 560 130 40], 'Text', 'Station 3:', 'FontSize',20);
txtPort3 = uieditfield(controll_gui, 'text', 'Position', [510 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect3 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [620 535 100 25], 'ButtonPushedFcn', @(btnConnect, event) connectButton3Callback(txtPort3, txtAreaCommand));
btnDisConnect3 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [620 510 100 25], 'ButtonPushedFcn', @(btnDisConnect, event) disconnectButton3Callback(txtPort3, txtAreaCommand));

%textbox for realtime times
txtrealtime_label = uilabel(controll_gui, 'Position', [50 370 200 40], 'Text', 'Synchronisierte Systemzeit:', 'FontSize',15);
txtArea_realtime = uitextarea(controll_gui, 'Position', [50 340 100 40], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 17);
%textboxes for esp times
txtrealtime_esp1_label = uilabel(controll_gui, 'Position', [50 310 130 40], 'Text', 'Synchron. Zeit:', 'FontSize',15);
txtArea_time_esp1 = uitextarea(controll_gui, 'Position', [50 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp1_Label = uilabel(controll_gui, 'Position', [160,285,130,40], 'Text', '@ Station 1','FontSize',15);

txtrealtime_esp2_label = uilabel(controll_gui, 'Position', [280 310 130 40], 'Text', 'Synchron. Zeit:', 'FontSize',15);
txtArea_time_esp2 = uitextarea(controll_gui, 'Position', [280 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp2_Label = uilabel(controll_gui, 'Position', [390,285,130,40], 'Text', '@ Station 2','FontSize',15);

txtrealtime_esp3_label = uilabel(controll_gui, 'Position', [510 310 130 40], 'Text', 'Synchron. Zeit:', 'FontSize',15);
txtArea_time_esp3 = uitextarea(controll_gui, 'Position', [510 290 100 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
txttime_esp3_Label = uilabel(controll_gui, 'Position', [620,285,130,40], 'Text', '@ Station 3','FontSize',15);

% Define a timer object
t = timer('TimerFcn', @(~, ~) executeCycle(txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3), 'Period', 1, 'ExecutionMode', 'fixedRate', 'TasksToExecute', Inf);

% Button to synchronize time
btnSync = uibutton(controll_gui, 'push', 'Text', 'Sync-Time', 'Position', [160 340 100 40], 'ButtonPushedFcn', @(btnSync, event) syncButtonCallback(txtArea_realtime, txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3, txtAreaCommand, t));

% Button to stop
btnStop = uibutton(controll_gui, 'push', 'Text', 'Stop', 'Position', [620 50 100 40], 'BackgroundColor', 'red', 'ButtonPushedFcn', @(btnStop, event) stopButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3, t));

% Button to disconnect all
btnDisconnectAll = uibutton(controll_gui, 'push', 'Text', 'Disconnect All', 'Position', [160 460 100 40], 'ButtonPushedFcn', @(btnDisconnectAll, event) disconnectAllButtonCallback(txtAreaCommand, txtPort1, txtPort2, txtPort3));

% Button to search for ports
btnSearchPorts = uibutton(controll_gui, 'push', 'Text', 'Search Ports', 'Position', [160 400 100 40], 'BackgroundColor', [0.8, 0.8, 1], 'ButtonPushedFcn', @(btnSearchPorts, event) searchPortsCallback(txtAreaPorts, txtAreaCommand));

%dropdownmenue for the teamname
CCTM = readtable('CCTM2023.csv'); %Crazy Car Teilnehmer
serialPortDropdown = uidropdown(controll_gui, 'Position', [50 230 100 40], 'Items', CCTM.Teamname, 'ValueChangedFcn', @(dropdown, event) selectedTeamCallback(dropdown, txtAreaCommand));

% Button for setting the IDs
btnSetID = uibutton(controll_gui, 'push', 'Text', 'Set ID', 'Position', [160 230 100 40], 'BackgroundColor', [1, 0.647, 0], 'ButtonPushedFcn', @(btnSetID, event) setIDButtonCallback(serialPortDropdown, txtAreaCommand));

%"Ready" button
btnReady = uibutton(controll_gui, 'push', 'Text', 'Ready', 'Position', [160 170 100 40], 'BackgroundColor', 'yellow','ButtonPushedFcn', @(btnReady, event) readyButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3));

%"Start" button
btnStart = uibutton(controll_gui, 'push', 'Text', 'Start', 'Position', [160 110 100 40], 'BackgroundColor', 'green', 'ButtonPushedFcn', @(btnStart, event) startButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3));

%"read_log" button
txtRead_log_Label = uilabel(controll_gui, 'Position', [300,210,130,40], 'Text', 'Logged Data','FontSize',20);
btnRead_log = uibutton(controll_gui, 'push', 'Text', 'Read logged data', 'Position', [300 170 150 40], 'ButtonPushedFcn', @(btnRead_log, event) read_logButtonCallback(txtAreaCommand));

%"delete_log" button
btnDelete_log = uibutton(controll_gui, 'push', 'Text', 'Delete logged data', 'Position', [300 110 150 40], 'ButtonPushedFcn', @(btnDelete_log, event) delete_logButtonCallback(txtAreaCommand));



%% 
%##########################################################################
%       CALLBACK - Functions
%##########################################################################

% Callback-functions for the connect buttons
function connectButton1Callback(txtPort1, txtAreaCommand)
    try
        global parity1 esp1;
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port1Number = txtPort1.Value;
        [parity1, esp1] = contrButton.connect2ESP(port1Number);
        % Ändern Sie die Hintergrundfarbe der Textbox auf Hellgrün
        txtPort1.BackgroundColor = [0.8, 1, 0.8];
        disp(['Verbindung zum COM-Port ' port1Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton2Callback(txtPort2, txtAreaCommand)
    try
        global parity2 esp2;
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port2Number = txtPort2.Value;
        [parity2, esp2] = contrButton.connect2ESP(port2Number);
        txtPort2.BackgroundColor = [0.8, 1, 0.8];
        disp(['Verbindung zum COM-Port ' port2Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function connectButton3Callback(txtPort3, txtAreaCommand)
    try
        global parity3 esp3;
        % Port-Nummer aus dem Textfeld abrufen und die Verbindung herstellen
        port3Number = txtPort3.Value;
        [parity3, esp3] = contrButton.connect2ESP(port3Number);
        txtPort3.BackgroundColor = [0.8, 1, 0.8];
        disp(['Verbindung zum COM-Port ' port3Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' hergestellt.'];
        
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

%Callback function for the disconnect button(s)
function disconnectAllButtonCallback(txtAreaCommand, txtPort1, txtPort2, txtPort3)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;
        [parity1, parity2, parity3] = contrButton.disconnect_esp_all(esp1, parity1, esp2, parity2, esp3, parity3);
        disp('Alle Verbindungen getrennt.');
        txtPort1.BackgroundColor = [1, 0.8, 0.8];
        txtPort2.BackgroundColor = [1, 0.8, 0.8];
        txtPort3.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = 'Alle Verbindungen getrennt.';
    catch
    errordlg('Fehler beim Trennen aller Verbindungen.', 'Fehler');
    end
end

function disconnectButton1Callback(txtPort1, txtAreaCommand)
    try
        global parity1 esp1;
        port1Number = txtPort1.Value;
        parity1 = contrButton.disconnect_ESP(port1Number, parity1, esp1);
        txtPort1.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' abgebrochen.'];
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function disconnectButton2Callback(txtPort2, txtAreaCommand)
    try
        global parity2 esp2;
        port2Number = txtPort2.Value;
        parity2 = contrButton.disconnect_ESP(port2Number, parity2, esp2);
        txtPort2.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' abgebrochen.'];     
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

function disconnectButton3Callback(txtPort3, txtAreaCommand)
    try
        global parity3 esp3;
        port3Number = txtPort3.Value;
        parity3 = contrButton.disconnect_ESP(port3Number, parity3, esp3);
        txtPort3.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' abgebrochen.'];
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end

% Callback function for the Sync button
function syncButtonCallback(txtArea_realtime, txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3, txtAreaCommand, t)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;
        global timer_bit;

        % if timer_bit == 1
        % % Stop the timer when done
        % stop(t);
        % 
        % timer_bit = 0;
        % 
        % %Restart timer
        % t = timer('TimerFcn', @(~, ~) executeCycle(txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3), 'Period', 1, 'ExecutionMode', 'fixedRate', 'TasksToExecute', Inf);
        % start(t);
        % elseif timer_bit ==0

        % Call the function to synchronize time
        [realtime] = contrButton.sync_time(esp1, parity1);
        [~] = contrButton.sync_time(esp2, parity2);
        [~] = contrButton.sync_time(esp3, parity3);
        
        realtime_esp1 = contrButton.get_time(esp1, parity1);
        realtime_esp2 = contrButton.get_time(esp2, parity2);
        realtime_esp3 = contrButton.get_time(esp3, parity3);
        
        txtArea_realtime.Value = realtime;
        txtArea_time_esp1.Value = realtime_esp1;
        txtArea_time_esp2.Value = realtime_esp2;
        txtArea_time_esp3.Value = realtime_esp3;

        txtAreaCommand.Value = 'Zeit erfolgreich aktualisiert.';
        disp('Zeit erfolgreich aktualisiert');
        
        % Start the timer
        start(t);

        % Wait for the desired duration (e.g., 60 seconds)
        pause(inf);
        % end
    catch
         % Handle errors if the synchronization fails
         errordlg('Fehler beim Synchronisieren der Zeit.', 'Error');
    end
end

%Callback function for the stop button
function stopButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3, t)
    try
        global timer_bit;
        contrButton.stop(esp1, parity1);
        contrButton.stop(esp2, parity2);
        contrButton.stop(esp3, parity3);

        % Stop the timer when done
        stop(t);
        clear t;
        timer_bit = 0;

        txtAreaCommand.Value = 'Vorgang gestoppt.';
        disp('Vorgang gestoppt.');
        
    catch
        errordlg('Fehler beim Stoppen.', 'Fehler');
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
        disp(['ID erfolgreich gesetzt für Team: ' selectedTeam]);
    catch
          errordlg('Fehler beim ID-Setting.', 'Error');
    end
end

% Callback function for the "Ready" button
function readyButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3)
    try
        % Call the function to perform actions when the system is ready
        contrButton.isready(esp1, parity1);
        contrButton.isready(esp2, parity2);
        contrButton.isready(esp3, parity3);
        txtAreaCommand.Value = 'System ist bereit.';
        disp('System ist bereit.');
    catch
        errordlg('Fehler beim Vorbereiten des Systems.', 'Error');
    end
end

% Callback function for the "Start" button
function startButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3)
    try
        contrButton.start(esp1, parity1, 'data_race.mat');
        contrButton.start(esp2, parity2, 'data_race.mat');
        contrButton.start(esp3, parity3, 'data_race.mat');
        txtAreaCommand.Value = 'Start des Rennens!';
        disp('Start des Rennens');
    catch
        errordlg('Fehler beim Starten des Systems.', 'Error');
    end
end

%Callback function for the "read_log" button
function read_logButtonCallback(txtAreaCommand)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        contrButton.read_log(esp1, parity1);
        contrButton.read_log(esp2, parity2);
        contrButton.read_log(esp3, parity3);
        txtAreaCommand.Value = 'Geloggten Daten erfolgreich ausgelesen!';
        disp(datalog);
    catch
        errordlg('Fehler beim Lesen der gelog. Daten.', 'Error');
    end
end

%Callback function for the "delete_log" button
function delete_logButtonCallback(txtAreaCommand)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        message1 = delete_log(esp1, parity1);
        txtAreaCommand.Value = ['ESP1 -->' + message1];
        message2 = delete_log(esp2, parity2);
        txtAreaCommand.Value = ['ESP2 -->' + message2];
        message3 = delete_log(esp3, parity3);
        txtAreaCommand.Value = ['ESP3 -->' + message3];
    catch

    end
end

% Function to execute in each cycle
function executeCycle(txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3)
    global esp1 esp2 esp3 timer_bit;
    global parity1 parity2 parity3;
    
    timer_bit = 1;
    % Get real-time information from esp1
    realtime_esp1 = contrButton.get_time(esp1, parity1);

    % Get real-time information from esp2
    realtime_esp2 = contrButton.get_time(esp2, parity2);

    % Get real-time information from esp3
    realtime_esp3 = contrButton.get_time(esp3, parity3);

    txtArea_time_esp1.Value = realtime_esp1;
    txtArea_time_esp2.Value = realtime_esp2;
    txtArea_time_esp3.Value = realtime_esp3;
end