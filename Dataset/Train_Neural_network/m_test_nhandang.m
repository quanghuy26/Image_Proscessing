clc
clear all;

X=[]; % dac trung cua mau du lieu
D=[]; % label cua du lieu
D_test = [];
for i = 1:30,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Test\xemay(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x = m_trichdactrung(I);
    X = [X x];
    D = [D, 1];
end;

for i = 1:30,
    filename = ['C:\Users\admin\Desktop\XLA\BTL\DATASET\Test\oto(' int2str(i) ').png'];
    I = imread(filename);
    imshow(I);
    x = m_trichdactrung(I);
    X = [X x];
    D = [D, 2];
end;

disp('read images done .');
X = double(X);
[h, w] = size(X);

% nhan dang
load mangnhandang.mat

%% Test
for i = 1:w,
    TestInputs = X(:,i);
    TestOutputs = sim(Net,TestInputs);
    disp('---------------------');
    [ymax,ind]=max(TestOutputs);
%     if ymax<0.2,
%         disp('Khong nhan dang duoc.');
%         D_test = [D_test , 0];
%     else
        if ind == 1
            txt = ['xe ' int2str(i) ' la: xe may '];
            D_test = [D_test , 1];
        elseif ind == 2
            txt = ['xe ' int2str(i) ' la: o to'];
            D_test = [D_test , 2];
        end
        disp(txt);
%     end
end
%% caculating accuracy
fault = 0;
for i = 1:w,
    if D_test(i) ~= D(i)
        fault = fault + 1;
    end
end 
disp('---------------------');
test_accuracy = (w - fault) /w *100;
txt = ['test_accuracy: ' int2str(test_accuracy) '%'];
disp(txt);


