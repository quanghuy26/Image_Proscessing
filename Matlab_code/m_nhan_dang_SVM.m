function Outputs = m_nhan_dang_SVM(I,svmstruct)

TestInputs = m_trichdactrung_SVM(I);

Outputs = svmclassify(svmstruct,TestInputs,'showplot','false');

