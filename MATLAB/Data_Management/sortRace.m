%% Start Test Programm
close all force;
clear all;
clc;

RaceData = readtable("RaceMain.csv");

%Car1 = RaceData.ID == 'B34968A6';
%Car2 = RaceData.ID == 'C344E1AA';

idx0 = find(strcmp(RaceData.ID,'B34968A6')) ; 
idx1 = find(strcmp(RaceData.ID,'C344E1AA')) ; 

Car1 = RaceData(idx0,:);
save('Car1.mat', "Car1")
Car2 = RaceData(idx1,:);
save('Car2.mat', "Car2")



