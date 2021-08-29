clc
clear all
load PHONEME_REFMAT.mat;
x=importdata('PHONEME_REFMAT.mat');
for i=1:16
    
y=[ones(10,1);zeros((160-10*(i-1)),1)];
svm_struct(i) = svmtrain(x(10*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6,'BOXCONSTRAINT',17);
end
save('PHONOME_TRAINED_matrix','svm_struct');