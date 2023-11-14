function initDuelFormat(ccHandle,strShortCut)

    bt.lstDuel = uibutton(ccHandle);
    bt.lstDuel.Text = '<';
    bt.lstDuel.Tag = ['lstDuel'];
    bt.lstDuel.Position = [200,250,50,25];
    bt.lstDuel.FontSize = 16;
    bt.lstDuel.FontWeight = 'bold';
    bt.lstDuel.ButtonPushedFcn = @ctrlBut.bt_lastDuel;

    bt.nxtDuel = uibutton(ccHandle);
    bt.nxtDuel.Text = '>';
    bt.nxtDuel.Tag = ['nxtDuel'];
    bt.nxtDuel.Position = [500,250,50,25];
    bt.nxtDuel.FontSize = 16;
    bt.nxtDuel.FontWeight = 'bold';
    bt.nxtDuel.ButtonPushedFcn = @ctrlBut.bt_nextDuel;

    bt.nxtDuel = uibutton(ccHandle);
    bt.nxtDuel.Text = 'CheckDuel';
    bt.nxtDuel.Tag = ['checkDuel'];
    bt.nxtDuel.Position = [500,300,100,25];
    bt.nxtDuel.FontSize = 16;
    bt.nxtDuel.FontWeight = 'bold';
    bt.nxtDuel.ButtonPushedFcn = @ctrlBut.bt_checkDuel;

    %%%%%% FIRST CAR %%%%%%%%

    ef.MeterOneDO = uieditfield(ccHandle);
    ef.MeterOneDO.Tag = ['MeterOneDO'];
    ef.MeterOneDO.Position = [15,125,30,25];
    ef.MeterOneDO.FontSize = 14;
    ef.MeterOneDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndOneDO = uieditfield(ccHandle); % first round first split time
    ef.rndOneDO.Tag = ['rndOneSp1DO'];
    ef.rndOneDO.Position = [60,125,80,25];
    ef.rndOneDO.FontSize = 14;
    ef.rndOneDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndOneDO = uieditfield(ccHandle); % first round second split time
    ef.rndOneDO.Tag = ['rndOneSp2DO'];
    ef.rndOneDO.Position = [160,125,80,25];
    ef.rndOneDO.FontSize = 14;
    ef.rndOneDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndOneDO = uieditfield(ccHandle); % first round finish
    ef.rndOneDO.Tag = ['rndOneDO'];
    ef.rndOneDO.Position = [260,125,80,25];
    ef.rndOneDO.FontSize = 14;
    ef.rndOneDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.MeterTwoDO = uieditfield(ccHandle); 
    ef.MeterTwoDO.Tag = ['MeterTwoDO'];
    ef.MeterTwoDO.Position = [15,75,30,25];
    ef.MeterTwoDO.FontSize = 14;
    ef.MeterTwoDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndTwoDO = uieditfield(ccHandle); % second round first split time
    ef.rndTwoDO.Tag = ['rndTwoSp1DO'];
    ef.rndTwoDO.Position = [60,75,80,25];
    ef.rndTwoDO.FontSize = 14;
    ef.rndTwoDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndTwoDO = uieditfield(ccHandle); % second round second split time
    ef.rndTwoDO.Tag = ['rndTwoSp2DO'];
    ef.rndTwoDO.Position = [160,75,80,25];
    ef.rndTwoDO.FontSize = 14;
    ef.rndTwoDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndTwoDO = uieditfield(ccHandle); % second round finish
    ef.rndTwoDO.Tag = ['rndTwoDO'];
    ef.rndTwoDO.Position = [260,75,80,25];
    ef.rndTwoDO.FontSize = 14;
    ef.rndTwoDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.MeterThreeDO = uieditfield(ccHandle);
    ef.MeterThreeDO.Tag = ['MeterThreeDO'];
    ef.MeterThreeDO.Position = [15,25,30,25];
    ef.MeterThreeDO.FontSize = 14;
    ef.MeterThreeDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndThreeDO = uieditfield(ccHandle); % third round first split time
    ef.rndThreeDO.Tag = ['rndThreeSp1DO'];
    ef.rndThreeDO.Position = [60,25,80,25];
    ef.rndThreeDO.FontSize = 14;
    ef.rndThreeDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndThreeDO = uieditfield(ccHandle); % third round second split time
    ef.rndThreeDO.Tag = ['rndThreeSp2DO'];
    ef.rndThreeDO.Position = [160,25,80,25];
    ef.rndThreeDO.FontSize = 14;
    ef.rndThreeDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndThreeDO = uieditfield(ccHandle); % third round finish
    ef.rndThreeDO.Tag = ['rndThreeDO'];
    ef.rndThreeDO.Position = [260,25,80,25];
    ef.rndThreeDO.FontSize = 14;
    ef.rndThreeDO.ValueChangedFcn = @ctrlBut.edit_valChange;

    %%%%%% SECOND CAR %%%%%%%%
 
    ef.rndOneDT = uieditfield(ccHandle);
    ef.rndOneDT.Tag = ['rndOneSp1DT'];
    ef.rndOneDT.Position = [400,125,80,25];
    ef.rndOneDT.FontSize = 14;
    ef.rndOneDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndOneDT = uieditfield(ccHandle);
    ef.rndOneDT.Tag = ['rndOneSp2DT'];
    ef.rndOneDT.Position = [500,125,80,25];
    ef.rndOneDT.FontSize = 14;
    ef.rndOneDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndOneDT = uieditfield(ccHandle);
    ef.rndOneDT.Tag = ['rndOneDT'];
    ef.rndOneDT.Position = [600,125,80,25];
    ef.rndOneDT.FontSize = 14;
    ef.rndOneDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.MeterOneDT = uieditfield(ccHandle);
    ef.MeterOneDT.Tag = ['MeterOneDT'];
    ef.MeterOneDT.Position = [700,125,30,25];
    ef.MeterOneDT.FontSize = 14;
    ef.MeterOneDT.ValueChangedFcn = @ctrlBut.edit_valChange;


    ef.rndTwoDT = uieditfield(ccHandle);
    ef.rndTwoDT.Tag = ['rndTwoSp1DT'];
    ef.rndTwoDT.Position = [400,75,80,25];
    ef.rndTwoDT.FontSize = 14;
    ef.rndTwoDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndTwoDT = uieditfield(ccHandle);
    ef.rndTwoDT.Tag = ['rndTwoSp2DT'];
    ef.rndTwoDT.Position = [500,75,80,25];
    ef.rndTwoDT.FontSize = 14;
    ef.rndTwoDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndTwoDT = uieditfield(ccHandle);
    ef.rndTwoDT.Tag = ['rndTwoDT'];
    ef.rndTwoDT.Position = [600,75,80,25];
    ef.rndTwoDT.FontSize = 14;
    ef.rndTwoDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.MeterTwoDT = uieditfield(ccHandle);
    ef.MeterTwoDT.Tag = ['MeterTwoDT'];
    ef.MeterTwoDT.Position = [700,75,30,25];
    ef.MeterTwoDT.FontSize = 14;
    ef.MeterTwoDT.ValueChangedFcn = @ctrlBut.edit_valChange;


    ef.rndThreeDT = uieditfield(ccHandle);
    ef.rndThreeDT.Tag = ['rndThreeSp1DT'];
    ef.rndThreeDT.Position = [400,25,80,25];
    ef.rndThreeDT.FontSize = 14;
    ef.rndThreeDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndThreeDT = uieditfield(ccHandle);
    ef.rndThreeDT.Tag = ['rndThreeSp2DT'];
    ef.rndThreeDT.Position = [500,25,80,25];
    ef.rndThreeDT.FontSize = 14;
    ef.rndThreeDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.rndThreeDT = uieditfield(ccHandle);
    ef.rndThreeDT.Tag = ['rndThreeDT'];
    ef.rndThreeDT.Position = [600,25,80,25];
    ef.rndThreeDT.FontSize = 14;
    ef.rndThreeDT.ValueChangedFcn = @ctrlBut.edit_valChange;

    ef.MeterThreeDT = uieditfield(ccHandle);
    ef.MeterThreeDT.Tag = ['MeterThreeDT'];
    ef.MeterThreeDT.Position = [700,25,30,25];
    ef.MeterThreeDT.FontSize = 14;
    ef.MeterThreeDT.ValueChangedFcn = @ctrlBut.edit_valChange;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    lbl.DuellerOne = uilabel(ccHandle);
    lbl.DuellerOne.Text = '';
    lbl.DuellerOne.Tag = ['lblDO'];
    lbl.DuellerOne.FontSize = 24;
    lbl.DuellerOne.FontWeight = 'bold';
    lbl.DuellerOne.Position = [75,190,275,50];
    lbl.DuellerOne.HorizontalAlignment = 'center';

    lbl.DuellerTwo = uilabel(ccHandle);
    lbl.DuellerTwo.Text = '';
    lbl.DuellerTwo.Tag = ['lblDT'];
    lbl.DuellerTwo.FontSize = 24;
    lbl.DuellerTwo.Position = [400,190,275,50];
    lbl.DuellerTwo.FontWeight = 'bold';
    lbl.DuellerTwo.HorizontalAlignment = 'center';

    bt.ldData = uibutton(ccHandle);
    bt.ldData.Text = 'Lade Daten';
    bt.ldData.Tag = [strShortCut,'ldBlock'];
    bt.ldData.Position = [25,300,100,25];
    bt.ldData.FontSize = 16;
    bt.ldData.ButtonPushedFcn = @ctrlBut.bt_loadBlockData;

    bt.genNxtStg = uibutton(ccHandle);
    bt.genNxtStg.Text = 'Gen Next Stage';
    bt.genNxtStg.Tag = ['genNextStg'];
    bt.genNxtStg.Position = [125,300,125,25];
    bt.genNxtStg.FontSize = 16;
    bt.genNxtStg.ButtonPushedFcn = @ctrlBut.bt_genNextStage;

    lbl.DuelCnt = uilabel(ccHandle);
    lbl.DuelCnt.Text = '';
    lbl.DuelCnt.FontSize = 24;
    lbl.DuelCnt.Position = [350,240,50,50];
    lbl.DuelCnt.Tag = ['duelCnt'];
    lbl.DuelCnt.FontWeight = 'bold';
    lbl.DuelCnt.HorizontalAlignment = 'center';

    %%% display first car %%%

    lbl.MeterOneHeader = uilabel(ccHandle);
    lbl.MeterOneHeader.Text = 'Meter';
    lbl.MeterOneHeader.FontSize = 18;
    lbl.MeterOneHeader.FontWeight = 'bold';
    lbl.MeterOneHeader.Position = [-105,150,275,50];
    lbl.MeterOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = '1.ZwZeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [-30,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = '2.ZwZeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [70,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = 'Rundenzeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [170,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';

    %%% display second car %%%

    lbl.MeterOneHeader = uilabel(ccHandle);
    lbl.MeterOneHeader.Text = 'Meter';
    lbl.MeterOneHeader.FontSize = 18;
    lbl.MeterOneHeader.FontWeight = 'bold';
    lbl.MeterOneHeader.Position = [580,150,275,50];
    lbl.MeterOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = '1.ZwZeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [300,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = '2.ZwZeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [400,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';

    lbl.TimeOneHeader = uilabel(ccHandle);
    lbl.TimeOneHeader.Text = 'Rundenzeit';
    lbl.TimeOneHeader.FontSize = 18;
    lbl.TimeOneHeader.FontWeight = 'bold';
    lbl.TimeOneHeader.Position = [500,150,275,50];
    lbl.TimeOneHeader.HorizontalAlignment = 'center';
end

