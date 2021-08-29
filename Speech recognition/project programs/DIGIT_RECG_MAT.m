clc
clear all
load PES_PHONEME.mat;
x=importdata('PES_PHONEME.mat');
for i=1:9
    
y=[ones(20,1);zeros((180-20*(i-1)),1)];
svm_struct(i) = svmtrain(x(20*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6.1,'BOXCONSTRAINT',2);
end
save('DIGIT_TRAINED_matrix','svm_struct');