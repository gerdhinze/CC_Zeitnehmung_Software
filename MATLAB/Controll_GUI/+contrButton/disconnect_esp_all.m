function disconnect_esp_all()
    global esp1;
    global esp2;
    global esp3;
    if isvalid(esp1) && isequal(esp1.Status, 'open')
        fclose(esp1);
        delete(esp1);
        clear esp1;
    end
    if isvalid(esp2) && isequal(esp2.Status, 'open')
        fclose(esp2);
        delete(esp2);
        clear esp2;
    end
    if isvalid(esp3) && isequal(esp3.Status, 'open')
        fclose(esp3);
        delete(esp3);
        clear esp3;
    end 
end