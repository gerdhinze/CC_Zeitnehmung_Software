function ccHandle = initSchoolCC(ccHandle)

    tab.SchoolCC = uitab(ccHandle);
    tab.SchoolCC.Title = 'SchoolCC';
    tab.SchoolCC.BackgroundColor = 'white';
    tab.SchoolCC.ForegroundColor = 'black';
    tab.SchoolCC = misc.drawTabHeader(tab.SchoolCC, 'SCHUELERBEWERB');
    tab.SchoolCC.Tag = 'SchoolCC';

    header = {'Position', 'Teamname', 'Bildungseinrichtung', 'Runden', 'Zeit', 'Meter'};
    
    tableHeaderText = sprintf(['%s\t\t\t%s\t\t\t%s\t\t\t%s\t\t\t%s\t\t\t%s'], header{1}, header{2}, header{3}, header{4}, header{5}, header{6});
    tableHeader = uilabel(tab.SchoolCC);
    tableHeader.Text = tableHeaderText;
    tableHeader.Position = [95,775,1800,58];
    tableHeader.FontSize = 50;
    tableHeader.FontName = 'American Captain';
    tableHeader.FontWeight = 'bold';
    
    tableCC.Pos = uilabel(tab.SchoolCC,'Tag','Pos');
    tableCC.Name = uilabel(tab.SchoolCC,'Tag','Name');
    tableCC.Inst = uilabel(tab.SchoolCC,'Tag','Inst');
    tableCC.Rnd = uilabel(tab.SchoolCC,'Tag','Rnd');
    tableCC.Time = uilabel(tab.SchoolCC,'Tag','Time');
    tableCC.Meter = uilabel(tab.SchoolCC,'Tag','Meter');

    tableCC.Pos.VerticalAlignment = 'top';
    tableCC.Name.VerticalAlignment = 'top';
    tableCC.Inst.VerticalAlignment = 'top';
    tableCC.Rnd.VerticalAlignment = 'top';
    tableCC.Time.VerticalAlignment = 'top';
    tableCC.Meter.VerticalAlignment = 'top';


    hOffset = -140;
    fontSizeRes = 40;
    fontNameRes = 'SPEEDKINGS';
    
    tableCC.Pos.Position = [160,hOffset,300,900];
    tableCC.Name.Position = [375,hOffset,300,900];
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


end

