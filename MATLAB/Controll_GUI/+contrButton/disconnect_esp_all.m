function disconnect_esp_all()
    global esp1;
    global esp2;
    global esp3;
    if strcmp(get(esp1, 'Status'), 'open')
        fclose(esp1);
        delete(esp1);
        clear esp1;
    end
    if strcmp(get(esp2, 'Status'), 'open')
        fclose(esp2);
        delete(esp2);
        clear esp2;
    end
    if strcmp(get(esp3, 'Status'), 'open')
        fclose(esp3);
        delete(esp3);
        clear esp3;
    end 
end