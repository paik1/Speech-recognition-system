% this program is for the genrating refmat(reference  matrix)
clc
clear all;
refmat=zeros(100,50);
for i=0:9
  for  j=0:20
      load(sprintf('%d_jackson_%d.mat',i,j));
      refmat(10*i+j+1,:)=[newfilterbankarraydkktest zeros(1,50-length(newfilterbankarraydkktest))];
  end
end
   save('refmat','refmat');