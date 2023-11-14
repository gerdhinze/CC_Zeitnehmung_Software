function bt_duelgen(src,callbackdata)

    data = guidata(src); 
    try
        drawTabData = findall(0,'Tag','CCDraw');
    catch
        disp('Figure is not open!!!!! Terminated');
    end
    DrawColOne      = [];
    DrawColTwo      = [];
    DrawColMiddle   = [];
    
    lblColMiddle = findobj(drawTabData,'Tag','DrawColMiddle');
    lblColOne = findobj(drawTabData,'Tag','DrawColOne');
    lblColTwo = findobj(drawTabData,'Tag','DrawColTwo');
    objFreilos = findobj(drawTabData,'Tag','FreilosTeam');
    TNData = readtable('CCTM2023.csv');


    if mod(size(TNData,1),2)
        duelLines = (size(TNData,1)-1)/2;
        bFreilos = true;
    else
        duelLines = (size(TNData,1))/2;
        bFreilos = false;
        objFreilos.Text = 'NEIN';
    end
    %%%% Init Lines %%%%
    for dIdx = 1:duelLines
        DrawColMiddle = [DrawColMiddle,sprintf('%s\n','VS')];
    end
    lblColMiddle.Text = DrawColMiddle;

    usedIdx = 0;
    vectIdx = 1:size(TNData,1);
    idx = 0;
    while(idx <= size(TNData,1)-3)
        t = tic;
        while(toc(t)<=3)
           DrawColOne = [];
           DrawColTwo = [];
           permutIdx = randperm(size(TNData,1));
           permutIdx(find(sum(permutIdx == usedIdx',1))) = [];
           vectIdx = [usedIdx(1:idx), permutIdx];
           
           if bFreilos
                objFreilos.Text = TNData.Teamname{vectIdx(1)};
                idXMat = reshape(vectIdx(2:end),2,duelLines)';                
           else
                objFreilos.Text = 'NEIN';
                idXMat = reshape(vectIdx(1:end),2,duelLines)';
           end
           for dIdx = 1:duelLines
                DrawColOne = [DrawColOne,sprintf('%s\n',TNData.Teamname{idXMat(dIdx,1)})];
                DrawColTwo = [DrawColTwo,sprintf('%s\n',TNData.Teamname{idXMat(dIdx,2)})];
           end
           lblColOne.Text = DrawColOne;
           lblColTwo.Text = DrawColTwo;
              
           drawnow;
           pause(0.06)
        end
        idx = idx + 1;
        usedIdx(idx) = vectIdx(idx);
    end

    TNData = TNData(vectIdx',:);
    TNData.Zeit = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);

    fastBlock = repmat(duration('14:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    fastRND = repmat(duration('14:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    
    firRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    firRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    firRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);

    secRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    secRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    secRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);

    thiRndSplit1BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    thiRndSplit2BO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);
    thiRndBO = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);

    
    firRndSplit1BOMT = repmat(0,length(vectIdx),1);
    firRndSplit2BOMT = repmat(0,length(vectIdx),1);
    firRndBOMT = repmat(0,length(vectIdx),1);
    secRndSplit1BOMT = repmat(0,length(vectIdx),1);
    secRndSplit2BOMT = repmat(0,length(vectIdx),1);
    secRndBOMT = repmat(0,length(vectIdx),1);
    thiRndSplit1BOMT = repmat(0,length(vectIdx),1);
    thiRndSplit2BOMT = repmat(0,length(vectIdx),1);
    thiRndBOMT = repmat(0,length(vectIdx),1);

    MeterOld = repmat(0,length(vectIdx),1);
    RundenOld = repmat(0,length(vectIdx),1);
    ZeitOld = repmat(duration('00:00.000','Format','mm:ss.SSS'),length(vectIdx),1);


    TNData = addvars(TNData,fastBlock);
    TNData = addvars(TNData,fastRND);
    TNData = addvars(TNData,firRndSplit1BO); %first split time first round 
    TNData = addvars(TNData,firRndSplit2BO); %second split time first round 
    TNData = addvars(TNData,firRndBO);
    TNData = addvars(TNData,secRndSplit1BO); %first split time second round 
    TNData = addvars(TNData,secRndSplit2BO); %second split time second round 
    TNData = addvars(TNData,secRndBO);
    TNData = addvars(TNData,thiRndSplit1BO); %first split time third round 
    TNData = addvars(TNData,thiRndSplit2BO); %second split time third round     
    TNData = addvars(TNData,thiRndBO);
    
    TNData = addvars(TNData,firRndBOMT);
    TNData = addvars(TNData,secRndBOMT);
    TNData = addvars(TNData,thiRndBOMT);
    
    TNData = addvars(TNData,MeterOld);
    TNData = addvars(TNData,RundenOld);
    TNData = addvars(TNData,ZeitOld);

    save TNDataBOne TNData
    guidata(src,data);
    drawnow;  

end