function [Stored_Entry] = newEntry(ID_A,ID_B,dir)

global Last_ID
Last_ID = 0;
global ID_Next_Station
ID_Next_Station = 0;

Car_ID_A = ID_A;
Car_ID_B = ID_B;

Stored_Entry = 0;

Race = readtable("Race.csv");
GUI_Data_A = './GUI_Data_A.csv';
GUI_Data_B = './GUI_Data_B.csv';

idxA = find(strcmp(Race.ID,Car_ID_A)); 
idxB = find(strcmp(Race.ID,Car_ID_B)); 

CarA = Race(idxA,:);
CarB = Race(idxB,:);
save('CarA.mat', "CarA")
save('CarB.mat', "CarB")
              
nameA = 'Car A';
Gate1 = [nameA,': passed Station 1 '];
Gate2 = [nameA,': passed Station 2 '];
Gate3 = [nameA,': passed Station 3 '];

nameB = 'Car B';
Gate4 = [nameB,': passed Station 1 '];
Gate5 = [nameB,': passed Station 2 '];
Gate6 = [nameB,': passed Station 3 '];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Car A %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ID_A
    if dir == 1 %CCW

        for n = 1:length(idxA)

    
            StationCarA = CarA.Station(n);

            if n < 2
                if StationCarA == 1
                    disp(Gate1)
          
                elseif StationCarA == 2
                    disp(Gate2)
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_A, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
              
                elseif StationCarA == 3
                    disp(Gate3)
                end

            elseif n >= 2    
                if StationCarA == 1
                    disp(Gate1)
          
                elseif StationCarA == 2
                    disp(Gate2)
              
                elseif StationCarA == 3
                    disp(Gate3)
                end

                [dout, dOutDisp,Last_ID] = dataFunc.directionCCW(CarA.Station(n-1),CarA.Station(n));
                disp(dOutDisp)
                if Last_ID ~= 0
                    disp(Last_ID)
                end

                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_A, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end

                end
                if n == length(idxA)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end

    if dir == 2 %CW

        for n = 1:length(idx0)
    
            StationCarA = CarA.Station(n);

            if n < 2
                if StationCarA == 1
                    disp(Gate1)
          
                elseif StationCarA == 2
                    disp(Gate2)
              
                elseif StationCarA == 3
                    disp(Gate3)
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_A, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end   

            elseif n >= 2    
                if StationCarA == 1
                    disp(Gate1)
          
                elseif StationCarA == 2
                    disp(Gate2)
              
                elseif StationCarA == 3
                    disp(Gate3)
                end

                [dout, dOutDisp,Last_ID] = dataFunc.directionCW(CarA.Station(n-1),CarA.Station(n));
                disp(dOutDisp)
                if Last_ID ~= 0
                    disp(Last_ID)
                end
            
                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end
                if n == length(idxA)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Car B %%%%%%%%%%%%%%%%%%%%%%%%%%%%
if ID_B
    if dir == 1 %CCW

        for n = 1:length(idxB)

    
            StationCarB = CarB.Station(n);

            if n < 2
                if StationCarB == 1
                    disp(Gate4)
          
                elseif StationCarB == 2
                    disp(Gate5)
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
              
                elseif StationCarB == 3
                    disp(Gate6)
                end

            elseif n >= 2    
                if StationCarB == 1
                    disp(Gate4)
          
                elseif StationCarB == 2
                    disp(Gate5)
              
                elseif StationCarB == 3
                    disp(Gate6)
                end

                [dout, dOutDisp,Last_ID] = dataFunc.directionCCW(CarB.Station(n-1),CarB.Station(n));
                disp(dOutDisp)
                if Last_ID ~= 0
                    disp(Last_ID)
                end

                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end

                end
                if n == length(idxB)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end

    if dir == 2 %CW

        for n = 1:length(idx0)
    
            StationCarB = CarB.Station(n);

            if n < 2
                if StationCarB == 1
                    disp(Gate4)
          
                elseif StationCarB == 2
                    disp(Gate5)
              
                elseif StationCarB == 3
                    disp(Gate6)
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end   

            elseif n >= 2    
                if StationCarB == 1
                    disp(Gate4)
          
                elseif StationCarB == 2
                    disp(Gate5)
              
                elseif StationCarB == 3
                    disp(Gate6)
                end

                [dout, dOutDisp,Last_ID] = dataFunc.directionCW(CarB.Station(n-1),CarB.Station(n));
                disp(dOutDisp)
                if Last_ID ~= 0
                    disp(Last_ID)
                end
            
                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Time'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Time(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end
                if n == length(idxB)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end
end
end
