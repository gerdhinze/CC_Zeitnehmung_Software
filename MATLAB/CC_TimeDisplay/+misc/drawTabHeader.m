function [cchandle] = drawTabHeader(cchandle,sTitle)

    ccHandle.ImageAVL = uiimage(cchandle);
    ccHandle.ImageAVL.ImageSource = 'AVL-Logo.jpg';
    ccHandle.ImageAVL.Position = [100,850,125,125];
    
    ccHandle.ImageCC = uiimage(cchandle);
    ccHandle.ImageCC.ImageSource = 'cc_jpg.jpg';
    ccHandle.ImageCC.Position = [1425,812,300,150];

    ccHandle.tableHeader = uilabel(cchandle);
    ccHandle.tableHeader.Text = sTitle;
    ccHandle.tableHeader.Position = [-25,875,1900,125];
    ccHandle.tableHeader.FontSize = 110;
    ccHandle.tableHeader.FontName = 'American Captain';
    ccHandle.tableHeader.FontWeight = 'bold';
    ccHandle.tableHeader.HorizontalAlignment = 'center';      

end

