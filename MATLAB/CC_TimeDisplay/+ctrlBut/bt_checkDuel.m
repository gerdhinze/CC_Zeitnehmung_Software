function bt_checkDuel(src,callbackdata)

    data = guidata(src.Parent);     
    rndRef = duration('00:00.000','Format','mm:ss.SSS');
    if isempty(data.TNData)
        errordlg(['No Data loaded!']);
    else               
        if (data.bFreilos & (data.idx == 1))
            data.TNData.Meter(data.idx) = data.TNData.MeterOld(data.idx) + data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);        
            data.TNData.Runden(data.idx) = data.TNData.RundenOld(data.idx) + sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            data.TNData.Zeit(data.idx) = data.TNData.ZeitOld(data.idx) + data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            if (sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]) == 3)
               if(data.TNData.fastBlock(data.idx) > (data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx)))
                    data.TNData.fastBlock(data.idx) = (data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx));
               end
            end
            if (data.TNData.firRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.firRndBO(data.idx)<data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.firRndBO(data.idx);
                end
            end
            if (data.TNData.secRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.secRndBO(data.idx)<data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.secRndBO(data.idx);
                end
            end
            if (data.TNData.thiRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.thiRndBO(data.idx)<data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.thiRndBO(data.idx);
                end
            end
        else
            data.TNData.Meter(data.idx) = data.TNData.MeterOld(data.idx) + data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);
            data.TNData.Meter(data.idx+1) = data.TNData.MeterOld(data.idx+1) + data.TNData.firRndBOMT(data.idx+1) + data.TNData.secRndBOMT(data.idx+1) + data.TNData.thiRndBOMT(data.idx+1);
            data.TNData.Runden(data.idx) = data.TNData.RundenOld(data.idx) + sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            data.TNData.Runden(data.idx+1) = data.TNData.RundenOld(data.idx+1) + sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]);
            data.TNData.Zeit(data.idx) = data.TNData.ZeitOld(data.idx) + data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            data.TNData.Zeit(data.idx+1) = data.TNData.ZeitOld(data.idx+1) + data.TNData.firRndBO(data.idx+1) + data.TNData.secRndBO(data.idx+1) + data.TNData.thiRndBO(data.idx+1);
       
            if (sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]) == 3)
               if(data.TNData.fastBlock(data.idx) > (data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx)))
                    data.TNData.fastBlock(data.idx) = (data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx));
               end
            end
            if (data.TNData.firRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.firRndBO(data.idx) < data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.firRndBO(data.idx);
                end
            end
            if (data.TNData.secRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.secRndBO(data.idx)<data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.secRndBO(data.idx);
                end
            end
            if (data.TNData.thiRndBO(data.idx) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.thiRndBO(data.idx)<data.TNData.fastRND(data.idx))
                    data.TNData.fastRND(data.idx) = data.TNData.thiRndBO(data.idx);
                end
            end

            if (sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]) == 3)
               if(data.TNData.fastBlock(data.idx + 1) > (data.TNData.firRndBO(data.idx + 1) + data.TNData.secRndBO(data.idx + 1) + data.TNData.thiRndBO(data.idx + 1)))
                    data.TNData.fastBlock(data.idx + 1) = (data.TNData.firRndBO(data.idx + 1) + data.TNData.secRndBO(data.idx + 1) + data.TNData.thiRndBO(data.idx + 1));
               end
            end
            if (data.TNData.firRndBO(data.idx + 1) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.firRndBO(data.idx + 1) < data.TNData.fastRND(data.idx + 1))
                    data.TNData.fastRND(data.idx + 1) = data.TNData.firRndBO(data.idx + 1);
                end
            end
            if (data.TNData.secRndBO(data.idx + 1) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.secRndBO(data.idx + 1) < data.TNData.fastRND(data.idx + 1))
                    data.TNData.fastRND(data.idx + 1) = data.TNData.secRndBO(data.idx + 1);
                end
            end
            if (data.TNData.thiRndBO(data.idx + 1) > duration('00:00.000','Format','mm:ss.SSS'))
                if(data.TNData.thiRndBO(data.idx + 1) < data.TNData.fastRND(data.idx + 1))
                    data.TNData.fastRND(data.idx + 1) = data.TNData.thiRndBO(data.idx + 1);
                end
            end
        end

        [fastestBlock,fastIdx] = min(data.TNData.fastBlock);
        if (fastestBlock == duration('14:00.000','Format','mm:ss.SSS'))
            fastestBlockTeam = '';
            fastestBlockTime = '';            
        else
            fastestBlockTime = fastestBlock;
            if isfile('fastestBlock.mat')
                load('fastestBlock');
                if (fastestBlockTime == rndRef)
                else
                    if fastestBlockTimeOld < fastestBlockTime
                        fastestBlockTeam = fastestBlockTeamOld;
                        fastestBlockTime = fastestBlockTimeOld;
                    else
                        fastestBlockTeamOld = data.TNData.Teamname{fastIdx};
                        fastestBlockTimeOld = string(data.TNData.fastBlock(fastIdx));
                        save fastestBlock fastestBlockTeamOld fastestBlockTimeOld
                    end
                end
            else
                if (fastestBlockTime == rndRef)
                else
                    fastestBlockTeamOld = data.TNData.Teamname{fastIdx};
                    fastestBlockTimeOld = data.TNData.fastBlock(fastIdx);
                    save fastestBlock fastestBlockTeamOld fastestBlockTimeOld
                end
            end
            set(findall(0,'Tag','lblFastestTeamBlock'),'Text',fastestBlockTeamOld);
            set(findall(0,'Tag','lblFastestTimeBlock'),'Text',string(fastestBlockTimeOld));
            set(findall(0,'Tag','lblFastestTeamBlock2'),'Text',fastestBlockTeamOld);
            set(findall(0,'Tag','lblFastestTimeBlock2'),'Text',string(fastestBlockTimeOld));
        end

        [fastestRnd,fastRIdx] = min(data.TNData.fastRND);
        if (fastestRnd == duration('14:00.000','Format','mm:ss.SSS'))
            fastestRNDTeam = '';
            fastestRNDTime = '';
        else
            fastestRNDTime = fastestRnd;
            if isfile('fastestLAP.mat')
                load('fastestLAP');
                if fastestRNDTimeOld < fastestRNDTime
                    fastestRNDTeam = fastestRNDTeamOld;
                    fastestRNDTime = fastestRNDTimeOld;
                else
                    fastestRNDTeamOld = data.TNData.Teamname{fastRIdx};
                    fastestRNDTimeOld = data.TNData.fastRND(fastRIdx);
                    save fastestLAP fastestRNDTeamOld fastestRNDTimeOld
                end
            else
                fastestRNDTeamOld = data.TNData.Teamname{fastRIdx};
                fastestRNDTimeOld = data.TNData.fastRND(fastRIdx);
                save fastestLAP fastestRNDTeamOld fastestRNDTimeOld
            end
            set(findall(0,'Tag','lblFastestTeamRnd'),'Text',fastestRNDTeamOld);
            set(findall(0,'Tag','lblFastestTimeRnd'),'Text',string(fastestRNDTimeOld));
            set(findall(0,'Tag','lblFastestTeamRnd2'),'Text',fastestRNDTeamOld);
            set(findall(0,'Tag','lblFastestTimeRnd2'),'Text',string(fastestRNDTimeOld));
        end



    end

    switch src.Parent.Tag        
        case 'BlockOne'
            sortedTable = sortrows(data.TNData,["Runden","Meter","Zeit"],{'descend','descend','ascend'});
            ref = 1;
            TNData = data.TNData;
            save TNDataBOne TNData  
        case 'BlockTwo'
            ref = 1;
            sortedTable = sortrows(data.TNData,["Runden","Meter","Zeit"],{'descend','descend','ascend'});
            TNData = data.TNData;
            save TNDataBTwo TNData 
        case 'QuarterFinal'
            ref = 0;
            DuelMeter(1,:) = data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);
            DuelMeter(2,:) = data.TNData.firRndBOMT(data.idx+1) + data.TNData.secRndBOMT(data.idx+1) + data.TNData.thiRndBOMT(data.idx+1);
            DuelRunden(1,:) = sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            DuelRunden(2,:) = sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]);
            DuelZeit(1,:) = data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            DuelZeit(2,:) = data.TNData.firRndBO(data.idx+1) + data.TNData.secRndBO(data.idx+1) + data.TNData.thiRndBO(data.idx+1);
            DuelName(1,:) = data.TNData.Teamname(data.idx);
            DuelName(2,:) = data.TNData.Teamname(data.idx+1);
            
            duelIdx(1,:) = data.idx;
            duelIdx(2,:) = data.idx+1;
            
            DuelTable = table(duelIdx,DuelName,DuelRunden,DuelZeit,DuelMeter);
            sortedTable = sortrows(DuelTable,["DuelRunden","DuelMeter","DuelZeit"],{'descend','descend','ascend'});
            data.dataQFWinner(data.duel,:) = data.TNData(sortedTable.duelIdx(1),:);
            data.dataQFLoser(data.duel,:) = data.TNData(sortedTable.duelIdx(2),:);
            set(findall(0,'Tag',['lblHF',num2str(data.duel)]),'Text',data.TNData.Teamname{sortedTable.duelIdx(1)});
        case 'SemiFinal'
            ref = 0;
            DuelMeter(1,:) = data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);
            DuelMeter(2,:) = data.TNData.firRndBOMT(data.idx+1) + data.TNData.secRndBOMT(data.idx+1) + data.TNData.thiRndBOMT(data.idx+1);
            DuelRunden(1,:) = sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            DuelRunden(2,:) = sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]);
            DuelZeit(1,:) = data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            DuelZeit(2,:) = data.TNData.firRndBO(data.idx+1) + data.TNData.secRndBO(data.idx+1) + data.TNData.thiRndBO(data.idx+1);
            DuelName(1,:) = data.TNData.Teamname(data.idx);
            DuelName(2,:) = data.TNData.Teamname(data.idx+1);
            
            duelIdx(1,:) = data.idx;
            duelIdx(2,:) = data.idx+1;
            
            DuelTable = table(duelIdx,DuelName,DuelRunden,DuelZeit,DuelMeter);
            sortedTable = sortrows(DuelTable,["DuelRunden","DuelMeter","DuelZeit"],{'descend','descend','ascend'});
            data.dataF(data.duel,:) = data.TNData(sortedTable.duelIdx(1),:);
            data.dataKF(data.duel,:) = data.TNData(sortedTable.duelIdx(2),:);
            set(findall(0,'Tag',['lblF',num2str(data.duel)]),'Text',data.TNData.Teamname{sortedTable.duelIdx(1)});
            set(findall(0,'Tag',['lblKF',num2str(data.duel)]),'Text',data.TNData.Teamname{sortedTable.duelIdx(2)});    
        case 'SmallFinal' 
            ref = 0;
            DuelMeter(1,:) = data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);
            DuelMeter(2,:) = data.TNData.firRndBOMT(data.idx+1) + data.TNData.secRndBOMT(data.idx+1) + data.TNData.thiRndBOMT(data.idx+1);
            DuelRunden(1,:) = sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            DuelRunden(2,:) = sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]);
            DuelZeit(1,:) = data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            DuelZeit(2,:) = data.TNData.firRndBO(data.idx+1) + data.TNData.secRndBO(data.idx+1) + data.TNData.thiRndBO(data.idx+1);
            DuelName(1,:) = data.TNData.Teamname(data.idx);
            DuelName(2,:) = data.TNData.Teamname(data.idx+1);
            
            duelIdx(1,:) = data.idx;
            duelIdx(2,:) = data.idx+1;
            
            DuelTable = table(duelIdx,DuelName,DuelRunden,DuelZeit,DuelMeter);
            sortedTable = sortrows(DuelTable,["DuelRunden","DuelMeter","DuelZeit"],{'descend','descend','ascend'});
            set(findall(0,'Tag',['lblKF',num2str(sortedTable.duelIdx(1))]),'FontColor',[0,0.4471,0.7412],'FontSize',48);
            set(findall(0,'Tag',['lblKF',num2str(sortedTable.duelIdx(2))]),'FontColor',[0,0,0],'FontSize',37);
            dataKF= data.TNData(sortedTable.duelIdx,:);
            save resultKF dataKF
        case 'Final' 
            ref = 1;
            DuelMeter(1,:) = data.TNData.firRndBOMT(data.idx) + data.TNData.secRndBOMT(data.idx) + data.TNData.thiRndBOMT(data.idx);
            DuelMeter(2,:) = data.TNData.firRndBOMT(data.idx+1) + data.TNData.secRndBOMT(data.idx+1) + data.TNData.thiRndBOMT(data.idx+1);
            DuelRunden(1,:) = sum([(data.TNData.firRndBO(data.idx)>rndRef),(data.TNData.secRndBO(data.idx)>rndRef),(data.TNData.thiRndBO(data.idx)>rndRef)]);
            DuelRunden(2,:) = sum([(data.TNData.firRndBO(data.idx+1)>rndRef),(data.TNData.secRndBO(data.idx+1)>rndRef),(data.TNData.thiRndBO(data.idx+1)>rndRef)]);
            DuelZeit(1,:) = data.TNData.firRndBO(data.idx) + data.TNData.secRndBO(data.idx) + data.TNData.thiRndBO(data.idx);
            DuelZeit(2,:) = data.TNData.firRndBO(data.idx+1) + data.TNData.secRndBO(data.idx+1) + data.TNData.thiRndBO(data.idx+1);
            DuelName(1,:) = data.TNData.Teamname(data.idx);
            DuelName(2,:) = data.TNData.Teamname(data.idx+1);
            
            duelIdx(1,:) = data.idx;
            duelIdx(2,:) = data.idx+1;
            
            DuelTable = table(duelIdx,DuelName,DuelRunden,DuelZeit,DuelMeter);
            sortedTable = sortrows(DuelTable,["DuelRunden","DuelMeter","DuelZeit"],{'descend','descend','ascend'});
            set(findall(0,'Tag',['lblF',num2str(sortedTable.duelIdx(1))]),'FontColor',[0,0.4471,0.7412],'FontSize',48);
            set(findall(0,'Tag',['lblF',num2str(sortedTable.duelIdx(2))]),'FontColor',[0,0,0],'FontSize',37);
            dataF = data.TNData(sortedTable.duelIdx,:);
            save resultF dataF
            load('resultKF.mat')
            load('TNDataFIN')

            sortedTable = [dataF;dataKF;TNDataRest];
    end

 
    if ref 
        dispMainHandle = findall(0,'Tag','MainCC');
        dispSchoolHandle = findall(0,'Tag','SchoolCC');
    
        tableTextPos = [];
        tableTextName = [];
        tableTextInst = [];
        tableTextRnd = [];
        tableTextTime = [];
        tableTextMeter = [];
        tableTextPosSC = [];
        tableTextNameSC = [];
        tableTextInstSC = [];
        tableTextRndSC = [];
        tableTextTimeSC = [];
        tableTextMeterSC = [];
    
        numTN = size(sortedTable,1);
        for idxTb = 1:numTN
                    tableTextPos =      [tableTextPos,sprintf('%s\n',num2str(idxTb))];
                    tableTextName =     [tableTextName,sprintf('%s\n',sortedTable.Teamname{idxTb})];
                    tableTextInst =     [tableTextInst,sprintf('%s\n',sortedTable.Bildungseinrichtung{idxTb})];
                    tableTextRnd =      [tableTextRnd,sprintf('%s\n',num2str(sortedTable.Runden(idxTb)))];
                    tableTextTime =     [tableTextTime,sprintf('%s\n',string(sortedTable.Zeit(idxTb)))];
                    tableTextMeter =    [tableTextMeter,sprintf('%s\n',num2str(sortedTable.Meter(idxTb)))];
        end
        schoolPosIdx = 1;
        for idxTb = 1:numTN
            if strcmp(sortedTable.Bewerb{idxTb},'Schule')
                    tableTextPosSC =      [tableTextPosSC,sprintf('%s\n',num2str(schoolPosIdx))];
                    tableTextNameSC =     [tableTextNameSC,sprintf('%s\n',sortedTable.Teamname{idxTb})];
                    tableTextInstSC =     [tableTextInstSC,sprintf('%s\n',sortedTable.Bildungseinrichtung{idxTb})];
                    tableTextRndSC =      [tableTextRndSC,sprintf('%s\n',num2str(sortedTable.Runden(idxTb)))];
                    tableTextTimeSC =     [tableTextTimeSC,sprintf('%s\n',string(sortedTable.Zeit(idxTb)))];
                    tableTextMeterSC =    [tableTextMeterSC,sprintf('%s\n',num2str(sortedTable.Meter(idxTb)))];
                    schoolPosIdx = schoolPosIdx + 1;
            end
        end
    
        set(findobj(dispMainHandle.Children,'Tag','Pos'),'Text',tableTextPos);
        set(findobj(dispMainHandle.Children,'Tag','Name'),'Text',tableTextName);
        set(findobj(dispMainHandle.Children,'Tag','Inst'),'Text',tableTextInst);
        set(findobj(dispMainHandle.Children,'Tag','Rnd'),'Text',tableTextRnd);
        set(findobj(dispMainHandle.Children,'Tag','Time'),'Text',tableTextTime);
        set(findobj(dispMainHandle.Children,'Tag','Meter'),'Text',tableTextMeter);
    
        set(findobj(dispSchoolHandle.Children,'Tag','Pos'),'Text',tableTextPosSC);
        set(findobj(dispSchoolHandle.Children,'Tag','Name'),'Text',tableTextNameSC);
        set(findobj(dispSchoolHandle.Children,'Tag','Inst'),'Text',tableTextInstSC);
        set(findobj(dispSchoolHandle.Children,'Tag','Rnd'),'Text',tableTextRndSC);
        set(findobj(dispSchoolHandle.Children,'Tag','Time'),'Text',tableTextTimeSC);
        set(findobj(dispSchoolHandle.Children,'Tag','Meter'),'Text',tableTextMeterSC);
    end

    guidata(src,data);
    drawnow;  

end