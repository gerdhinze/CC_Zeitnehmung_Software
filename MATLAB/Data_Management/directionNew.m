function direction(ID_Station, ID_Next_Station)


%ID_Station = id_current;
%ID_Next_Station = id_next;
Last_ID = 0;
d = 0;

      if ID_Station == 1 && ID_Next_Station == 2
                disp('correct direction')
                d = 1;
                if Last_ID == ID_Station
                    disp('Checkpoint reached')
                    Last_ID = 0;
                end
        
            elseif ID_Station == 2 && ID_Next_Station == 3
                disp('correct direction')
                d = 1;
                if Last_ID == ID_Station
                    disp('Checkpoint reached')
                    Last_ID = 0;
                end
                 
            elseif ID_Station == 3 && ID_Next_Station == 1
                disp('correct direction')
                d = 1;
                if Last_ID == ID_Station
                    disp('Checkpoint reached')
                    Last_ID = 0;
                end

            elseif ID_Station == 1 && ID_Next_Station == 3
                disp('reverse direction')
                d = 0;

            elseif ID_Station == 3 && ID_Next_Station == 2
                disp('reverse direction')
                d = 0;

            elseif ID_Station == 2 && ID_Next_Station == 1
                disp('reverse direction')
                d = 0;

           
            else 
                disp('Turn') 
                Last_ID = ID_Station;
      end
      if Last_ID == ID_Station && d == 0
             disp('Checkpoint reached')
             Last_ID = 0;
     end

end