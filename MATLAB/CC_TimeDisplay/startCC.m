clear all force;
close all force;

ccDisp = uifigure('Name','99');

ccDisp.WindowState = 'maximized';
ccDisp.ToolBar = 'none';
ccDisp.MenuBar = 'none';
ccDisp.Color = 'white';
ccDisp.Name = 'Crazy Car - FH-JOANNEUM Graz';
ccDisp.Tag = 'ccCWin';

allDispTab = uitabgroup(ccDisp);
allDispTab.Position     = [0 0 1920 1080]; %1920 1200
allDispTab.TabLocation  = "bottom";

allDispTab = initFunc.initDraw(allDispTab);
allDispTab = initFunc.initDuel(allDispTab);
allDispTab = initFunc.initMainCC(allDispTab);
allDispTab = initFunc.initOpenCC(allDispTab);
allDispTab = initFunc.initSchoolCC(allDispTab);
allDispTab = initFunc.initKOcc(allDispTab);

ccControl = uifigure('Name','999'); 
ccControl.ToolBar = 'none';
ccControl.MenuBar = 'none';
ccControl.Color = 'white';
ccControl.Name = 'Crazy Car - Control';
ccControl.Position = [50,50,750,600];

initFunc.initControlButton(ccControl);

drawnow;
