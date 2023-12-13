function [dOut, dOutDisp, Last_ID] = directionCCW(ID_Previous_Station, ID_Station)

global ID_Next_Station
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
