function textEntered(src,event,btn)
val = src.Value;
btn.Enable = "off";
% Check each element of text area cell array for text
for k = 1:length(val)
    if ~isempty(val{k})
        btn.Enable = "on";
        break
    end
end