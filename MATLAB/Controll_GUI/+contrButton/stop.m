function stop()
    
    if isvalid(esp1)
    fprintf(esp1, 'Q');
    elseif isvalid(esp2)
    fprintf(esp2, 'Q');
    elseif isvalid(esp3)
    fprintf(esp3, 'Q');
    end
end

