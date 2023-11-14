function disconnect2ESP3(comPort)
    global esp3;
    global parity3;
    
    %if isvalid(esp3) && isequal(esp3.Status, 'open')
    if parity3 == 1
        fclose(esp3);
        delete(esp3);
        clear esp3;
        parity3 = 0;
        disp(['Verbindung zum COM-Port ' comPort ' abgebrochen.']);
    end
end