clc
clear all
load ON_OFF_REFMAT.mat
x=importdata('ON_OFF_REFMAT.mat');
options = optimset('maxiter',500);
for i=1:2
    
y=[ones(100,1);zeros((100-100*(i-1)),1)];
svm_struct(i) = svmtrain(x(100*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6.1,'BOXCONSTRAINT',2,'quadprog_opts',options);
end
save('ON_OFF_TRAINED_matrix','svm_struct');