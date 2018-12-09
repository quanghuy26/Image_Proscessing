function data = m_trichdactrung(img)
data = [];
dataHog =[];
%% my method
% 
% [m n] = size(img);
% s1 = m/n;
% 
% J = rgb2gray(img);
% 
% % dilation
% diff_im = im2bw(J,0.75);
% se = strel('square',5);
% diff_im = imdilate(diff_im,se);
% 
% % dilation
% BW1 = edge(J,'sobel');
% se = strel('square',5);
% BW1 = imdilate(BW1,se); 
% % 
% BW2 = BW1 + diff_im;
% 
% bw_label = bwlabel(BW2,8); %??? why 8
% %set of properties for each labeled region
% stats = regionprops(bw_label,'BoundingBox','Centroid','Area');
% 
% if length(stats) > 0
%     boundingBox = stats(1).BoundingBox;
%     centroid = stats(1).Centroid;
%     area = stats(1).Area;
%     s2 = area /(boundingBox(3)*boundingBox(4));
% else
%     s2 = 0;
%     area = 0;
% end
% 
% data = [area s1*1000 s2*1000];

%% using HOG
img = imresize(img,[150,120]);
img = rgb2gray(img);
% img = im2bw(img,0.7);
[dataHog, hogVisualization] = extractHOGFeatures(img);

%%
data = [data dataHog*1000];
end