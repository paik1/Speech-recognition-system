% this program is for the genrating refmat(reference  matrix)
clc
clear all;
refmat=zeros(100,50);
for i=0:9
  for  j=0:9
      load(sprintf('%d_ksample_%d.mat',i,j));
      refmat(10*i+j+1,:)=[newfilterbankarraydkktest zeros(1,50-length(newfilterbankarraydkktest))];
  end
end
newrefmat=[];

for i=1:100
    k=1;
    count=0;
    zerocount=0;
    for j=1:50
        if(zerocount==0)
        if(refmat(i,j)==0)
            count=count+1;
        else
            newrefmat(i,k)=refmat(i,j);
            zerocount=1;
            k=k+1;
        end
        else
             newrefmat(i,k)=refmat(i,j);
            k=k+1;
        end
       
        
            
    end
    for n=1:count
                newrefmat(i,k)=0;
                k=k+1;
            end
end
     newrefmat11=[];
     newrefmat1=newrefmat(:,1:31);
     

   save('newrefmat1','newrefmat1');