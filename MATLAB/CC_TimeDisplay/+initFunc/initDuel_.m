function ccHandle = initDuel(ccHandle)

    tab.Duel = uitab(ccHandle);
    tab.Duel.Title = 'DuelWindow';
    tab.Duel.BackgroundColor = 'white';
    tab.Duel.ForegroundColor = 'black';
    tab.Duel = misc.drawTabHeader(tab.Duel, 'DUELL');
    tab.Duel.Tag = 'DuelWindow';

    lblMiddleHeader = uilabel(tab.Duel);
    lblMiddleHeader.Text = 'VS';
    lblMiddleHeader.Position = [-75,425,2000,200];
    lblMiddleHeader.FontSize = 140;
    lblMiddleHeader.FontName = 'American Captain';
    lblMiddleHeader.FontWeight = 'bold';
    lblMiddleHeader.HorizontalAlignment = 'center';
    
    imDO = uiimage(tab.Duel);
    imDO.Position = [300,550,275,275];
    imDO.Tag = 'imagDODisp';

    imDT = uiimage(tab.Duel);
    imDT.Position = [1250,550,275,275];
    imDT.Tag = 'imagDTDisp';

    lblDO = uilabel(tab.Duel);
    lblDO.Text = '';
    lblDO.Position = [25,425,800,150];
    lblDO.FontSize = 90;
    lblDO.FontName = 'SPEEDKINGS';
    lblDO.FontWeight = 'bold';
    lblDO.HorizontalAlignment = 'center';
    lblDO.Tag = 'lblDODuelDisp';

    lblDT = uilabel(tab.Duel);
    lblDT.Text = '';
    lblDT.Position = [1000,425,800,150];
    lblDT.FontSize = 90;
    lblDT.FontName = 'SPEEDKINGS';
    lblDT.FontWeight = 'bold';
    lblDT.HorizontalAlignment = 'center';
    lblDT.Tag = 'lblDTDuelDisp';

    %%%%%%%%%%%% FIRST CAR LED %%%%%%%%%%%%%%%%%%
   
    mylamp1 = uilamp(tab.Duel); %first round first split time
    mylamp1.Position = [650,380,40,40];
    mylamp1.Color = 'green'; %

    mylamp2 = uilamp(tab.Duel); %first round second split time
    mylamp2.Position = [650,320,40,40];
    mylamp2.Color = 'green'; %

    mylamp3 = uilamp(tab.Duel); %first round finished
    mylamp3.Position = [75,330,80,80]; 
    mylamp3.Color = 'red'; %

    mylamp4 = uilamp(tab.Duel); %second round first split time
    mylamp4.Position = [650,260,40,40];
    mylamp4.Color = 'green'; %

    mylamp5 = uilamp(tab.Duel); %second round second split time
    mylamp5.Position = [650,200,40,40];
    mylamp5.Color = 'green'; %

    mylamp6 = uilamp(tab.Duel); %second round finished
    mylamp6.Position = [75,210,80,80];
    mylamp6.Color = 'green'; %

    mylamp7 = uilamp(tab.Duel); %third round first split time
    mylamp7.Position = [650,140,40,40];
    mylamp7.Color = 'green'; %

    mylamp8 = uilamp(tab.Duel); %third round second split time
    mylamp8.Position = [650,80,40,40];
    mylamp8.Color = 'green'; %

    mylamp9 = uilamp(tab.Duel); %thrid round finished
    mylamp9.Position = [75,90,80,80];
    mylamp9.Color = 'green'; %


    %%%%%%%%%%%% SECOND CAR LED %%%%%%%%%%%%%%%%%%

    mylamp10 = uilamp(tab.Duel); %first round first split time
    mylamp10.Position = [1575,380,40,40];
    mylamp10.Color = 'green'; %

    mylamp11 = uilamp(tab.Duel); %first round second split time
    mylamp11.Position = [1575,320,40,40];
    mylamp11.Color = 'green'; %

    mylamp12 = uilamp(tab.Duel); %first round finished
    mylamp12.Position = [1000,330,80,80];
    mylamp12.Color = 'red'; %
    
    mylamp13 = uilamp(tab.Duel); %second round first split time
    mylamp13.Position = [1575,260,40,40];
    mylamp13.Color = 'green'; %

    mylamp14 = uilamp(tab.Duel); %second round second split time
    mylamp14.Position = [1575,200,40,40];
    mylamp14.Color = 'green'; %

    mylamp15 = uilamp(tab.Duel);%second round finished
    mylamp15.Position = [1000,210,80,80];
    mylamp15.Color = 'green'; %

    mylamp16 = uilamp(tab.Duel); %third round first split time
    mylamp16.Position = [1575,140,40,40];
    mylamp16.Color = 'green'; %

    mylamp17 = uilamp(tab.Duel); %third round second split time
    mylamp17.Position = [1575,80,40,40];
    mylamp17.Color = 'green'; %

    mylamp18 = uilamp(tab.Duel); %thrid round finished
    mylamp18.Position = [1000,90,80,80];
    mylamp18.Color = 'green'; %

%%%%%%%%%%%%%%%% FIRST CAR %%%%%%%%%%%%%%%%%%%

%%% first round %%%

    lblTimeOneDO = uilabel(tab.Duel); %first round first split time
    lblTimeOneDO.Text = '00:00.000'; 
    lblTimeOneDO.Position = [625,360,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %first round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [625,300,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %first round finished
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [00,300,800,150];
    lblTimeOneDO.FontSize = 100;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

%%% second round %%%

    lblTimeOneDO = uilabel(tab.Duel); %second round first split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [625,240,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %second round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [625,180,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeTwoDO = uilabel(tab.Duel); %second round finished
    lblTimeTwoDO.Text = '00:00.000';
    lblTimeTwoDO.Position = [00,180,800,150];
    lblTimeTwoDO.FontSize = 100;
    lblTimeTwoDO.FontName = 'SPEEDKINGS';
    lblTimeTwoDO.FontWeight = 'bold';
    lblTimeTwoDO.HorizontalAlignment = 'center';
    lblTimeTwoDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeTwoDO.Tag = 'lblTimeTwoDODuelDisp';

%%% third round %%%

    lblTimeOneDO = uilabel(tab.Duel); %third round first split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [625,120,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %third round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [625,60,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeThreeDO = uilabel(tab.Duel); %third round finished
    lblTimeThreeDO.Text = '00:00.000';
    lblTimeThreeDO.Position = [00,60,800,150];
    lblTimeThreeDO.FontSize = 100;
    lblTimeThreeDO.FontName = 'SPEEDKINGS';
    lblTimeThreeDO.FontWeight = 'bold';
    lblTimeThreeDO.HorizontalAlignment = 'center';
    lblTimeThreeDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeThreeDO.Tag = 'lblTimeThreeDODuelDisp';


%%%%%%%%%%%%%%%% SECOND CAR %%%%%%%%%%%%%%%%%%%

%%% first round %%%

    lblTimeOneDO = uilabel(tab.Duel); %first round first split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,360,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %first round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,300,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDT = uilabel(tab.Duel); %first round finished
    lblTimeOneDT.Text = '00:00.000';
    lblTimeOneDT.Position = [925,300,800,150];
    lblTimeOneDT.FontSize = 100;
    lblTimeOneDT.FontName = 'SPEEDKINGS';
    lblTimeOneDT.FontWeight = 'bold';
    lblTimeOneDT.HorizontalAlignment = 'center';
    lblTimeOneDT.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDT.Tag = 'lblTimeOneDTDuelDisp';

%%% second round %%%

    lblTimeOneDO = uilabel(tab.Duel); %second round first split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,240,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %second round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,180,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeTwoDT = uilabel(tab.Duel); %second round finisehd
    lblTimeTwoDT.Text = '00:00.000';
    lblTimeTwoDT.Position = [925,180,800,150];
    lblTimeTwoDT.FontSize = 100;
    lblTimeTwoDT.FontName = 'SPEEDKINGS';
    lblTimeTwoDT.FontWeight = 'bold';
    lblTimeTwoDT.HorizontalAlignment = 'center';
    lblTimeTwoDT.FontColor = [0.7, 0.7, 0.7];
    lblTimeTwoDT.Tag = 'lblTimeTwoDTDuelDisp';

%%% third round %%%

    lblTimeOneDO = uilabel(tab.Duel); %thrid round first split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,120,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeOneDO = uilabel(tab.Duel); %thrid round second split time
    lblTimeOneDO.Text = '00:00.000';
    lblTimeOneDO.Position = [1550,60,400,80];
    lblTimeOneDO.FontSize = 50;
    lblTimeOneDO.FontName = 'SPEEDKINGS';
    lblTimeOneDO.FontWeight = 'bold';
    lblTimeOneDO.HorizontalAlignment = 'center';
    lblTimeOneDO.FontColor = [0.7, 0.7, 0.7];
    lblTimeOneDO.Tag = 'lblTimeOneDODuelDisp';

    lblTimeThreeDT = uilabel(tab.Duel); %thrid round finished
    lblTimeThreeDT.Text = '00:00.000';
    lblTimeThreeDT.Position = [925,60,800,150];
    lblTimeThreeDT.FontSize = 100;
    lblTimeThreeDT.FontName = 'SPEEDKINGS';
    lblTimeThreeDT.FontWeight = 'bold';
    lblTimeThreeDT.HorizontalAlignment = 'center';
    lblTimeThreeDT.FontColor = [0.7, 0.7, 0.7];
    lblTimeThreeDT.Tag = 'lblTimeThreeDTDuelDisp';

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







    
end

