clear all;
clc;

% initial parameters

X=[]; % dac trung cua mau du lieu
D=[]; % label cua du lieu

for i = 1:90,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Train\xemay(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x = m_trichdactrung(I);
    X = [X;x];
    D = [D;1];
end;

for i = 1:90,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Train\oto(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x = m_trichdactrung(I);
    X = [X;x];
    D = [D;2];
end;

disp('read images done .');
X = double(X);

% hoan doi ngau nhien cac mau du lieu, tranh tinh trang huan
% luyen lien tuc 1 so mau co ngo ra giong nhau
TrainInputs = X;
TrainTargets = D;

%Design SVM 
C = 100;
svmstruct = svmtrain(TrainInputs,TrainTargets,...
    'boxconstraint',10,...
    'kernel_function','rbf',...
    'rbf_sigma',0.5,...
    'showplot','false');

save svmstruct.mat svmstruct
