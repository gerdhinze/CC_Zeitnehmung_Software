clear all force
close all force

setStarterCC_2023;
%%%%%% Duell Generierung %%%%%%
duel = uifigure();



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fh = uifigure();
fh.WindowState = 'maximized';
fh.ToolBar = 'none';
fh.MenuBar = 'none';
fh.Color = 'white';

ImageAVL = uiimage(fh);
ImageAVL.ImageSource = 'AVL-Logo.jpg';
ImageAVL.Position = [100,600,175,175];

ImageCC = uiimage(fh);
ImageCC.ImageSource = 'cc_jpg.jpg';
ImageCC.Position = [1400,575,350,200];

header = {'Position', 'Teamname', 'Bildungseinrichtung', 'Runden', 'Zeit', 'Meter'};

tableHeaderText = sprintf(['%s\t\t\t%s\t\t\t%s\t\t\t%s\t\t\t%s\t\t\t%s'], header{1}, header{2}, header{3}, header{4}, header{5}, header{6});
tableHeader = uilabel(fh);
tableHeader.Text = tableHeaderText;
tableHeader.Position = [95,525,1800,58];
tableHeader.FontSize = 50;
tableHeader.FontName = 'American Captain';
tableHeader.FontWeight = 'bold';

tableCC.Pos = uilabel(fh);
tableCC.Name = uilabel(fh);
tableCC.Inst = uilabel(fh);
tableCC.Rnd = uilabel(fh);
tableCC.Time = uilabel(fh);
tableCC.Meter = uilabel(fh);

tableTextPos = [];
tableTextName = [];
tableTextInst = [];
tableTextRnd = [];
tableTextTime = [];
tableTextMeter = [];
numTN = size(TNData,1);
for idxTb = 1:numTN-2
    if strcmp(TNData.Bewerb(idxTb), 'Standardbewerb')
            tableTextPos =      [tableTextPos,sprintf('%s\n',num2str(idxTb))];
            tableTextName =     [tableTextName,sprintf('%s\n',TNData.Teamname{idxTb})];
            tableTextInst =     [tableTextInst,sprintf('%s\n',TNData.Bildungseinrichtung{idxTb})];
            tableTextRnd =      [tableTextRnd,sprintf('%s\n',num2str(TNData.Runden(idxTb)))];
            tableTextTime =     [tableTextTime,sprintf('%s\n',TNData.Zeit{idxTb})];
            tableTextMeter =    [tableTextMeter,sprintf('%s\n',num2str(TNData.Meter(idxTb)))];
    end
end

hOffset = -310;
fontSizeRes = 45;
fontNameRes = 'SPEEDKINGS';

tableCC.Pos.Text = tableTextPos;
tableCC.Name.Text = tableTextName;
tableCC.Inst.Text = tableTextInst;
tableCC.Rnd.Text = tableTextRnd;
tableCC.Time.Text = tableTextTime;
tableCC.Meter.Text = tableTextMeter;

tableCC.Pos.Position = [160,hOffset,300,900];
tableCC.Name.Position = [350,hOffset,300,900];
tableCC.Inst.Position = [775,hOffset,300,900];
tableCC.Rnd.Position = [1250,hOffset,300,900];
tableCC.Time.Position = [1425,hOffset,300,900];
tableCC.Meter.Position = [1700,hOffset,300,900];

tableCC.Pos.FontName = fontNameRes;
tableCC.Name.FontName = fontNameRes;
tableCC.Inst.FontName = fontNameRes;
tableCC.Rnd.FontName = fontNameRes;
tableCC.Time.FontName = fontNameRes;
tableCC.Meter.FontName = fontNameRes;

tableCC.Pos.FontSize = fontSizeRes;
tableCC.Name.FontSize = fontSizeRes;
tableCC.Inst.FontSize = fontSizeRes;
tableCC.Rnd.FontSize = fontSizeRes;
tableCC.Time.FontSize = fontSizeRes;
tableCC.Meter.FontSize = fontSizeRes;

%%%% TABLE %%%%





