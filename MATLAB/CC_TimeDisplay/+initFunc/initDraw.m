function ccHandle = initDraw(ccHandle)

    tab.tabDraw = uitab(ccHandle);
    tab.tabDraw.Title = 'CCDraw';
    tab.tabDraw.BackgroundColor = 'white';
    tab.tabDraw.ForegroundColor = 'black';
    tab.tabDraw = misc.drawTabHeader(tab.tabDraw, 'Auslosung');
    tab.tabDraw.Tag = 'CCDraw';

    lblFreilosName = uilabel(tab.tabDraw);
    lblFreilosTxt = 'Freilos:';
    lblFreilosName.Position = [200,700,500,95];
    lblFreilosName.FontSize = 80;
    lblFreilosName.FontName = 'American Captain';
    lblFreilosName.FontWeight = 'bold';
    lblFreilosName.HorizontalAlignment = 'center';
    lblFreilosName.Text = lblFreilosTxt;

    lblFreilosTeam = uilabel(tab.tabDraw);
    lblFreilosTeam.Text = '';
    lblFreilosTeam.Position = [600,695,700,90];
    lblFreilosTeam.FontSize = 75;
    lblFreilosTeam.FontName = 'SPEEDKINGS';
    lblFreilosTeam.Tag = 'FreilosTeam';
    
    
    lblMiddle = uilabel(tab.tabDraw);
    lblMiddle.Position = [850,-50,100,800];
    lblMiddle.FontSize = 75;
    lblMiddle.FontName = 'American Captain';
    lblMiddle.FontWeight = 'bold';
    lblMiddle.Text = '';   
    lblMiddle.Tag = 'DrawColMiddle';

    lblColOne = uilabel(tab.tabDraw);
    lblColOne.Position = [250,-50,600,800];
    lblColOne.FontSize = 75;
    lblColOne.FontName = 'SPEEDKINGS';
    lblColOne.Text = '';
    lblColOne.Tag = 'DrawColOne';

    lblColTwo = uilabel(tab.tabDraw);
    lblColTwo.Position = [1100,-50,600,800];
    lblColTwo.FontSize = 75;
    lblColTwo.FontName = 'SPEEDKINGS';
    lblColTwo.Text = '';
    lblColTwo.Tag = 'DrawColTwo';

end

