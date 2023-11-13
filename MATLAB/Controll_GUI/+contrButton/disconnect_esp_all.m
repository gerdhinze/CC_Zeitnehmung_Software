function disconnect_esp_all(port1Number, port2Number, port3Number)
    if ismember(port1Number, availablePorts.SerialPorts)
        fclose(esp1);
        delete(esp1);
    elseif ismember(port2Number, availablePorts.SerialPorts)
        fclose(esp2);
        delete(esp2);
    elseif ismember(port3Number, availablePorts.SerialPorts)
        fclose(esp3);
        delete(esp3);
    end 
    disp('Alle Verbindungen getrennt.');
end