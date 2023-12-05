function bt_genNextStage(src,callbackdata)

    data = guidata(src.Parent);     

    if isempty(data.TNData)
        errordlg(['No Data loaded!']);
    else               
        switch src.Parent.Tag
            case 'BlockOne'
                sortedTable = sortrows(data.TNData,["Runden","Meter","Zeit"],{'descend','descend','ascend'});
                newStage = flipud(sortedTable);
            case 'BlockTwo'
                sortedTable = sortrows(data.TNData,["Runden","Meter","Zeit"],{'descend','descend','ascend'});
                vIdxQF = [1,5,2,6,3,7,4,8];
                newStage = sortedTable(vIdxQF,:);
            case 'QuarterFinal'
                newStage = data.dataQFWinner;
                sortedQFLoser = sortrows(data.dataQFLoser,["Runden","Meter","Zeit"],{'descend','descend','ascend'});
            case 'SemiFinal'
                newStage = data.dataF;
                newStageTwo = data.dataKF;
                newStageTwo.RundenOld = newStageTwo.Runden;
                newStageTwo.ZeitOld = newStageTwo.Zeit;
                newStageTwo.MeterOld = newStageTwo.Meter;

                newStageTwo.firRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.firRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.firRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

                newStageTwo.secRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.secRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.secRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

                newStageTwo.thiRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.thiRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
                newStageTwo.thiRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

                newStageTwo.firRndBOMT = repmat(0,size(newStageTwo,1),1);
                newStageTwo.secRndBOMT = repmat(0,size(newStageTwo,1),1);
                newStageTwo.thiRndBOMT = repmat(0,size(newStageTwo,1),1);
        end
                
        newStage.RundenOld = newStage.Runden;
        newStage.ZeitOld = newStage.Zeit;
        newStage.MeterOld = newStage.Meter;

        newStage.firRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.firRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.firRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

        newStage.secRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.secRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.secRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

        newStage.thiRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.thiRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);
        newStage.thiRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),size(newStage,1),1);

        newStage.firRndBOMT = repmat(0,size(newStage,1),1);
        newStage.secRndBOMT = repmat(0,size(newStage,1),1);
        newStage.thiRndBOMT = repmat(0,size(newStage,1),1);

        switch src.Parent.Tag
            case 'BlockOne'
                TNData = newStage;
                save TNDataBTwo.mat
            case 'BlockTwo'
                TNData = newStage; 
                TNDataRest = sortedTable(9:size(sortedTable,1),:);
                save TNDataQF.mat TNData TNDataRest
                for idxDispKO = 1:8
                    set(findall(0,'Tag',['lblQF',num2str(idxDispKO)]),'Text',TNData.Teamname{idxDispKO});
                end
            case 'QuarterFinal'
                TNData = newStage;
                load('TNDataQF.mat','TNDataRest');
                TNDataRest = [sortedQFLoser; TNDataRest];
                save TNDataSF.mat TNData TNDataRest
            case 'SemiFinal'
                TNData = newStage;
                load('TNDataSF.mat','TNDataRest');
                save TNDataFIN.mat TNData TNDataRest

                TNData = newStageTwo;
                load('TNDataSF.mat','TNDataRest');
                save TNDatakF.mat TNData TNDataRest
        end
    end

    
    

    guidata(src,data);
    drawnow;  

end