clc
clear all
load NEW_HOMO_AUTO_PHONEME_REFMAT.mat;
x1=importdata('NEW_HOMO_AUTO_PHONEME_REFMAT.mat');
options = optimset('maxiter',25000);
for i=1:15
y=[ones(20,1);zeros((280-20*(i-1)),1)];
svm_struct(i) = svmtrain(x1(20*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',5.5,'BOXCONSTRAINT',4,'quadprog_opts',options);
end
save('NEW_HOMO_AUTO_PHONOME_TRAINED_matrix','svm_struct');