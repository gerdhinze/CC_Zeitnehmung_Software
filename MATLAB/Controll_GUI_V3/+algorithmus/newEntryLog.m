function [Stored_Entry] = newEntryLog(ID_A,ID_B,dir,dataFile)

global dir;
global Last_ID
Last_ID = 0;
global ID_Next_Station
ID_Next_Station = 0;

Stored_Entry = 0;

Race = readtable(dataFile);
GUI_Data_A = './Output_GUI/GUI_Data_A.csv';
GUI_Data_B = './Output_GUI/GUI_Data_B.csv';

% Sort by car ID
idxA = find(strcmp(Race.ID,ID_A)); 
idxB = find(strcmp(Race.ID,ID_B)); 

% Create sorted table
CarA = Race(idxA,:);
CarB = Race(idxB,:);
 
% Display Commandline
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
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Timestamp(n)}, 'VariableNames', headers);
        
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

                % Direction algorithm for CCW
                [dout, dOutDisp,Last_ID] = directionCCW(CarA.Station(n-1),CarA.Station(n));
                disp(dOutDisp)

                % Check Last ID
                if Last_ID ~= 0
                    disp(Last_ID)
                end

                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Timestamp(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_A, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end

                end
                % Entry stored
                if n == length(idxA)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end

    if dir == 2 %CW

        for n = 1:length(idxA)
    
            StationCarA = CarA.Station(n);

            if n < 2
                if StationCarA == 1
                    disp(Gate1)
          
                elseif StationCarA == 2
                    disp(Gate2)
              
                elseif StationCarA == 3
                    disp(Gate3)
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Timestamp(n)}, 'VariableNames', headers);
        
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

                % Direction algorithm for CW
                [dout, dOutDisp,Last_ID] = directionCW(CarA.Station(n-1),CarA.Station(n));
                disp(dOutDisp)

                % Check Last ID
                if Last_ID ~= 0
                    disp(Last_ID)
                end
            
                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarA.Station(n)}, {CarA.ID(n)}, {CarA.Timestamp(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_A) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_A, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_A, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end
                % Entry stored
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
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Timestamp(n)}, 'VariableNames', headers);
        
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

                [dout, dOutDisp,Last_ID] = directionCCW(CarB.Station(n-1),CarB.Station(n));
                disp(dOutDisp)

                % Check Last ID
                if Last_ID ~= 0
                    disp(Last_ID)
                end

                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Timestamp(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end

                end
                % Entry stored
                if n == length(idxB)
                    Stored_Entry = 1;
                else
                    Stored_Entry = 0;
                end
            end

        end
    end

    if dir == 2 %CW

        for n = 1:length(idxB)
    
            StationCarB = CarB.Station(n);

            if n < 2
                if StationCarB == 1
                    disp(Gate4)
          
                elseif StationCarB == 2
                    disp(Gate5)
              
                elseif StationCarB == 3
                    disp(Gate6)
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Timestamp(n)}, 'VariableNames', headers);
        
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

                % Direction algorithm for CW
                [dout, dOutDisp,Last_ID] = directionCW(CarB.Station(n-1),CarB.Station(n));
                disp(dOutDisp)

                % Check Last ID
                if Last_ID ~= 0
                    disp(Last_ID)
                end
            
                if Last_ID == 0 && dout == 1 && ID_Next_Station == 0
                    headers = {'Station', 'ID', 'Timestamp'};
     
                    newData = table({CarB.Station(n)}, {CarB.ID(n)}, {CarB.Timestamp(n)}, 'VariableNames', headers);
        
                    if exist(GUI_Data_B) == 0
                        % File doesn't exist, create it with headers
                        writetable(newData, GUI_Data_B, 'WriteMode', 'overwrite');
                    else
                        % File exists, append data
                        writetable(newData, GUI_Data_B, 'WriteMode', 'append', 'WriteVariableNames', false);
                    end
                end
                % Entry stored
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

%---------------------------------------------CCW direction-------------------------------------------------------
function [dOut, dOutDisp, Last_ID] = directionCCW(ID_Previous_Station, ID_Station)

% Next Station ID for vaild round
global ID_Next_Station
% ID of the station (1st turn)
global Last_ID

      if ID_Previous_Station == 1 && ID_Station == 2
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end   
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
        
       elseif ID_Previous_Station == 2 && ID_Station == 3
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end   
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
                 
       elseif ID_Previous_Station == 3 && ID_Station == 1            
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end                 
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end

       elseif ID_Previous_Station == 1 && ID_Station == 3
                dOut = 0;
                dOutDisp = 'reverse direction';
             

       elseif ID_Previous_Station == 3 && ID_Station == 2
                dOut = 0;
                dOutDisp = 'reverse direction';
            
       elseif ID_Previous_Station == 2 && ID_Station == 1
                dOut = 0;
                dOutDisp = 'reverse direction';
                   

       elseif ID_Previous_Station == ID_Station
              if Last_ID == 0
                 dOut = 0;
                 dOutDisp = 'reverse direction';
                 Last_ID = ID_Previous_Station;
                 if ID_Station == 1
                     ID_Next_Station = 2;
                 elseif ID_Station == 2
                     ID_Next_Station = 3;
                 elseif ID_Station == 3
                     ID_Next_Station = 1;
                 end
                 
              elseif Last_ID == ID_Station
                 dOut = 0;
                 dOutDisp = 'correct direction';
                 Last_ID = 0;
              elseif Last_ID ~= ID_Station
                 dOut = 0;
                 dOutDisp = 'correct direction';
              end

      end
end
%---------------------------------------------CW direction-------------------------------------------------------
function [dOut, dOutDisp, Last_ID] = directionCW(ID_Previous_Station, ID_Station)

% ID of the station (1st turn)
global Last_ID
% Next Station ID for vaild round
global ID_Next_Station

     if ID_Previous_Station == 2 && ID_Station == 1
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end 
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
        
       elseif ID_Previous_Station == 3 && ID_Station == 2
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end 
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
                 
       elseif ID_Previous_Station == 1 && ID_Station == 3
                if ID_Next_Station == ID_Station
                    ID_Next_Station = 0; 
                end 
                dOut = 1;
                dOutDisp = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end

       elseif ID_Previous_Station == 3 && ID_Station == 1
                dOut = 0;
                dOutDisp = 'reverse direction';
             
       elseif ID_Previous_Station == 2 && ID_Station == 3
                dOut = 0;
                dOutDisp = 'reverse direction';
            
       elseif ID_Previous_Station == 1 && ID_Station == 2
                dOut = 0;
                dOutDisp = 'reverse direction';

       elseif ID_Previous_Station == ID_Station
             if Last_ID == 0
                 dOut = 0;
                 dOutDisp = 'reverse direction';
                 Last_ID = ID_Previous_Station;
                 if ID_Station == 1
                     ID_Next_Station = 2;
                 elseif ID_Station == 2
                     ID_Next_Station = 3;
                 elseif ID_Station == 3
                     ID_Next_Station = 1;
                 end

              elseif Last_ID == ID_Station
                 dOut = 0;
                 dOutDisp = 'correct direction';
                 Last_ID = 0;
              elseif Last_ID ~= ID_Station
                 dOut = 0;
                 dOutDisp = 'correct direction';
              end
      end

end