load newrefmat1.mat;
x=importdata('newrefmat1.mat');
for i=1:9
    
y=[ones(10,1);zeros((90-10*(i-1)),1)];
svm_struct(i) = svmtrain(x(10*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6,'BOXCONSTRAINT',17);
end
save('Classifier_matrix','svm_struct');