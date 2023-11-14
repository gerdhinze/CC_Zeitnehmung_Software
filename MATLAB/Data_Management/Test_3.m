%% Start Test Programm
%close all force;
%clear all;
%clc;


%CarId1 = readtable("Auto1.csv");
%CarId2 = readtable("Auto2.csv");



% IDs of the stations
station_1.id = 1;
station_2.id = 2;
station_3.id = 3;
get_data = 1;
Last_ID = 0;


i = 1;

while get_data == 1
 
       
        disp('Auto 1');
        dataFunc.direction(CarId1.ID(i),CarId1.ID(i+1));
        %disp('Auto 2');
        %dataFunc.direction(CarId2.ID(i),CarId2.ID(i+1));
   
        i = i+1;    
        if i > 14
            get_data = 0;
        end
            
end