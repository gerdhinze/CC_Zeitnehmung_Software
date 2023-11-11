function sync_time()
% Erhalten Sie die aktuelle Systemzeit und Datum
currentDateTime = clock;
realtime = [num2str(currentDateTime(4)) ':' num2str(currentDateTime(5)) ':' num2str(currentDateTime(6))];

    if isvalid(esp1)
        fprintf(esp1, 'sync_time');
        pause(0.5);
        realtime_esp1 = fprintf(esp1, realtime);
        disp(realtime_esp1);
    elseif isvalid(esp2)
        fprintf(esp2, 'sync_time');
        pause(0.5);
        realtime_esp2 = fprintf(esp2, realtime);
        disp(realtime_esp2);
    elseif isvalid(esp3)
        fprintf(esp3, 'sync_time');
        pause(0.5);
        realtime_esp3 = fprintf(esp2, realtime);
        disp(realtime_esp3);
    end
end