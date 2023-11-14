function disconnect2ESP2(comPort)
    global esp2;
    global parity2;
    
    %if isvalid(esp2) && isequal(esp2.Status, 'open')
    if parity2 == 1
        fclose(esp2);
        delete(esp2);
        clear esp2;
        parity2 = 0;
        disp(['Verbindung zum COM-Port ' comPort ' abgebrochen.']);
    end
end