clc
clear all
load HOMO_AUTO_ON_OFF_PHONEME_REFMAT.mat;
x1=importdata('HOMO_AUTO_ON_OFF_PHONEME_REFMAT.mat');
options = optimset('maxiter',15000);
for i=1:4
y=[ones(20,1);zeros((60-20*(i-1)),1)];
svm_struct(i) = svmtrain(x1(20*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',5.5,'BOXCONSTRAINT',4,'quadprog_opts',options);
end
save('HOMO_AUTO_ON_OFF_PHONOME_TRAINED_matrix','svm_struct');