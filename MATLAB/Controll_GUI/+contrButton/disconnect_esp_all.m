function disconnect_esp_all()
    global esp1 esp2 esp3;
    global parity1 parity2 parity3;

    %if isvalid(esp1) && isequal(esp1.Status, 'open')
    if parity1 == 1
        fclose(esp1);
        delete(esp1);
        clear esp1;
        parity1 = 0;
    end
    %if isvalid(esp2) && isequal(esp2.Status, 'open')
    if parity2 == 1
        fclose(esp2);
        delete(esp2);
        clear esp2;
        parity2 = 0;
    end
    %if isvalid(esp3) && isequal(esp3.Status, 'open')
    if parity3 == 1
        fclose(esp3);
        delete(esp3);
        clear esp3;
        parity3 = 0;
    end 
end