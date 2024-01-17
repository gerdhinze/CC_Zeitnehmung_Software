function bt_stop_autoupdate(src, callbackdata, autoUpdateLED)
    global stopUpdating;
    stopUpdating = true; % Set global flag to stop auto-update loop
    set(findall(0,'Tag','AutoupdateLED'),'color','red');
end