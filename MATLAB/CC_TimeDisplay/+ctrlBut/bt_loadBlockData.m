function bt_loadBlockData(src,callbackdata)

    data = guidata(src.Parent); 
    
    data.idx = 1;
    data.duel = 1;
    data.TNData = evFunc.findFile(src.Parent.Tag);
    
    if ~isempty(data.TNData)
        if strcmp(src.Parent.Tag,'QuarterFinal')
            for idxDispKO = 1:8
                set(findall(0,'Tag',['lblQF',num2str(idxDispKO)]),'Text',data.TNData.Teamname{idxDispKO});
            end
        end
        if mod(size(data.TNData,1),2)
            data.bFreilos = true;
            set(findall(src.Parent,'Tag','lblDO'),'Text',data.TNData.Teamname(data.idx));
            set(findall(src.Parent,'Tag','lblDT'),'Text','Freilos'); 
            set(findall(src.Parent,'Tag','duelCnt'),'Text',num2str(data.duel));

            set(findall(src.Parent,'Tag','rndOneSp1DO'),'Value',string(data.TNData.firRndSplit1BO(data.idx)));  %first round first split time
            set(findall(src.Parent,'Tag','rndOneSP2DO'),'Value',string(data.TNData.firRndSplit2BO(data.idx)));  %first round second split time
            set(findall(src.Parent,'Tag','rndOneDO'),'Value',string(data.TNData.firRndBO(data.idx))); %first round finished

            set(findall(src.Parent,'Tag','rndTwoSp2DO'),'Value',string(data.TNData.secRndSplit1BO(data.idx))); %second round first split time
            set(findall(src.Parent,'Tag','rndTwoSp2DO'),'Value',string(data.TNData.secRndSplit2BO(data.idx))); %second round second split time
            set(findall(src.Parent,'Tag','rndTwoDO'),'Value',string(data.TNData.secRndBO(data.idx))); %second round finished

            set(findall(src.Parent,'Tag','rndThreeSp1DO'),'Value',string(data.TNData.thiRndSplit1BO(data.idx))); %second round first split time
            set(findall(src.Parent,'Tag','rndThreeSp2DO'),'Value',string(data.TNData.thiRndSplit2BO(data.idx))); %second round second split time
            set(findall(src.Parent,'Tag','rndThreeDO'),'Value',string(data.TNData.thiRndBO(data.idx))); %third round finished

            set(findall(src.Parent,'Tag','MeterOneDO'),'Value',string(data.TNData.firRndBOMT(data.idx)));        
            set(findall(src.Parent,'Tag','MeterTwoDO'),'Value',string(data.TNData.secRndBOMT(data.idx))); 
            set(findall(src.Parent,'Tag','MeterThreeDO'),'Value',string(data.TNData.thiRndBOMT(data.idx))); 

            set(findall(0,'Tag','lblDODuelDisp'),'Text',data.TNData.Teamname(data.idx));
            set(findall(0,'Tag','imagDODisp'),'ImageSource',data.TNData.PictureUrl{data.idx});
            set(findall(0,'Tag','lblDTDuelDisp'),'Text','Freilos');
            set(findall(0,'Tag','imagDTDisp'),'Visible','off');

            set(findall(0,'Tag','lblTimeOneSp1DODuelDisp'),'Text',string(data.TNData.firRndSplit1BO(data.idx)));  %first round first split time
            set(findall(0,'Tag','lblTimeOneSp2DODuelDisp'),'Text',string(data.TNData.firRndSplit2BO(data.idx)));  %first round second split time
            set(findall(0,'Tag','lblTimeOneDODuelDisp'),'Text',string(data.TNData.firRndBO(data.idx))); %first round finished

            set(findall(0,'Tag','lblTimeTwoSp1DODuelDisp'),'Text',string(data.TNData.secRndSplit1BO(data.idx)));  %second round first split time
            set(findall(0,'Tag','lblTimeTwoSp2DODuelDisp'),'Text',string(data.TNData.secRndSplit2BO(data.idx)));  %second round second split time
            set(findall(0,'Tag','lblTimeTwoDODuelDisp'),'Text',string(data.TNData.secRndBO(data.idx))); %second round finished

            set(findall(0,'Tag','lblTimeThreeSp1DODuelDisp'),'Text',string(data.TNData.thiRndSplit1BO(data.idx)));    %third round first split time
            set(findall(0,'Tag','lblTimeThreeSp2DODuelDisp'),'Text',string(data.TNData.thiRndSplit2BO(data.idx)));    %third round second split time
            set(findall(0,'Tag','lblTimeThreeDODuelDisp'),'Text',string(data.TNData.thiRndBO(data.idx)));   %third round finished
            
%             data.idx = data.idx + 1;
%             data.duel = data.duel + 1;
        else
            set(findall(0,'Tag','imagDTDisp'),'Visible','on');
            data.bFreilos = false;
            set(findall(src.Parent,'Tag','lblDO'),'Text',data.TNData.Teamname(data.idx));
            set(findall(src.Parent,'Tag','rndOneSp1DO'),'Value',string(data.TNData.firRndSplit1BO(data.idx)));  %first round first split time
            set(findall(src.Parent,'Tag','rndOneSP2DO'),'Value',string(data.TNData.firRndSplit2BO(data.idx)));  %first round second split time
            set(findall(src.Parent,'Tag','rndOneDO'),'Value',string(data.TNData.firRndBO(data.idx)));   %first round finished
            
            set(findall(src.Parent,'Tag','rndTwoSp1DO'),'Value',string(data.TNData.secRndSplit1BO(data.idx))); %second round first split time
            set(findall(src.Parent,'Tag','rndTwoSp2DO'),'Value',string(data.TNData.secRndSplit2BO(data.idx))); %second round second split time
            set(findall(src.Parent,'Tag','rndTwoDO'),'Value',string(data.TNData.secRndBO(data.idx)));   %second round finished

            set(findall(src.Parent,'Tag','rndThreeSp1DO'),'Value',string(data.TNData.thiRndSplit1BO(data.idx))); %second round first split time
            set(findall(src.Parent,'Tag','rndThreeSp2DO'),'Value',string(data.TNData.thiRndSplit2BO(data.idx))); %second round second split time
            set(findall(src.Parent,'Tag','rndThreeDO'),'Value',string(data.TNData.thiRndBO(data.idx))); %third round finished

            set(findall(src.Parent,'Tag','MeterOneDO'),'Value',num2str(data.TNData.firRndSplit1BOMT(data.idx))); %third round first split tim        
            set(findall(src.Parent,'Tag','MeterTwoDO'),'Value',num2str(data.TNData.secRndSplit2BOMT(data.idx))); %third round second split time
            set(findall(src.Parent,'Tag','MeterThreeDO'),'Value',num2str(data.TNData.thiRndBOMT(data.idx))); %third round finished

            set(findall(0,'Tag','lblDODuelDisp'),'Text',data.TNData.Teamname(data.idx));
            set(findall(0,'Tag','imagDODisp'),'ImageSource',data.TNData.PictureUrl{data.idx});
            set(findall(0,'Tag','lblTimeOneSp1DODuelDisp'),'Text',string(data.TNData.firRndSplit1BO(data.idx))); %first round first split time
            set(findall(0,'Tag','lblTimeOneSp2DODuelDisp'),'Text',string(data.TNData.firRndSplit2BO(data.idx))); %first round second split time
            set(findall(0,'Tag','lblTimeOneDODuelDisp'),'Text',string(data.TNData.firRndBO(data.idx))); %first round finished

            set(findall(0,'Tag','lblTimeTwoSp1DODuelDisp'),'Text',string(data.TNData.secRndSplit1BO(data.idx))); %second round first split time
            set(findall(0,'Tag','lblTimeTwoSp2DODuelDisp'),'Text',string(data.TNData.secRndSplit2BO(data.idx))); %second round second split time
            set(findall(0,'Tag','lblTimeTwoDODuelDisp'),'Text',string(data.TNData.secRndBO(data.idx))); %second round finished

            set(findall(0,'Tag','lblTimeThreeSp1DODuelDisp'),'Text',string(data.TNData.thiRndSplit1BO(data.idx))); %third round first split time
            set(findall(0,'Tag','lblTimeThreeSp2DODuelDisp'),'Text',string(data.TNData.thiRndSplit2BO(data.idx))); %third round second split time
            set(findall(0,'Tag','lblTimeThreeDODuelDisp'),'Text',string(data.TNData.thiRndBO(data.idx))); %third round finished

            set(findall(src.Parent,'Tag','lblDT'),'Text',data.TNData.Teamname(data.idx+1));              
            set(findall(src.Parent,'Tag','rndOneSp1DT'),'Value',string(data.TNData.firRndSplit1BO(data.idx+1))); %first round first split time
            set(findall(src.Parent,'Tag','rndOneSp2DT'),'Value',string(data.TNData.firRndSplit2BO(data.idx+1))); %first round second split time
            set(findall(src.Parent,'Tag','rndOneDT'),'Value',string(data.TNData.firRndBO(data.idx+1))); %first round finished

            set(findall(src.Parent,'Tag','rndTwoSp1DT'),'Value',string(data.TNData.secRndSplit1BO(data.idx+1))); %second round first split time
            set(findall(src.Parent,'Tag','rndTwoSp2DT'),'Value',string(data.TNData.secRndSplit2BO(data.idx+1))); %second round second split time
            set(findall(src.Parent,'Tag','rndTwoDT'),'Value',string(data.TNData.secRndBO(data.idx+1))); %second round finished

            set(findall(src.Parent,'Tag','rndThreeSp1DT'),'Value',string(data.TNData.thiRndSplit1BO(data.idx+1))); %third round first split time
            set(findall(src.Parent,'Tag','rndThreeSp2DT'),'Value',string(data.TNData.thiRndSplit2BO(data.idx+1))); %third round second split time
            set(findall(src.Parent,'Tag','rndThreeDT'),'Value',string(data.TNData.thiRndBO(data.idx+1))); %third round finished

            set(findall(src.Parent,'Tag','MeterOneDT'),'Value',num2str(data.TNData.firRndBOMT(data.idx+1)));        
            set(findall(src.Parent,'Tag','MeterTwoDT'),'Value',num2str(data.TNData.secRndBOMT(data.idx+1))); 
            set(findall(src.Parent,'Tag','MeterThreeDT'),'Value',num2str(data.TNData.thiRndBOMT(data.idx+1))); 

            set(findall(0,'Tag','lblDTDuelDisp'),'Text',data.TNData.Teamname(data.idx+1));
            set(findall(0,'Tag','imagDTDisp'),'ImageSource',data.TNData.PictureUrl{data.idx+1});

            set(findall(0,'Tag','lblTimeOneSp1DTDuelDisp'),'Text',string(data.TNData.firRndSplit1BO(data.idx+1))); %first round first split time
            set(findall(0,'Tag','lblTimeOneSp2DTDuelDisp'),'Text',string(data.TNData.firRndSplit2BO(data.idx+1))); %first round second split time
            set(findall(0,'Tag','lblTimeOneDTDuelDisp'),'Text',string(data.TNData.firRndBO(data.idx+1))); %first round finished

            set(findall(0,'Tag','lblTimeTwoSp1DTDuelDisp'),'Text',string(data.TNData.secRndSplit1BO(data.idx+1))); %second round first split time
            set(findall(0,'Tag','lblTimeTwoSp2DTDuelDisp'),'Text',string(data.TNData.secRndSplit2BO(data.idx+1))); %second round second split time
            set(findall(0,'Tag','lblTimeTwoDTDuelDisp'),'Text',string(data.TNData.secRndBO(data.idx+1))); %second round finished

            set(findall(0,'Tag','lblTimeThreeSp1DTDuelDisp'),'Text',string(data.TNData.thiRndSplit1BO(data.idx+1))); %third round first split time
            set(findall(0,'Tag','lblTimeThreeSp2DTDuelDisp'),'Text',string(data.TNData.thiRndSplit2BO(data.idx+1))); %third round second split time
            set(findall(0,'Tag','lblTimeThreeDTDuelDisp'),'Text',string(data.TNData.thiRndBO(data.idx+1))); %third round finished
            
            set(findall(src.Parent,'Tag','duelCnt'),'Text',num2str(data.duel));
%             data.idx = data.idx + 2;
%             data.duel = data.duel + 1;
        end
            
            set(findall(0,'Tag','lblTimeOneSp1DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeOneSp2DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeOneDODuelDisp'),'FontColor', [0.7,0.7,0.7]);

            set(findall(0,'Tag','lblTimeTwoSp1DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeTwoSp2DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeTwoDODuelDisp'),'FontColor', [0.7,0.7,0.7]);

            set(findall(0,'Tag','lblTimeThreeSp1DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeThreeSp2DODuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeThreeDODuelDisp'),'FontColor', [0.7,0.7,0.7]);

            set(findall(0,'Tag','lblTimeOneSp1DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeOneSp2DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeOneDTDuelDisp'),'FontColor', [0.7,0.7,0.7]);

            set(findall(0,'Tag','lblTimeTwoSp1DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeTwoSp2DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeTwoDTDuelDisp'),'FontColor', [0.7,0.7,0.7]);

            set(findall(0,'Tag','lblTimeThreeSp1DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeThreeSp2DTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
            set(findall(0,'Tag','lblTimeThreeDTDuelDisp'),'FontColor', [0.7,0.7,0.7]);
    end
    guidata(src,data);
    drawnow;  

end