function ketqua = m_nhan_dang_ANN(I,Net)

x = m_trichdactrung_ANN(I);

y = sim(Net,x);
[ymax,ind]=max(y);

if ymax<0.6,
    ketqua = 0;
else
    if ind == 1
        ketqua = 1;
    elseif ind == 2
        ketqua = 2;
    elseif ind == 3
        ketqua = 3;
    end
end
