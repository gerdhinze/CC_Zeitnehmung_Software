function[parity] = disconnect_ESP(comPort, parity, esp)
    
    if parity == 1
        fclose(esp);
        delete(esp);
        clear esp;
        parity = 0;
        disp(['Verbindung zum COM-Port ' comPort ' abgebrochen.']);
    end
end