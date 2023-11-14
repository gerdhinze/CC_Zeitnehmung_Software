function ccHandle = initKOcc(ccHandle)

    tab.TKO = uitab(ccHandle);
    tab.TKO.Title = 'CCKO-Tournament';
    tab.TKO.BackgroundColor = 'white';
    tab.TKO.ForegroundColor = 'black';
    tab.TKO = misc.drawTabHeader(tab.TKO, 'KO-MODUS');
    tab.TKO.Tag = 'CCKO';

    imQFOne = uiimage(tab.TKO);
    imQFOne.Position = [125,525,425,400];
    imQFOne.Tag = 'imagTKQFOne';
    imQFOne.ImageSource = 'TKImg\QFImg.png';

    imQFTwo = uiimage(tab.TKO);
    imQFTwo.Position = [125,325,425,400];
    imQFTwo.Tag = 'imagTKQFTwo';
    imQFTwo.ImageSource = 'TKImg\QFImg.png';

    imQFThree = uiimage(tab.TKO);
    imQFThree.Position = [125,125,425,400];
    imQFThree.Tag = 'imagTKQFThree';
    imQFThree.ImageSource = 'TKImg\QFImg.png';

    imQFFour = uiimage(tab.TKO);
    imQFFour.Position = [125,-75,425,400];
    imQFFour.Tag = 'imagTKQFThree';
    imQFFour.ImageSource = 'TKImg\QFImg.png';

    imHFOne = uiimage(tab.TKO);
    imHFOne.Position = [575,425,425,400];
    imHFOne.Tag = 'imagTKHFOne';
    imHFOne.ImageSource = 'TKImg\QFImg.png';

    lblHF = uilabel(tab.TKO);
    lblHF.Position = [515,580,425,400];
    lblHF.Text = 'HF';
    lblHF.FontSize = 75;
    lblHF.FontName = 'American Captain';
    lblHF.FontWeight = 'bold';
    lblHF.HorizontalAlignment = 'center';

    imHFTwo = uiimage(tab.TKO);
    imHFTwo.Position = [575,25,425,400];
    imHFTwo.Tag = 'imagTKHFTwo';
    imHFTwo.ImageSource = 'TKImg\QFImg.png';

    lblSmFin = uilabel(tab.TKO);
    lblSmFin.Position = [960,375,425,400];
    lblSmFin.Text = 'kl. Finale';
    lblSmFin.FontSize = 75;
    lblSmFin.FontName = 'American Captain';
    lblSmFin.FontWeight = 'bold';
    lblSmFin.HorizontalAlignment = 'center';

    imSmFin = uiimage(tab.TKO);
    imSmFin.Position = [1000,250,350,350];
    imSmFin.Tag = 'imagTKSmFin';
    imSmFin.ImageSource = 'TKImg\finals.png';

    lblFin = uilabel(tab.TKO);
    lblFin.Position = [1350,375,425,400];
    lblFin.Text = 'Finale';
    lblFin.FontSize = 75;
    lblFin.FontName = 'American Captain';
    lblFin.FontWeight = 'bold';
    lblFin.HorizontalAlignment = 'center';

    imFin = uiimage(tab.TKO);
    imFin.Position = [1400,250,350,350];
    imFin.Tag = 'imagTKSmFin';
    imFin.ImageSource = 'TKImg\finals.png';

    %%%%%%%%%% Participants %%%%%%%%%%%%%%

    lblQFFirst = uilabel(tab.TKO);
    lblQFFirst.Position = [120,705,300,125];
    lblQFFirst.Tag = 'lblQF1';
    lblQFFirst.Text = '';
    lblQFFirst.FontSize = 37;
    lblQFFirst.FontName = 'SPEEDKINGS';
    lblQFFirst.HorizontalAlignment = 'center';

    lblQFSecond = uilabel(tab.TKO);
    lblQFSecond.Position = [120,625,300,125];
    lblQFSecond.Tag = 'lblQF2';
    lblQFSecond.Text = '';
    lblQFSecond.FontSize = 37;
    lblQFSecond.FontName = 'SPEEDKINGS';
    lblQFSecond.HorizontalAlignment = 'center';

    lblQFThird = uilabel(tab.TKO);
    lblQFThird.Position = [120,505,300,125];
    lblQFThird.Tag = 'lblQF3';
    lblQFThird.Text = '';
    lblQFThird.FontSize = 37;
    lblQFThird.FontName = 'SPEEDKINGS';
    lblQFThird.HorizontalAlignment = 'center';

    lblQFFourth = uilabel(tab.TKO);
    lblQFFourth.Position = [120,425,300,125];
    lblQFFourth.Tag = 'lblQF4';
    lblQFFourth.Text = '';
    lblQFFourth.FontSize = 37;
    lblQFFourth.FontName = 'SPEEDKINGS';
    lblQFFourth.HorizontalAlignment = 'center';

    lblQF5 = uilabel(tab.TKO);
    lblQF5.Position = [120,305,300,125];
    lblQF5.Tag = 'lblQF5';
    lblQF5.Text = '';
    lblQF5.FontSize = 37;
    lblQF5.FontName = 'SPEEDKINGS';
    lblQF5.HorizontalAlignment = 'center';

    lblQF6 = uilabel(tab.TKO);
    lblQF6.Position = [120,225,300,125];
    lblQF6.Tag = 'lblQF6';
    lblQF6.Text = '';
    lblQF6.FontSize = 37;
    lblQF6.FontName = 'SPEEDKINGS';
    lblQF6.HorizontalAlignment = 'center';

    lblQF7 = uilabel(tab.TKO);
    lblQF7.Position = [120,105,300,125];
    lblQF7.Tag = 'lblQF7';
    lblQF7.Text = '';
    lblQF7.FontSize = 37;
    lblQF7.FontName = 'SPEEDKINGS';
    lblQF7.HorizontalAlignment = 'center';

    lblQF8 = uilabel(tab.TKO);
    lblQF8.Position = [120,25,300,125];
    lblQF8.Tag = 'lblQF8';
    lblQF8.Text = '';
    lblQF8.FontSize = 37;
    lblQF8.FontName = 'SPEEDKINGS';
    lblQF8.HorizontalAlignment = 'center';

    %%% HF %%%

    lblHF1 = uilabel(tab.TKO);
    lblHF1.Position = [575,605,300,125];
    lblHF1.Tag = 'lblHF1';
    lblHF1.Text = '';
    lblHF1.FontSize = 37;
    lblHF1.FontName = 'SPEEDKINGS';
    lblHF1.HorizontalAlignment = 'center';

    lblHF2 = uilabel(tab.TKO);
    lblHF2.Position = [575,525,300,125];
    lblHF2.Tag = 'lblHF2';
    lblHF2.Text = '';
    lblHF2.FontSize = 37;
    lblHF2.FontName = 'SPEEDKINGS';
    lblHF2.HorizontalAlignment = 'center';

    lblHF3 = uilabel(tab.TKO);
    lblHF3.Position = [575,205,300,125];
    lblHF3.Tag = 'lblHF3';
    lblHF3.Text = '';
    lblHF3.FontSize = 37;
    lblHF3.FontName = 'SPEEDKINGS';
    lblHF3.HorizontalAlignment = 'center';

    lblHF4 = uilabel(tab.TKO);
    lblHF4.Position = [575,125,300,125];
    lblHF4.Tag = 'lblHF4';
    lblHF4.Text = '';
    lblHF4.FontSize = 37;
    lblHF4.FontName = 'SPEEDKINGS';
    lblHF4.HorizontalAlignment = 'center';

    %%%%%% kleines Finale %%%%%%

    lblKF1 = uilabel(tab.TKO);
    lblKF1.Position = [1020,410,300,125];
    lblKF1.Tag = 'lblKF1';
    lblKF1.Text = '';
    lblKF1.FontSize = 37;
    lblKF1.FontName = 'SPEEDKINGS';
    lblKF1.HorizontalAlignment = 'center';

    lblKF2 = uilabel(tab.TKO);
    lblKF2.Position = [1020,320,300,125];
    lblKF2.Tag = 'lblKF2';
    lblKF2.Text = '';
    lblKF2.FontSize = 37;
    lblKF2.FontName = 'SPEEDKINGS';
    lblKF2.HorizontalAlignment = 'center';

    %%%%%% Finale %%%%%%

    lblF1 = uilabel(tab.TKO);
    lblF1.Position = [1425,410,300,125];
    lblF1.Tag = 'lblF1';
    lblF1.Text = '';
    lblF1.FontSize = 37;
    lblF1.FontName = 'SPEEDKINGS';
    lblF1.HorizontalAlignment = 'center';

    lblF2 = uilabel(tab.TKO);
    lblF2.Position = [1425,320,300,125];
    lblF2.Tag = 'lblF2';
    lblF2.Text = '';
    lblF2.FontSize = 37;
    lblF2.FontName = 'SPEEDKINGS';
    lblF2.HorizontalAlignment = 'center';

    %%%%%%%%%%%%%%%%%%%%
    %%%% Fastest Block %%%%
    lblFastestBlock = uilabel(tab.TKO);
    lblFastestBlock.Text = 'Schnellster Rennblock:';
    lblFastestBlock.Position = [860,65,550,58];
    lblFastestBlock.FontSize = 40;
    lblFastestBlock.FontName = 'American Captain';
    lblFastestBlock.FontWeight = 'bold';

    %%%% Fastest Round %%%%
    lblFastestRnd = uilabel(tab.TKO);
    lblFastestRnd.Text = 'Schnellste Runde:';
    lblFastestRnd.Position = [950,20,400,58];
    lblFastestRnd.FontSize = 40;
    lblFastestRnd.FontName = 'American Captain';
    lblFastestRnd.FontWeight = 'bold';

    %%%% Fastest Block %%%%
    lblFastestBlockTeam = uilabel(tab.TKO,'Tag','lblFastestTeamBlock2');
    lblFastestBlockTeam.Text = '';
    lblFastestBlockTeam.Position = [1250,65,400,58];
    lblFastestBlockTeam.FontSize = 40;
    lblFastestBlockTeam.FontName = 'SPEEDKINGS';
    %lblFastestBlockTime.FontWeight = 'bold';

    lblFastestBlockTime = uilabel(tab.TKO,'Tag','lblFastestTimeBlock2');
    lblFastestBlockTime.Text = '';
    lblFastestBlockTime.Position = [1550,65,400,58];
    lblFastestBlockTime.FontSize = 40;
    lblFastestBlockTime.FontName = 'SPEEDKINGS';
    %lblFastestBlockTime.FontWeight = 'bold';

    %%%% Fastest Block %%%%
    lblFastestRndTeam = uilabel(tab.TKO,'Tag','lblFastestTeamRnd2');
    lblFastestRndTeam.Text = '';
    lblFastestRndTeam.Position = [1250,20,400,58];
    lblFastestRndTeam.FontSize = 40;
    lblFastestRndTeam.FontName = 'SPEEDKINGS';
    %lblFastestBlockTime.FontWeight = 'bold';

    lblFastestRndTime = uilabel(tab.TKO,'Tag','lblFastestTimeRnd2');
    lblFastestRndTime.Text = '';
    lblFastestRndTime.Position = [1550,20,400,58];
    lblFastestRndTime.FontSize = 40;
    lblFastestRndTime.FontName = 'SPEEDKINGS';

end

