function data = m_trichdactrung(img)
data1 = [];
dataHog =[];
dataHog_pool = [];
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
data1 = [area s1*1000 s2*1000];

%% using HOG
img = imresize(img,[60,40]);
img = im2bw(img,0.7);
[dataHog, hogVisualization] = extractHOGFeatures(img); %dataHog là vector hàng

for j = 1:16:length(dataHog)
    m = sum(dataHog(1,j:j+3)) /16;
    dataHog_pool = [dataHog_pool, m];
end

%%
data = [data1'; dataHog_pool'*1000];
end