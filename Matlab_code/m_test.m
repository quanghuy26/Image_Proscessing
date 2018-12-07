clear all; clc;

a1 = 33; a2 = 170; b1 = 361; b2 = 361;
c1 = 398; c2 = 170; d1 = 640; d2 = 364;
load mangnhandang.mat
load svmstruct.mat
my_video = VideoReader('test6_Trim.MP4');
nframes = my_video.NumberOfFrames;

% preparing video to write
writerObj = VideoWriter('final.avi');
writerObj.FrameRate = my_video.FrameRate;
open(writerObj);

for i=1:nframes
    i
    I = read(my_video, i);
    anh_goc = I;
    %% part 1
    I1 = imcrop(I,[a1 a2 b1-a1 b2-a2]); % [x y weight height]
    I1 = rgb2gray(I1);
    
    % dilation
    BW0 = im2bw(I1,0.75);
    se = strel('square',5);
    BW0 = imdilate(BW0,se);
    BW0 = bwareaopen(BW0,200);
    
    % dilation
    BW1 = edge(I1,'sobel');
    se = strel('square',5);
    BW1 = imdilate(BW1,se); 
    BW1 = bwareaopen(BW1,200);
    % 
    BW2 = BW1 + BW0;
    % open
    BW2 = bwareaopen(BW2,600);
    
    % tach 2 vat gan nhau
    D = imcomplement(BW2); % new = 255 - old
    D1 = bwdist(D); % tinh khoang cach Euclidean 
    D2 = imcomplement(D1); % new = 255 - old
    D3 = imhmin(D2,7); % cong them (<= max)
    L = watershed(D3);

    BW2(L == 0) = 0;
    
    %label all the connected components in the image
    bw_label = bwlabel(BW2,8); %??? why 8
    %set of properties for each labeled region
    stats = regionprops(bw_label,'BoundingBox','Centroid','Area');
    
    %create a loop for the rectangular bounding boxes
    for object = 1:length(stats)
        % save the controid and bounding box values in vriable bc,bb
        boundingBox = stats(object).BoundingBox;
        boundingBox(1) = boundingBox(1) + a1;
        boundingBox(2) = boundingBox(2) + a2;
        centroid = stats(object).Centroid;
        centroid = [centroid(1)+a1,centroid(2)+a2];
        area = stats(object).Area;
        
        % start identify
        img = imcrop(anh_goc,boundingBox);
        ketqua_ANN = m_nhan_dang_ANN(img,Net);
        ketqua_SVM = m_nhan_dang_SVM(img,svmstruct);
        if ketqua_ANN ~= ketqua_SVM
            ketqua = 0;
        elseif (ketqua_ANN == ketqua_SVM && ketqua_ANN==1)
            ketqua = 1;
        elseif (ketqua_ANN == ketqua_SVM && ketqua_ANN==2)
            ketqua = 2;
        end
        if ketqua ~= 0
            % user insertShape function to draw rectangles with data from
            anh_goc = insertShape(anh_goc,'Rectangle',boundingBox,'Color','green', 'Opacity', 0.9, 'LineWidth', 2);
            % use insertMarker function to plot retangles d=rawn in the output
            anh_goc = insertMarker(anh_goc,centroid,'*','color','red','size',5);
            % add text 
            if(ketqua == 1)
                str = 'xe 2 banh';
            elseif(ketqua == 2)
                str = 'xe 4 banh';
            end
            txt = strcat(str);
            text_position = [centroid(1)-boundingBox(3)/2,centroid(2)-boundingBox(4)/2];
            anh_goc = insertText(anh_goc,text_position,txt,'FontSize',18,'BoxColor','red','BoxOpacity',0.4,'TextColor','white');
        end
    end
    %% part 2
    I2 = imcrop(I,[c1 c2 d1-c1 d2-c2]); % [x y weight height]
    I2 = rgb2gray(I2);
    
    % dilation
    BW0 = im2bw(I2,0.75);
    se = strel('square',5);
    BW0 = imdilate(BW0,se);
    BW0 = bwareaopen(BW0,200);
    
    % dilation
    BW1 = edge(I2,'sobel');
    se = strel('square',5);
    BW1 = imdilate(BW1,se); 
    BW1 = bwareaopen(BW1,200);
    % 
    BW2 = BW1 + BW0;
    % open
    BW2 = bwareaopen(BW2,600);
    
    % tach vat
    D = imcomplement(BW2); % new = 255 - old
    D1 = bwdist(D); % tinh khoang cach Euclidean 
    D2 = imcomplement(D1); % new = 255 - old
    D3 = imhmin(D2,7); % cong them (<= max)
    L = watershed(D3);

    BW2(L == 0) = 0;
    
    %label all the connected components in the image
    bw_label = bwlabel(BW2,8); %??? why 8
    %set of properties for each labeled region
    stats = regionprops(bw_label,'BoundingBox','Centroid','Area');
    
    %create a loop for the rectangular bounding boxes
    for object = 1:length(stats)
        % save the controid and bounding box values in vriable bc,bb
        boundingBox = stats(object).BoundingBox;
        boundingBox(1) = boundingBox(1) + c1;
        boundingBox(2) = boundingBox(2) + c2;
        centroid = stats(object).Centroid;
        centroid = [centroid(1)+c1,centroid(2)+c2];
        area = stats(object).Area;
        
        % start identify
        img = imcrop(anh_goc,boundingBox);
        ketqua_ANN = m_nhan_dang_ANN(img,Net);
        ketqua_SVM = m_nhan_dang_SVM(img,svmstruct);
        if ketqua_ANN ~= ketqua_SVM
            ketqua = 0;
        elseif (ketqua_ANN == ketqua_SVM && ketqua_ANN==1)
            ketqua = 1;
        elseif (ketqua_ANN == ketqua_SVM && ketqua_ANN==2)
            ketqua = 2;
        end
        if ketqua ~= 0
            % user insertShape function to draw rectangles with data from
            anh_goc = insertShape(anh_goc,'Rectangle',boundingBox,'Color','green', 'Opacity', 0.9, 'LineWidth', 2);
            % use insertMarker function to plot retangles d=rawn in the output
            anh_goc = insertMarker(anh_goc,centroid,'*','color','red','size',5);
            % add text 
            if(ketqua == 1)
                str = 'xe 2 banh';
            elseif(ketqua == 2)
                str = 'xe 4 banh';
            end
            txt = strcat(str);
            text_position = [centroid(1)-boundingBox(3)/2,centroid(2)-boundingBox(4)/2];
            anh_goc = insertText(anh_goc,text_position,txt,'FontSize',18,'BoxColor','red','BoxOpacity',0.4,'TextColor','white');
        end
    end
    
    writeVideo(writerObj,anh_goc);
end
close(writerObj);
disp('---- Done -----');
disp('Starting play video..........');
implay('final.avi');
