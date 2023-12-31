% Erstellen Sie eine GUI-Figur
fig = figure('Position', [100, 100, 300, 200], 'Name', 'Text Box GUI');

% Erstellen Sie eine Textbox im GUI
%textbox = uicontrol('Style', 'edit', 'String', 'Hier Text eingeben', ...
%    'Position', [50, 100, 200, 30]);

% Erstellen Sie einen Button, der den in der Textbox eingegebenen Text anzeigt
button = uicontrol('Style', 'pushbutton', 'String', 'Zeige Text', ...
    'Position', [100, 50, 100, 30], ...
    'Callback', @contrButton.connect2ESP1);

% Zeigen Sie die GUI an
guidata(fig, textbox);
guidata(fig, button);


% Erstellen Sie eine Textbox im GUI
textbox = uicontrol('Style', 'edit', 'String', 'Hier Text eingeben', ...
    'Position', [300, 100, 200, 30]);
%textbox.ValueChangedFcn = @(src,event) textEntered(src,event,button);

% Erstellen Sie einen Button, der den in der Textbox eingegebenen Text anzeigt
button = uicontrol('Style', 'pushbutton', 'String', 'Zeige Text', ...
    'Position', [350, 50, 100, 30], ...
    'Callback', @contrButton.connect2ESP1);

% Erstellen Sie einen Button, der den in der Textbox eingegebenen Text anzeigt
%button = uicontrol('Style', 'pushbutton', 'String', 'Zeige Text', ...
    %'Position', [350, 50, 100, 30], ...
    %'Callback', @(src, event) textEntered(src,event,button)1;


% Zeigen Sie die GUI an
%guidata(fig, textbox);
guidata(fig, button);

