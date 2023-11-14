function disconnect2ESP1(comPort)
    global esp1;
    global parity1;
    
    %if isvalid(esp1) && isequal(esp1.Status, 'open')
    if parity1 == 1
        fclose(esp1);
        delete(esp1);
        clear esp1;
        parity1 = 0;
        disp(['Verbindung zum COM-Port ' comPort ' abgebrochen.']);
    end
end