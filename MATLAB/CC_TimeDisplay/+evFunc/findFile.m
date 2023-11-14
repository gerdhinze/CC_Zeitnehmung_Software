function [TNData] = findFile(srcTag)

    switch srcTag
        case 'BlockOne'
            strFileName = 'TNDataBOne.mat';
        case 'BlockTwo'
            strFileName = 'TNDataBTwo.mat';
        case 'QuarterFinal'
            strFileName = 'TNDataQF.mat';
        case 'SemiFinal'
            strFileName = 'TNDataSF.mat';
        case 'SmallFinal'
            strFileName = 'TNDatakF.mat';
        case 'Final'
            strFileName = 'TNDataFIN.mat';
    end

    try 
        load(strFileName);
    catch
        errordlg(['The File ', strFileName, ' is not existing! ',...
            'Please finalize the previous Session!']);
        TNData = [];
    end

end

