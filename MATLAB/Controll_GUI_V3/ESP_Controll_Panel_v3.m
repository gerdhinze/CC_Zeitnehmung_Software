clear;
clear commandwindow;
warning('off');

%Gloabal variables
global esp1 esp2 esp3;
global parity1 parity2 parity3;
global t stop_value;

stop_value = 0;

%##########################################################################
%       GUI - Objects
%##########################################################################
%---------------------------------------------------------------------------------------------------------------
% SETTING UP THE GUI INTERFACE
%---------------------------------------------------------------------------------------------------------------
controll_gui = uifigure('Name', 'Control-GUI');
controll_gui.ToolBar = 'none';
controll_gui.MenuBar = 'none';
controll_gui.Color = 'white';
controll_gui.Position = [250,250,1000,600];
%---------------------------------------------------------------------------------------------------------------
%TEXTAREAS FOR OUTPUTS
%---------------------------------------------------------------------------------------------------------------
%Create a command window
txtLabelCommand= uilabel(controll_gui, 'Position', [50 310 200 40], 'Text', 'Command Window:', 'FontSize',15);
txtAreaCommand = uitextarea(controll_gui, 'Position', [50 240 210 80], 'Editable', false, 'FontSize', 15);

% Create a uitextareas for commands - ESP1
txtLabelESP1_tx = uilabel(controll_gui, 'Position', [300 410 200 40], 'Text', 'Command to Station:', 'FontSize',15);
txtAreaESP1_tx = uitextarea(controll_gui, 'Position', [300 340 210 80], 'Editable', false, 'FontSize', 13);

% Create a uitextareas for response - ESP1
txtLabelESP1_rx = uilabel(controll_gui, 'Position', [300 310 200 40], 'Text', 'Response from Station:', 'FontSize',15);
txtAreaESP1_rx = uitextarea(controll_gui, 'Position', [300 240 210 80], 'Editable', false, 'FontSize', 13);

% Create a uitextareas for commands - ESP2
txtLabelESP2_tx = uilabel(controll_gui, 'Position', [530 410 200 40], 'Text', 'Command to Station:', 'FontSize',15);
txtAreaESP2_tx = uitextarea(controll_gui, 'Position', [530 340 210 80], 'Editable', false, 'FontSize', 13);

% Create a uitextareas for response - ESP2
txtLabelESP2_rx = uilabel(controll_gui, 'Position', [530 310 200 40], 'Text', 'Response from Station:', 'FontSize',15);
txtAreaESP2_rx = uitextarea(controll_gui, 'Position', [530 240 210 80], 'Editable', false, 'FontSize', 13);

% Create a uitextareas for commands - ESP3
txtLabelESP3_tx = uilabel(controll_gui, 'Position', [760 410 200 40], 'Text', 'Command to Station:', 'FontSize',15);
txtAreaESP3_tx = uitextarea(controll_gui, 'Position', [760 340 210 80], 'Editable', false, 'FontSize', 13);

% Create a uitextareas for response - ESP3
txtLabelESP3_rx = uilabel(controll_gui, 'Position', [760 310 200 40], 'Text', 'Response from Station:', 'FontSize',15);
txtAreaESP3_rx = uitextarea(controll_gui, 'Position', [760 240 210 80], 'Editable', false, 'FontSize', 13);
%---------------------------------------------------------------------------------------------------------------
%FINDING AVALABLE PORTS
%---------------------------------------------------------------------------------------------------------------
txtPorts_Label = uilabel(controll_gui, 'Position', [50,560,130,40], 'Text', 'Port-Control:','FontSize',20);
txtAreaPorts = uitextarea(controll_gui, 'Position', [50 450 100 110], 'Editable', false);

% Get the list of available serial ports
availablePorts = serialportlist("available");

% Convert the cell array of port names to a string
portsString = sprintf('Available Ports:\n%s\n', strjoin(availablePorts, '\n'));
txtAreaPorts.Value = portsString;
%---------------------------------------------------------------------------------------------------------------
%SETTING UP ESP-CONNECTION
%---------------------------------------------------------------------------------------------------------------
%for ESP1
txtPort1_Label = uilabel(controll_gui, 'Position', [300,560,130,40], 'Text', 'Station 1:','FontSize',20);
txtPort1 = uieditfield(controll_gui, 'text', 'Position', [300 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect1 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [410 535 100 25], 'ButtonPushedFcn', ...
    @(btnConnect, event) connectButton1Callback(txtPort1, txtAreaCommand));
btnDisConnect1 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [410 510 100 25], 'ButtonPushedFcn', ...
    @(btnDisConnect, event) disconnectButton1Callback(txtPort1, txtAreaCommand));

%for ESP2
txtPort2_Label = uilabel(controll_gui, 'Position', [530 560 130 40], 'Text', 'Station 2:', 'FontSize',20);
txtPort2 = uieditfield(controll_gui, 'text', 'Position', [530 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect2 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [640 535 100 25], 'ButtonPushedFcn', ...
    @(btnConnect, event) connectButton2Callback(txtPort2, txtAreaCommand));
btnDisConnect2 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [640 510 100 25], 'ButtonPushedFcn', ...
    @(btnDisConnect, event) disconnectButton2Callback(txtPort2, txtAreaCommand));

%for ESP3
txtPort3_Label = uilabel(controll_gui, 'Position', [760 560 130 40], 'Text', 'Station 3:', 'FontSize',20);
txtPort3 = uieditfield(controll_gui, 'text', 'Position', [760 510 100 50], 'Value', 'COMX', 'BackgroundColor', [1, 0.8, 0.8]);
btnConnect3 = uibutton(controll_gui, 'push', 'Text', 'Connect', 'Position', [870 535 100 25], 'ButtonPushedFcn', ...
    @(btnConnect, event) connectButton3Callback(txtPort3, txtAreaCommand));
btnDisConnect3 = uibutton(controll_gui, 'push', 'Text', 'Disconnect', 'Position', [870 510 100 25], 'ButtonPushedFcn', ...
    @(btnDisConnect, event) disconnectButton3Callback(txtPort3, txtAreaCommand));
%---------------------------------------------------------------------------------------------------------------
%REALTIMES
%---------------------------------------------------------------------------------------------------------------
%textarea for realtime time
txtrealtime_label = uilabel(controll_gui, 'Position', [50 410 200 40], 'Text', 'Synchron. Systemtime:', 'FontSize',15);
txtArea_realtime = uitextarea(controll_gui, 'Position', [50 380 100 40], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 17);

%textarea for ESP1 - time
txtrealtime_esp1_label = uilabel(controll_gui, 'Position', [300 470 130 40], 'Text', 'Synchron. Time:', 'FontSize',15);
txtArea_time_esp1 = uitextarea(controll_gui, 'Position', [300 450 150 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);

%textarea for ESP2 - time
txtrealtime_esp2_label = uilabel(controll_gui, 'Position', [530 470 130 40], 'Text', 'Synchron. Time:', 'FontSize',15);
txtArea_time_esp2 = uitextarea(controll_gui, 'Position', [530 450 150 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);

%textarea for ESP3 - time
txtrealtime_esp3_label = uilabel(controll_gui, 'Position', [760 470 130 40], 'Text', 'Synchron. Time:', 'FontSize',15);
txtArea_time_esp3 = uitextarea(controll_gui, 'Position', [760 450 150 30], 'Editable', false, 'Value', 'hh:mm:ss', 'FontSize', 15);
%---------------------------------------------------------------------------------------------------------------
%SETTING UP THE TIMER - 1s
%---------------------------------------------------------------------------------------------------------------
% Define a timer object
t = timer('TimerFcn', @(~, ~) executeCycle(txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3), 'Period', 1, 'ExecutionMode', 'fixedRate', 'TasksToExecute', Inf);
%---------------------------------------------------------------------------------------------------------------
% Button to SYNCHRONIZE time
btnSync = uibutton(controll_gui, 'push', 'Text', 'Sync-Time', 'Position', [160 380 100 40], 'ButtonPushedFcn', ...
    @(btnSync, event) syncButtonCallback(txtArea_realtime, txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3, ...
    txtAreaCommand, t, txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
% Button to STOP
btnStop = uibutton(controll_gui, 'push', 'Text', 'Stop', 'Position', [870 20 100 40], 'BackgroundColor', 'red', 'ButtonPushedFcn', ...
    @(btnStop, event) stopButtonCallback(txtAreaCommand, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
% Button to DISCONNECT all
btnDisconnectAll = uibutton(controll_gui, 'push', 'Text', 'Disconnect All', 'Position', [160 510 100 50], 'ButtonPushedFcn', ...
    @(btnDisconnectAll, event) disconnectAllButtonCallback(txtAreaCommand, txtPort1, txtPort2, txtPort3));
%---------------------------------------------------------------------------------------------------------------
% Button to SEARCH for ports
btnSearchPorts = uibutton(controll_gui, 'push', 'Text', 'Search Ports', 'Position', [160 450 100 50], 'BackgroundColor', [0.8, 0.8, 1], 'ButtonPushedFcn', ...
    @(btnSearchPorts, event) searchPortsCallback(txtAreaPorts, txtAreaCommand));
%---------------------------------------------------------------------------------------------------------------
%Label for Race controll
txtLabel_race = uilabel(controll_gui, 'Position', [50 200 130 40], 'Text', 'Race-Control:', 'FontSize', 20);

%Label for Dropdown menue
txtLabel_dropdown = uilabel(controll_gui, 'Position', [50 180 180 30], 'Text', 'Select Teamname:', 'FontSize', 15);

%Getting values from *.csv file
CCTM = readtable('CC_teamnames.csv'); %Crazy Car members

%Dropdown menue
serialPortDropdown = uidropdown(controll_gui, 'Position', [50 140 210 40], 'Items', CCTM.Teamname, 'ValueChangedFcn', ...
    @(dropdown, event) selectedTeamCallback(dropdown, txtAreaCommand));
%---------------------------------------------------------------------------------------------------------------
% Button for setting the IDs
btnSetID = uibutton(controll_gui, 'push', 'Text', 'Set ID', 'Position', [300 140 100 40], 'BackgroundColor', [1, 0.647, 0], 'ButtonPushedFcn', ...
    @(btnSetID, event) setIDButtonCallback(serialPortDropdown, txtAreaCommand,  txtAreaESP1_tx, txtAreaESP1_rx));
%---------------------------------------------------------------------------------------------------------------
%"Ready" button
btnReady = uibutton(controll_gui, 'push', 'Text', 'Ready', 'Position', [300 80 100 40], 'BackgroundColor', 'yellow','ButtonPushedFcn', ...
    @(btnReady, event) readyButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
%"Start" button
btnStart = uibutton(controll_gui, 'push', 'Text', 'Start', 'Position', [300 20 100 40], 'BackgroundColor', 'green', 'ButtonPushedFcn', ...
    @(btnStart, event) startButtonCallback(txtAreaCommand, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
%"read_log 1" button
txtRead_log_Label = uilabel(controll_gui, 'Position', [530,200,130,40], 'Text', 'Data-Control','FontSize',20);
txtLog_Label = uilabel(controll_gui, 'Position', [530 180 180 30], 'Text', 'Datainteraction:', 'FontSize', 15);

txtStatus_Label = uilabel(controll_gui, 'Position', [760 180 180 30], 'Text', 'Datacomparison-Status:', 'FontSize', 15);
txtAreaLog = uitextarea(controll_gui, 'Position', [760 140 150 40], 'Editable', false);

btnRead_log_1 = uibutton(controll_gui, 'push', 'Text', '1. Read Logged-Data', 'Position', [530 160 150 20], 'ButtonPushedFcn', ...
    @(btnRead_log_1, event) read_logButton_1Callback(txtAreaCommand, txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, ...
    txtAreaESP2_rx, txtAreaESP3_rx, txtAreaLog));

btnRead_log_2 = uibutton(controll_gui, 'push', 'Text', '2. Read Logged-Data', 'Position', [530 140 150 20], 'ButtonPushedFcn', ...
    @(btnRead_log_2, event) read_logButton_2Callback(txtAreaCommand, txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, ...
    txtAreaESP2_rx, txtAreaESP3_rx, txtAreaLog));

%---------------------------------------------------------------------------------------------------------------
%"Compare-log" button
txtAreaCompLog = uitextarea(controll_gui, 'Position', [760 80 150 40], 'Editable', false);

btnCompare_log = uibutton(controll_gui, 'push', 'Text', 'Logged-Data vs. Live-Data', 'Position', [530 80 150 40], 'ButtonPushedFcn', ...
    @(btnCompare_log, event) compare_logButtonCallback(txtAreaCommand, txtAreaCompLog, txtAreaESP1_tx, ...
    txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
%"delete_log" button
btnDelete_log = uibutton(controll_gui, 'push', 'Text', 'Delete Logged-Data', 'Position', [530 20 150 40], 'ButtonPushedFcn', ...
    @(btnDelete_log, event) delete_logButtonCallback(txtAreaCommand, txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx,...
    txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx));
%---------------------------------------------------------------------------------------------------------------
%"Algorithmus mit log data" button
btnAlg_log = uibutton(controll_gui, 'push', 'Text', 'Log.-Data ALG', ...
    'Position', [760 20 100 40], 'ButtonPushedFcn', @(btn, event) Alg_logButtonCallback(txtAreaCommand), ...
    'BackgroundColor', [0.8, 0.8, 1]);
%---------------------------------------------------------------------------------------------------------------
%% 
%##########################################################################
%       CALLBACK - Functions
%##########################################################################
%---------------------------------------------------------------------------------------------------------------
% Callback-functions for the connect buttons
function connectButton1Callback(txtPort1, txtAreaCommand)
    try
        global parity1 esp1;

        % call Port-number from the textarea to get the connection
        port1Number = txtPort1.Value;
        [parity1, esp1] = contrButton.connect2ESP(port1Number);

        % Change backgroundcolour to green
        txtPort1.BackgroundColor = [0.8, 1, 0.8];
        
        disp(['Verbindung zum COM-Port ' port1Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' hergestellt.'];
        
    catch
        % Errorhandling
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
function connectButton2Callback(txtPort2, txtAreaCommand)
    try
        global parity2 esp2;

        % call Port-number from the textarea to get the connection
        port2Number = txtPort2.Value;
        [parity2, esp2] = contrButton.connect2ESP(port2Number);

        % Change backgroundcolour to green
        txtPort2.BackgroundColor = [0.8, 1, 0.8];

        disp(['Verbindung zum COM-Port ' port2Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' hergestellt.'];
        
    catch
        % Errorhandling
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
function connectButton3Callback(txtPort3, txtAreaCommand)
    try
        global parity3 esp3;

        % call Port-number from the textarea to get the connection
        port3Number = txtPort3.Value;
        [parity3, esp3] = contrButton.connect2ESP(port3Number);

        % Change backgroundcolour to green
        txtPort3.BackgroundColor = [0.8, 1, 0.8];

        disp(['Verbindung zum COM-Port ' port3Number ' hergestellt.']);
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' hergestellt.'];
        
    catch
        % Errorhandling
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the disconnect button
function disconnectAllButtonCallback(txtAreaCommand, txtPort1, txtPort2, txtPort3)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        [parity1, parity2, parity3] = contrButton.disconnect_ESP_all(esp1, parity1, esp2, parity2, esp3, parity3);
        disp('Alle Verbindungen getrennt.');

        %Change Backgroundcolour to red
        txtPort1.BackgroundColor = [1, 0.8, 0.8];
        txtPort2.BackgroundColor = [1, 0.8, 0.8];
        txtPort3.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = 'Alle Verbindungen getrennt.';
    catch
    errordlg('Fehler beim Trennen aller Verbindungen.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
function disconnectButton1Callback(txtPort1, txtAreaCommand)
    try
        global parity1 esp1;

        % call Port-number from the textarea to disconnect
        port1Number = txtPort1.Value;
        parity1 = contrButton.disconnect_ESP(port1Number, parity1, esp1);
        %Change the backgroundcolour to red
        txtPort1.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port1Number ' abgebrochen.'];
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
function disconnectButton2Callback(txtPort2, txtAreaCommand)
    try
        global parity2 esp2;
        % call Port-number from the textarea to disconnect
        port2Number = txtPort2.Value;
        parity2 = contrButton.disconnect_ESP(port2Number, parity2, esp2);
        %Change the backgroundcolour to red
        txtPort2.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port2Number ' abgebrochen.'];     
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
function disconnectButton3Callback(txtPort3, txtAreaCommand)
    try
        global parity3 esp3;
        % call Port-number from the textarea to disconnect
        port3Number = txtPort3.Value;
        parity3 = contrButton.disconnect_ESP(port3Number, parity3, esp3);
        %Change the backgroundcolour to red
        txtPort3.BackgroundColor = [1, 0.8, 0.8];
        txtAreaCommand.Value = ['Verbindung zum COM-Port ' port3Number ' abgebrochen.'];
    catch
        % Fehlerbehandlung, falls die Verbindung nicht hergestellt werden kann
        errordlg('Fehler beim Herstellen der Verbindung.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
% Callback function for the Sync button
function syncButtonCallback(txtArea_realtime, txtArea_time_esp1, ...
    txtArea_time_esp2, txtArea_time_esp3, txtAreaCommand, t, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, ...
    txtAreaESP2_rx, txtAreaESP3_rx)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        % Call the function to synchronize time
        [realtime, command_esp1, respond_esp1] = contrButton.sync_time(esp1, parity1);
        [~, command_esp2, respond_esp2] = contrButton.sync_time(esp2, parity2);
        [~, command_esp3, respond_esp3] = contrButton.sync_time(esp3, parity3);
        
        %Write sent command in txtArea
        txtAreaESP1_tx.Value = command_esp1;
        txtAreaESP2_tx.Value = command_esp2;
        txtAreaESP3_tx.Value = command_esp3;

        %Write respond in txtArea
        txtAreaESP1_rx.Value = respond_esp1;
        txtAreaESP2_rx.Value = respond_esp2;
        txtAreaESP3_rx.Value = respond_esp3;

        %Calling function get_time
        [realtime_esp1, command_esp1, respond_esp1] = contrButton.get_time(esp1, parity1);
        [realtime_esp2, command_esp2, respond_esp2] = contrButton.get_time(esp2, parity2);
        [realtime_esp3, command_esp3, respond_esp3] = contrButton.get_time(esp3, parity3);
        
        %Write realtime in txtArea
        txtArea_realtime.Value = realtime;
        txtArea_time_esp1.Value = realtime_esp1;
        txtArea_time_esp2.Value = realtime_esp2;
        txtArea_time_esp3.Value = realtime_esp3;

        %Write sent command in txtArea
        txtAreaESP1_tx.Value = command_esp1;
        txtAreaESP2_tx.Value = command_esp2;
        txtAreaESP3_tx.Value = command_esp3;

        %Write respond in txtArea
        txtAreaESP1_rx.Value = respond_esp1;
        txtAreaESP2_rx.Value = respond_esp2;
        txtAreaESP3_rx.Value = respond_esp3;

        txtAreaCommand.Value = 'Zeit erfolgreich aktualisiert.';
        disp('Zeit erfolgreich aktualisiert');
        
        % Start the timer
        start(t);

        % Wait for the desired duration (e.g., 60 seconds)
        pause(3600);
    catch
         % Handle errors if the synchronization fails
         errordlg('Fehler beim Synchronisieren der Zeit.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the stop button
function stopButtonCallback(txtAreaCommand, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, ...
    txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;
        global t stop_value;
        stop_value = 1;

        % Stop the timer when done
        stop(t);
        clear t;
        
        [command_esp1, respond_esp1] = contrButton.stop(esp1, parity1);
        [command_esp2, respond_esp2] = contrButton.stop(esp2, parity2);
        [command_esp3, respond_esp3] = contrButton.stop(esp3, parity3);

        %Write sent command in txtArea
        txtAreaESP1_tx.Value = command_esp1;
        txtAreaESP2_tx.Value = command_esp2;
        txtAreaESP3_tx.Value = command_esp3;

        %Write receive in txtArea
        txtAreaESP1_rx.Value = respond_esp1;
        txtAreaESP2_rx.Value = respond_esp2;
        txtAreaESP3_rx.Value = respond_esp3;

        txtAreaCommand.Value = 'Vorgang gestoppt.';
        disp('Vorgang gestoppt.');
        
    catch
       errordlg('Fehler beim Stoppen.', 'Fehler');
    end
end
%---------------------------------------------------------------------------------------------------------------
% Callback function for the "Search Ports" button
function searchPortsCallback(txtAreaPorts, txtAreaCommand)
    try
        % Get the list of available serial ports
        availablePorts = serialportlist("available");
        
        % Convert the cell array of port names to a string
        portsString = sprintf('Available Ports:\n%s\n', strjoin(availablePorts, '\n'));
        
        % Display the ports in the uitextarea
        txtAreaPorts.Value = portsString;
        txtAreaCommand.Value = 'Serial ports aktualisiert.';
        disp('Serial ports aktualisiert.');
    catch
        errordlg('Fehler beim Aktualisieren der Serial Ports.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
% Callback function for the  drop-down menu
function selectedTeamCallback(dropdown, txtAreaCommand)
    selectedTeam = dropdown.Value;
    txtAreaCommand.Value = ['Ausgewähltes Team:' newline selectedTeam];
    disp(['Ausgewähltes Team: ' selectedTeam]);
end

% Callback function for the "Set ID" button
function setIDButtonCallback(dropdown, txtAreaCommand, txtAreaESP1_tx, txtAreaESP1_rx)
    try
        global esp1 parity1;
        % Get the selected team from the dropdown menu
        selectedTeam = dropdown.Value;
      
        % Call the function to set the ID (replace with your actual set_ID logic)
        contrButton.set_ID(selectedTeam, esp1, parity1, txtAreaESP1_tx, txtAreaESP1_rx);
        
        txtAreaCommand.Value = ['ID erfolgreich gesetzt for Team: ' selectedTeam];
        disp(['ID erfolgreich gesetzt für Team: ' selectedTeam]);
    catch
          errordlg('Fehler beim ID-Setting.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
% Callback function for the "Ready" button
function readyButtonCallback(txtAreaCommand, esp1, parity1, esp2, parity2, esp3, parity3, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;
        
        % Call the function to perform actions when the system is ready
        [command_esp1, respond_esp1] = contrButton.isready(esp1, parity1);
        [command_esp2, respond_esp2] = contrButton.isready(esp2, parity2);
        [command_esp3, respond_esp3] = contrButton.isready(esp3, parity3);

        %Write sent command in txtArea
        txtAreaESP1_tx.Value = command_esp1;
        txtAreaESP2_tx.Value = command_esp2;
        txtAreaESP3_tx.Value = command_esp3;

        %Write receive in txtArea
        txtAreaESP1_rx.Value = respond_esp1;
        txtAreaESP2_rx.Value = respond_esp2;
        txtAreaESP3_rx.Value = respond_esp3;

        txtAreaCommand.Value = 'System ist bereit.';
        disp('System ist bereit.');
    catch
        errordlg('Fehler beim Vorbereiten des Systems.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
% Callback function for the "Start" button
function startButtonCallback(txtAreaCommand,...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, ...
    txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;
        global stop_value;

        stop_value = 0;

        dataFile_ID = './Output_Files/ID_file_cleared.csv';
        dataFile_Race = './Output_Files/data_race.csv';

        contrButton.processCSV('./Output_Files/ID_file.csv', dataFile_ID);

        txtAreaCommand.Value = 'Start des Rennens!';
        disp('Start des Rennens');

        contrButton.start(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, ...
            txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, dataFile_Race);
       
    catch
        errordlg('Fehler beim Starten des Systems.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the "read_log 1" button
function read_logButton_1Callback(txtAreaCommand, txtAreaESP1_tx, ...
    txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, txtAreaLog)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        dataFile_1 = './Output_Files/data_log_1.csv';

        if exist(dataFile_1, 'file') == 2
        % Check if the file exists before attempting to delete it
        disp(['Vorhandende Datei' dataFile_1 ' gelöscht']);
        delete(dataFile_1);
        end
        
        contrButton.read_log(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, dataFile_1);
        txtAreaCommand.Value = 'Erster Durchgang erfolgreich ausgelesen!';
    catch
        errordlg('Fehler beim Lesen der gelog. Daten.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the "read_log 2" button
function read_logButton_2Callback(txtAreaCommand, txtAreaESP1_tx, ...
    txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, txtAreaLog)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        dataFile_1 = './Output_Files/data_log_1.csv';
        dataFile_2 = './Output_Files/data_log_2.csv';

        if exist(dataFile_2, 'file') == 2
        % Check if the file exists before attempting to delete it
        disp(['Vorhandende Datei' dataFile_2 ' gelöscht']);
        delete(dataFile_2);
        end
       
        txtAreaLog.Value = '';
        txtAreaLog.BackgroundColor = 'white';

        contrButton.read_log(txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx, dataFile_2);
        txtAreaCommand.Value = 'Zweiter Durchgang erfolgreich ausgelesen!';

        pause(2)
        txtAreaCommand.Value = ('Überprüfe Datentransfer der Logged-Data');

        %Comparing
        isident = contrButton.compare_log(dataFile_1, dataFile_2);

        if isident == 1
            txtAreaLog.Value = 'Ausgelesene Daten sind identisch';
            txtAreaLog.BackgroundColor = [0.8, 1, 0.8];

        elseif isident == 0
            txtAreaLog.Value = 'Fehler - Datenauslesen Wiederholen';
            txtAreaLog.BackgroundColor = [1, 0.8, 0.8];
        end
    catch
        errordlg('Fehler beim Lesen der gelog. Daten.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the "delete_log" button
function delete_logButtonCallback(txtAreaCommand, txtAreaESP1_tx, ...
    txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)
    try
        global esp1 esp2 esp3;
        global parity1 parity2 parity3;

        dataFile_1 = './Output_Files/data_log_1.csv';
        dataFile_2 = './Output_Files/data_log_2.csv';
        dataFile_Race = './Output_Files/data_race.csv';

        if exist(dataFile_1, 'file') == 2
        % Check if the file exists before attempting to delete it
        disp(['Vorhandende Datei' dataFile_1 ' gelöscht']);
        delete(dataFile_1);
        end

        if exist(dataFile_2, 'file') == 2
        % Check if the file exists before attempting to delete it
        disp(['Vorhandende Datei' dataFile_2 ' gelöscht']);
        delete(dataFile_2);
        end

        if exist(dataFile_Race, 'file') == 2
        % Check if the file exists before attempting to delete it
        disp(['Vorhandende Datei' dataFile_Race ' gelöscht']);
        delete(dataFile_Race);
        end

        [command_esp1, respond_esp1] = contrButton.delete_log(esp1, parity1);
        [command_esp2, respond_esp2] = contrButton.delete_log(esp2, parity2);
        [command_esp3, respond_esp3] = contrButton.delete_log(esp3, parity3);
        
        %Write sent command in txtArea
        txtAreaESP1_tx.Value = command_esp1;
        txtAreaESP2_tx.Value = command_esp2;
        txtAreaESP3_tx.Value = command_esp3;

        %Write receive in txtArea
        txtAreaESP1_rx.Value = respond_esp1;
        txtAreaESP2_rx.Value = respond_esp2;
        txtAreaESP3_rx.Value = respond_esp3;

        txtAreaCommand.Value = 'Geloggten Daten erfolgreich gelöscht!';
    catch
        errordlg('Fehler beim Löschen der gelog. Daten.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the "Algorithmus log data" button
function Alg_logButtonCallback(txtAreaCommand, txtAreaESP1_tx, ...
    txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, txtAreaESP2_rx, txtAreaESP3_rx)
    try
    % Read data from the *.csv file
    data = readtable('./Output_Files/ID_file_cleared.csv');

    txtAreaESP1_tx.Value = '';
    txtAreaESP2_tx.Value = '';
    txtAreaESP3_tx.Value = '';

    txtAreaESP1_rx.Value = '';
    txtAreaESP2_rx.Value = '';
    txtAreaESP3_rx.Value = '';
    
    % Choose the last and prelist row
    prelast_row = data(end-1, :);
    last_row = data(end, :);
    
    % Extract IDs from the last and prelast row
    id_A = (prelast_row.ID);
    id_B = (last_row.ID);

    dataFile_2_sort = './Output_Files/data_log_2_sort.csv';
    algorithmus.newEntryLog(id_A, id_B, 1, dataFile_2_sort);

    txtAreaCommand.Value = 'Geloggte Daten wurden ausgewertet';
    catch
        errordlg('Fehler beim Auswerten der gelog. Daten.', 'Error');
    end
end
%---------------------------------------------------------------------------------------------------------------
%Callback function for the "Compare log data" button
function compare_logButtonCallback(txtAreaCommand, txtAreaCompLog, ...
    txtAreaESP1_tx, txtAreaESP2_tx, txtAreaESP3_tx, txtAreaESP1_rx, ...
    txtAreaESP2_rx, txtAreaESP3_rx)

    dataFile_Race = './Output_Files/data_race.csv';
    dataFile_2 = './Output_Files/data_log_2.csv';

    dataFile_Race_sort = './Output_Files/data_race_sort.csv';
    dataFile_2_sort = './Output_Files/data_log_2_sort.csv';

    if exist(dataFile_Race_sort, 'file') == 2
    % Check if the file exists before attempting to delete it
    disp(['Vorhandende Datei' dataFile_Race_sort ' gelöscht']);
    delete(dataFile_Race_sort);
    end

    if exist(dataFile_2_sort, 'file') == 2
    % Check if the file exists before attempting to delete it
    disp(['Vorhandende Datei' dataFile_2_sort ' gelöscht']);
    delete(dataFile_2_sort);
    end

    txtAreaESP1_tx.Value = '';
    txtAreaESP2_tx.Value = '';
    txtAreaESP3_tx.Value = '';

    txtAreaESP1_rx.Value = '';
    txtAreaESP2_rx.Value = '';
    txtAreaESP3_rx.Value = '';

    txtAreaCommand.Value = ('Sortiere Dateien nach Timestamp');
    contrButton.readSortAndSaveCSV(dataFile_Race, dataFile_Race_sort);
    contrButton.readSortAndSaveCSV(dataFile_2, dataFile_2_sort);

    txtAreaCommand.Value = ('Vergleiche Live-Data mit Logged-Data');
    %Comparing
        isident = contrButton.compare_livedata(dataFile_Race_sort, dataFile_2_sort);

        if isident == 1
            txtAreaCompLog.Value = 'Ausgelesene Daten sind identisch';
            txtAreaCompLog.BackgroundColor = [0.8, 1, 0.8];

        else
            txtAreaCompLog.Value = 'Fehler - Daten nicht ident';
            txtAreaCompLog.BackgroundColor = [1, 0.8, 0.8];
        end
end
%---------------------------------------------------------------------------------------------------------------
% Function to execute in each cycle
function executeCycle(txtArea_time_esp1, txtArea_time_esp2, txtArea_time_esp3)
    global esp1 esp2 esp3;
    global parity1 parity2 parity3;
    
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