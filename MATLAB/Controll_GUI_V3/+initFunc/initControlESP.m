function initControlButton(ccHandle)

    lblStationName1 = uilabel(ccHandle);
    lblStationName1.Text = 'Station 1';
    lblStationName1.Position = [80,350,425,400];
    lblStationName1.FontSize = 30;

    lblStationName2 = uilabel(ccHandle);
    lblStationName2.Text = 'Station 2';
    lblStationName2.Position = [330,350,425,400];
    lblStationName2.FontSize = 30;

    lblStationName3 = uilabel(ccHandle);
    lblStationName3.Text = 'Station 3';
    lblStationName3.Position = [580,350,425,400];
    lblStationName3.FontSize = 30;

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %Erstellen Sie einen Button, der den in der Textbox eingegebenen Text anzeigt
    bt.connect_ESP1 = uicontrol('Style', 'pushbutton', 'String', 'Zeige Text', ...
    'Position', [50,450,175,25], ...
    'Callback', @(src, event) disp(get(textbox, 'String')));

    guidata(txt.Port1);
    guidata(bt.connect_ESP1);

    % Erstellen Sie eine Textbox im GUI
    txt.Port1 = uicontrol('Style', 'edit', 'String', 'Hier Text eingeben', ...
    'Position', [50,500,175,25]);

    % Erstellen Sie eine Textbox im GUI
    txt.Port1 = uicontrol('Style', 'edit', 'String', 'Hier Text eingeben', ...
    'Position', [300, 100, 200, 30]);

    % Erstellen Sie einen Button, der den in der Textbox eingegebenen Text anzeigt
    bt.connect_ESP1 = uicontrol('Style', 'pushbutton', 'String', 'Zeige Text', ...
    'Position', [350, 50, 100, 30], ...
    'Callback', @(src, event) disp(get(textbox, 'String')));

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%% Connect ESP1
    %bt.connect_ESP1 = uibutton(ccHandle,"Enable","on");
    %bt.connect_ESP1.Text = 'Connect ESP1';
    %bt.stDraw.Tag = 'stRace';
    %bt.connect_ESP1.Position = [50,500,175,25];
    %bt.connect_ESP1.FontSize = 16;
    %bt.connect_ESP1.ButtonPushedFcn = @contrButton.connect2ESP1;

    %%% Connect ESP2
    bt.connect_ESP2 = uibutton(ccHandle);
    bt.connect_ESP2.Text = 'Connect ESP2';
    %bt.stDraw.Tag = 'stRace';
    bt.connect_ESP2.Position = [300,500,175,25];
    bt.connect_ESP2.FontSize = 16;
    bt.connect_ESP2.ButtonPushedFcn = @contrButton.connect2ESP2;

    %%% Connect ESP3
    bt.connect_ESP3 = uibutton(ccHandle);
    bt.connect_ESP3.Text = 'Connect ESP3';
    %bt.stDraw.Tag = 'stRace';
    bt.connect_ESP3.Position = [550,500,175,25];
    bt.connect_ESP3.FontSize = 16;
    %bt.connect_ESP1.ButtonPushedFcn = @ctrlBut.bt_duelgen;


    %txt.Port1 = uitextarea(ccHandle);
    %txt.Port1.Position = [50,450,175,25];
    %txt.Port1.ValueChangedFcn = @(src,event) textEntered(src,event,bt.connect_ESP1);

    txt.Port2 = uitextarea(ccHandle);
    txt.Port2.Position = [300,450,175,25];
   % txt.Port1.ValueChangedFcn = @(src,event) textEntered(src,event,bt.connect_ESP2);
   
    txt.Port3 = uitextarea(ccHandle);
    txt.Port3.Position = [550,450,175,25];

     %%% Select Port ESP1
    bt.select_Port1 = uibutton(ccHandle);
    bt.select_Port1.Text = 'Select Port 1';
    %bt.stDraw.Tag = 'stRace';
    bt.select_Port1.Position = [50,400,175,25];
    bt.select_Port1.FontSize = 16;
    %bt.select_Port1.ButtonPushedFcn = @ctrlBut.bt_duelgen;

      %%% Select Port ESP2
    bt.select_Port2 = uibutton(ccHandle);
    bt.select_Port2.Text = 'Select Port 2';
    %bt.stDraw.Tag = 'stRace';
    bt.select_Port2.Position = [300,400,175,25];
    bt.select_Port2.FontSize = 16;
    %bt.select_Port1.ButtonPushedFcn = @ctrlBut.bt_duelgen;

       %%% Select Port ESP3
    bt.select_Port3 = uibutton(ccHandle);
    bt.select_Port3.Text = 'Select Port 3';
    %bt.stDraw.Tag = 'stRace';
    bt.select_Port3.Position = [550,400,175,25];
    bt.select_Port3.FontSize = 16;
    %bt.select_Port3.ButtonPushedFcn = @ctrlBut.bt_duelgen;

     %%% Sync Time
    bt.syny_time = uibutton(ccHandle);
    bt.syny_time.Text = 'Sync Time';
    %bt.stDraw.Tag = 'stRace';
    bt.syny_time.Position = [50,350,175,25];
    bt.syny_time.FontSize = 16;
    %bt.syny_time.ButtonPushedFcn = @ctrlBut.bt_duelgen;

     %%% Time ESP1
    txt.time_ESP1 = uitextarea(ccHandle);
    txt.time_ESP1.Position = [50,300,175,25];

     %%% Time ESP2
    txt.time_ESP2 = uitextarea(ccHandle);
    txt.time_ESP2.Position = [300,300,175,25];
   
     %%% Time ESP3
    txt.time_ESP3 = uitextarea(ccHandle);
    txt.time_ESP3.Position = [550,300,175,25];

     %%% Drop down box Teams   
    dd.team = uidropdown(ccHandle);
   % dd.team.Text = 'Select Team';
    dd.team.Position = [50,250,175,25];
    dd.team.FontSize = 16;

     %%% Set ID
    bt.set_id = uibutton(ccHandle);
    bt.set_id.Text = 'Set ID';
    %bt.set_id.Tag = 'stRace';
    bt.set_id.Position = [300,250,175,25];
    bt.set_id.FontSize = 16;
    %bt.set_id.ButtonPushedFcn = @ctrlBut.bt_duelgen;

     %%% Ready
    bt.ready = uibutton(ccHandle);
    bt.ready.Text = 'Ready';
    %bt.ready.Tag = 'stRace';
    bt.ready.Position = [50,200,175,25];
    bt.ready.FontSize = 16;
    %bt.ready.ButtonPushedFcn = @ctrlBut.bt_duelgen;

     %%% Start
    bt.start = uibutton(ccHandle);
    bt.start.Text = 'Start';
    %bt.start.Tag = 'stRace';
    bt.start.Position = [50,150,175,25];
    bt.start.FontSize = 16;
    %bt.start.ButtonPushedFcn = @ctrlBut.bt_duelgen;

     %%% Stop
    bt.stop = uibutton(ccHandle);
    bt.stop.Text = 'Stop';
    %bt.stop.Tag = 'stRace';
    bt.stop.Position = [550,50,175,25];
    bt.stop.FontSize = 16;
    %bt.stop.ButtonPushedFcn = @ctrlBut.bt_duelgen;
   
end

