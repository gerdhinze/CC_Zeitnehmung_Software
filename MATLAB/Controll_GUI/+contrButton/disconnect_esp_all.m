function disconnect_esp_all()
    if isvalid(esp1)
    fclose(esp1);
    delete(esp1);
    disp(realtime_esp1);
    elseif isvalid(esp2)
    fclose(esp2);
    delete(esp2);
    elseif isvalid(esp3)
    fclose(esp3);
    delete(esp3);
    end 
end