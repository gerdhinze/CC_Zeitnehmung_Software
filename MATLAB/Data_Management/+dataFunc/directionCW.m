function [dOut, Last_ID] = directionCW(ID_Station, ID_Next_Station)

global Last_ID

      if ID_Station == 1 && ID_Next_Station == 2
                dOut = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
        
       elseif ID_Station == 2 && ID_Next_Station == 3
               dOut = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end
                 
       elseif ID_Station == 3 && ID_Next_Station == 1
                dOut = 'correct direction';
                if Last_ID == ID_Station
                    Last_ID = 0;
                end

       elseif ID_Station == 1 && ID_Next_Station == 3
                dOut = 'reverse direction';
             

       elseif ID_Station == 3 && ID_Next_Station == 2
                dOut = 'reverse direction';
            

       elseif ID_Station == 2 && ID_Next_Station == 1
                dOut = 'reverse direction';
                   

       elseif ID_Station == ID_Next_Station
              if Last_ID == 0
                 dOut = 'reverse direction';
                 Last_ID = ID_Station;
              elseif Last_ID == ID_Next_Station
                 dOut = 'correct direction';
                 Last_ID = 0;
              elseif Last_ID ~= ID_Next_Station
                 dOut = 'correct direction';
              end

      end
end
