clear all;
clc;

% initial parameters

X=[]; % dac trung cua mau du lieu
D=zeros(2,180); % label cua du lieu

for i = 1:90,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Train\xemay(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x = m_trichdactrung(I);
    X = [X x];
    D(1,i) = 1;
end;

for i = 1:90,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Train\oto(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x= m_trichdactrung(I);
    X = [X x];
    D(2,i+20) = 1;
end;

disp('read images done .');
X = double(X);

% hoan doi ngau nhien cac mau du lieu, tranh tinh trang huan
% luyen lien tuc 1 so mau co ngo ra giong nhau
temp=rand(1,180);
[temp,ind]=sort(temp);
X = X(:,ind);
D = D(:,ind);

Net=newff(X,D,10,{'tansig','purelin'});
Net=train(Net,X,D); %huan luyen mang

save mangnhandang.mat Net
