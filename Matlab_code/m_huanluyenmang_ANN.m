clear all;
clc;

% initial parameters
number_of_sample = 53;
number_of_object = 3;
number_of_hidden_perceptron = 10;

X=[]; % dac trung cua mau du lieu
D=zeros(number_of_object,number_of_sample); % label cua du lieu

for i = 1:20,
    filename = ['xe' int2str(i) '.png'];
    I = imread(filename);
    x = m_trichdactrung_ANN(I);
    X = [X x];
    D(1,i) = 1;
end;

for i = 1:20,
    filename = ['oto' int2str(i) '.png'];
    I = imread(filename);
    x= m_trichdactrung_ANN(I);
    X = [X x];
    D(2,i+20) = 1;
end;

for i = 1:13,
    filename = ['unk(' int2str(i) ').png'];
    I = imread(filename);
    x= m_trichdactrung_ANN(I);
    X = [X x];
    D(3,i+20) = 1;
end;

disp('read images done .');
X = double(X);

% hoan doi ngau nhien cac mau du lieu, tranh tinh trang huan
% luyen lien tuc 1 so mau co ngo ra giong nhau
temp=rand(1,number_of_sample);
[temp,ind]=sort(temp);
X = X(:,ind);
D = D(:,ind);

%%
Net=newff(X,D,number_of_hidden_perceptron,{'tansig','purelin'});
Net=train(Net,X,D); %huan luyen mang

save mangnhandang.mat Net
