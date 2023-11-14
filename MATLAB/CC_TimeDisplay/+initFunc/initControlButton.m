function initControlButton(ccHandle)

    %%% Start Draw Button
    bt.stDraw = uibutton(ccHandle);
    bt.stDraw.Text = 'Auslosung Start';
    bt.stDraw.Tag = 'stAuslosung';
    bt.stDraw.Position = [50,550,175,25];
    bt.stDraw.FontSize = 16;
    bt.stDraw.ButtonPushedFcn = @ctrlBut.bt_duelgen;

    %%% Load Draw 
    bt.ldDraw = uibutton(ccHandle);
    bt.ldDraw.Text = 'Auslosung Laden';
    bt.ldDraw.Tag = 'ldAuslosung';
    bt.ldDraw.Position = [50,520,175,25];
    bt.ldDraw.FontSize = 16;
    bt.ldDraw.ButtonPushedFcn = @ctrlBut.bt_loadDuelgen;

    allCCTab = uitabgroup(ccHandle);
    allCCTab.Position     = [0 0 750 375];
    allCCTab.TabLocation  = "top";

    cctab.tabBOne = uitab(allCCTab);
    cctab.tabBOne.Title = 'BlockOne';
    cctab.tabBOne.BackgroundColor = 'white';
    cctab.tabBOne.ForegroundColor = 'black';
    cctab.tabBOne.Tag = 'BlockOne';
    initFunc.initDuelFormat(cctab.tabBOne,'BO');
    data.idx = 1;
    guidata(cctab.tabBOne,data);

    cctab.tabBTwo = uitab(allCCTab);
    cctab.tabBTwo.Title = 'BlockTwo';
    cctab.tabBTwo.BackgroundColor = 'white';
    cctab.tabBTwo.ForegroundColor = 'black';
    cctab.tabBTwo.Tag = 'BlockTwo';
    initFunc.initDuelFormat(cctab.tabBTwo,'BTw');
    data.idx = 1;
    guidata(cctab.tabBOne,data);

    cctab.tabVF = uitab(allCCTab);
    cctab.tabVF.Title = 'QuarterFinal';
    cctab.tabVF.BackgroundColor = 'white';
    cctab.tabVF.ForegroundColor = 'black';
    cctab.tabVF.Tag = 'QuarterFinal';
    initFunc.initDuelFormat(cctab.tabVF,'VF');
    data.idx = 1;
    guidata(cctab.tabBOne,data);

    cctab.tabSF = uitab(allCCTab);
    cctab.tabSF.Title = 'SemiFinal';
    cctab.tabSF.BackgroundColor = 'white';
    cctab.tabSF.ForegroundColor = 'black';
    cctab.tabSF.Tag = 'SemiFinal';
    initFunc.initDuelFormat(cctab.tabSF,'SF');
    data.idx = 1;
    guidata(cctab.tabBOne,data);

    cctab.tabkF = uitab(allCCTab);
    cctab.tabkF.Title = 'SmallFinal';
    cctab.tabkF.BackgroundColor = 'white';
    cctab.tabkF.ForegroundColor = 'black';
    cctab.tabkF.Tag = 'SmallFinal';
    initFunc.initDuelFormat(cctab.tabkF,'KF');
    data.idx = 1;
    guidata(cctab.tabBOne,data);

    cctab.tabFinal = uitab(allCCTab);
    cctab.tabFinal.Title = 'Final';
    cctab.tabFinal.BackgroundColor = 'white';
    cctab.tabFinal.ForegroundColor = 'black';
    cctab.tabFinal.Tag = 'Final';
    initFunc.initDuelFormat(cctab.tabFinal,'FIN');
    data.idx = 1;
    guidata(cctab.tabBOne,data);
   
end

