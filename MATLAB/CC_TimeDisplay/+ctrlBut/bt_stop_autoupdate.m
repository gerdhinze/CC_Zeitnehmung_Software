function bt_stop_autoupdate(src, callbackdata, autoUpdateLED)
    global stopUpdating;
    stopUpdating = true; % Set global flag to stop auto-update loop
    %autoUpdateLED.Color = 'red'; % Indicate auto update is off
end