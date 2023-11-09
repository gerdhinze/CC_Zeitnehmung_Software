clear all force;
close all force;

ccControlESP = uifigure('Name','ESP Control Panel');
ccControlESP.ToolBar = 'none';
ccControlESP.MenuBar = 'none';
ccControlESP.Color = 'white';
ccControlESP.Name = 'Crazy Car - ESP Control Panel';
ccControlESP.Position = [50,50,750,600];

initFunc.initControlESP(ccControlESP);