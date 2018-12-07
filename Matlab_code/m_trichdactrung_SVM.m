function data = m_trichdactrung_SVM(img)
data = [];
dataHog =[];
%% my method


[m n] = size(img);
s1 = m/n;

J = rgb2gray(img);

% dilation
BW0 = im2bw(J,0.75);
se = strel('square',5);
BW0 = imdilate(BW0,se);

% dilation
BW1 = edge(J,'sobel');
se = strel('square',5);
BW1 = imdilate(BW1,se); 
% 
BW2 = BW1 + BW0;

area = bwarea(BW2);
s2 = area /(m*n);
data = [area s1*1000 s2*1000];

%% using HOG
% img = imresize(img,[150,120]);
% img = rgb2gray(img);
% %img = im2bw(img,0.7);
% [dataHog, hogVisualization] = extractHOGFeatures(img);

%%
data = [data dataHog*1000];
end