%% Start Test Programm
close all force;
clear all;
clc;

RaceData = readtable("RaceMain.csv");

%Car1 = RaceData.ID == 'B34968A6';
%Car2 = RaceData.ID == 'C344E1AA';

name = 'Car1';
Gate1 = [name,': passed Station 1 '];
Gate2 = [name,': passed Station 2 '];
Gate3 = [name,': passed Station 3 '];

idx0 = find(strcmp(RaceData.ID,'B34968A6')) ; 
idx1 = find(strcmp(RaceData.ID,'C344E1AA')) ; 

dir = 1;   %%CW
%dir = 2;  %% CCW

global Last_ID
Last_ID = 0;

Car1 = RaceData(idx0,:);
save('Car1.mat', "Car1")
Car2 = RaceData(idx1,:);
save('Car2.mat', "Car2")

i = 1;

if dir == 1 %%% CW

    for n = 1:length(idx0)

        Station = Car1.Station(i);
  
        if Station == 1
                disp(Gate1)
          
        elseif Station == 2
                disp(Gate2)
              
        elseif Station == 3
                disp(Gate3)
        end

        if i >= 2
            dout1 = dataFunc.directionCW(Car1.Station(i-1),Car1.Station(i));
            save('Car1.mat', "dout1", "-append")
            disp(dout1)
            disp(Last_ID)
        end
           i = i+1;

     end
end

if dir == 2  %%% CCW

    for n = 1:length(idx0)

        Station = Car1.Station(i);
  
        if Station == 1
                disp(Gate1)
          
        elseif Station == 2
                disp(Gate2)
              
        elseif Station == 3
                disp(Gate3)
        end

        if i >= 2
            dout1 = dataFunc.directionCCW(Car1.Station(i-1),Car1.Station(i));
            save('Car1.mat', "dout1", "-append")
            disp(dout1)
        end
           i = i+1;

     end
end

