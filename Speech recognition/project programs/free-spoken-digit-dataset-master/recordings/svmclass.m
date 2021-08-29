clc;
clear all;
count=0;
load refmat.mat;
load testmatrix1.mat;
x=importdata('refmat.mat');
for i=1:9
y=[ones(10,1);zeros((90-10*(i-1)),1)];
svm_struct(i) = svmtrain(x(10*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',4);
end
x=importdata('testmatrix1.mat');
for i=1:100
    for j=1:9
        out=svmclassify(svm_struct(j),x(i,:));
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
        
  