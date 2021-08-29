clc
clear all
load RBF_HEL_TI_REFMAT.mat
x=importdata('RBF_HEL_TI_REFMAT.mat');
options = optimset('maxiter',500);
for i=1:5
    
y=[ones(60,1);zeros((240-60*(i-1)),1)];
svm_struct(i) = svmtrain(x(60*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6.1,'BOXCONSTRAINT',2,'quadprog_opts',options);
end
save('RBF_HEL_TI_TRAINED_matrix','svm_struct');