clc;
clear all;
load DHANU_PHONEME_1.mat
load DHANU_PHONEME_2.mat
x=importdata('DHANU_PHONEME_1.mat');
finalcount=[];
kfinalcount=[];

for c=1:1:20
    m=1;
for k=0.1:0.5:10.1
 count=0;
for i=1:9
y=[ones(10,1);zeros((90-10*(i-1)),1)];
svm_struct(i) = svmtrain(x(10*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',k,'BOXCONSTRAINT',c);
end
x1=importdata('DHANU_PHONEME_2.mat');
for i=1:100
    out=svmclassify(svm_struct(1),x1(i,:));
    if (out==1)
        disp('ZERO');
        count=count+1;
    else
        out=svmclassify(svm_struct(2),x1(i,:));
        if (out==1)
        disp('ONE');
        count=count+1;
        else
        out=svmclassify(svm_struct(3),x1(i,:));
        if (out==1)
        disp('TWO');
        count=count+1;
        else
        out=svmclassify(svm_struct(4),x1(i,:));
        if (out==1)
        disp('THREE');
        count=count+1;
        else
        out=svmclassify(svm_struct(5),x1(i,:));
        if (out==1)
        disp('FOUR');
        count=count+1;
        else
        out=svmclassify(svm_struct(6),x1(i,:));
        if (out==1)
        disp('FIVE');
        count=count+1;
        else
        out=svmclassify(svm_struct(7),x1(i,:));
        if (out==1)
        disp('SIX');
        count=count+1;
        else
        out=svmclassify(svm_struct(8),x1(i,:));
        if (out==1)
        disp('SEVEN');
        count=count+1;
        else
        out=svmclassify(svm_struct(9),x1(i,:));
        if (out==1)
        disp('EIGHT');
        count=count+1;
        else
         disp('NINE');
         count=count+1;
        end
        end
        end
        end
        end
        end
        end
        end
        end
end
        
kfinalcount(m,c)=count;
m=m+1;
end
end