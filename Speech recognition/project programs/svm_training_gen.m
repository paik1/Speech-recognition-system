clc;
clear all;
load newrefmat1.mat;
load newtestmatrix1.mat;
x=importdata('newtestmatrix1.mat');
 count=0;
for i=1:9
y=[ones(10,1);zeros((90-10*(i-1)),1)];
svm_struct(i) = svmtrain(x(10*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',6,'BOXCONSTRAINT',17);
end
x1=importdata('newrefmat1.mat');

for i=1:100
    for j=1:9
        out=svmclassify(svm_struct(j),x1(i,:));
        if(out==1)
            if((j-1)==floor((i-1)/10))
                count=count+1;
            end
             disp(j-1)
            break
         elseif(j==9)
            if((j)==floor((i-1)/10))
                count=count+1;
            end
            
             disp(j)
            break
            
            
        end
    end
end
 save('training','svm_struct');