clc;
clear all;
load PHONEME_REFMAT1.mat
load PHONEME_REFMAT2.mat
x=importdata('PHONEME_REFMAT1.mat');
finalcount=[];
kfinalcount=[];

for c=1:1:20
    m=1;
for k=0.1:0.5:10.1
 count=0;
for i=1:16
y=[ones(5,1);zeros((80-5*(i-1)),1)];
svm_struct(i) = svmtrain(x(5*(i-1)+1:end,:),y,'kernel_function','rbf','RBF_SIGMA',k,'BOXCONSTRAINT',c);
end
x1=importdata('PHONEME_REFMAT2.mat');
for i=1:85
    for j=1:15
        out=svmclassify(svm_struct(j),x1(i,:));
        if(out==1)
            if((j-1)==floor((i-1)/5))
                count=count+1;
            end
             disp(j-1)
            break
         elseif(j==16)
            if((j)==floor((i-1)/5))
                count=count+1;
            end
            
             disp(j)
            break
            
            
        end
    end
end

kfinalcount(m,c)=count;
m=m+1;
end
end
%   stem(1:1:10,finalcount);