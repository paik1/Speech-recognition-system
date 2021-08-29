clc
clear all;
testmatrix1=zeros(100,50);
for i=0:9
  for  j=0:9
      load(sprintf('%d_ktest_%d.mat',i,j));
      testmatrix1(10*i+j+1,:)=[newfilterbankarraydkktest zeros(1,50-length(newfilterbankarraydkktest))];
  end
end
newtestmatrix=[];

for i=1:100
    k=1;
    count=0;
    zerocount=0;
    for j=1:50
        if(zerocount==0)
        if(testmatrix1(i,j)==0)
            count=count+1;
        else
            newtestmatrix(i,k)=testmatrix1(i,j);
            zerocount=1;
            k=k+1;
        end
        else
             newtestmatrix(i,k)=testmatrix1(i,j);
            k=k+1;
        end
       
        
            
    end
    for n=1:count
                newtestmatrix(i,k)=0;
                k=k+1;
            end
end
     newtestmatrix1=[];
     newtestmatrix1=newtestmatrix(:,1:31);
        
   save('newtestmatrix1','newtestmatrix1');
  