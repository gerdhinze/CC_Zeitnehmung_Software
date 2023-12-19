function[parity1, parity2, parity3] = disconnect_esp_all(esp1, parity1, esp2, parity2, esp3, parity3)

    if parity1 == 1
        fclose(esp1);
        delete(esp1);
        clear esp1;
        parity1 = 0;
    end

    if parity2 == 1
        fclose(esp2);
        delete(esp2);
        clear esp2;
        parity2 = 0;
    end

    if parity3 == 1
        fclose(esp3);
        delete(esp3);
        clear esp3;
        parity3 = 0;
    end 
end