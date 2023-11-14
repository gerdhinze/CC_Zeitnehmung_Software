function ccHandle = initOpenCC(ccHandle)

    tab.tabDraw = uitab(ccHandle);
    tab.tabDraw.Title = 'OpenCC';
    tab.tabDraw.BackgroundColor = 'white';
    tab.tabDraw.ForegroundColor = 'black';
    tab.tabDraw = misc.drawTabHeader(tab.tabDraw, 'offener Bewerb');
    tab.tabDraw.Tag = 'OpenCC';

end

