% this program is for the genrating refmat(reference  matrix)
clc
clear all;
PESrefmat=[];
for i=0:9
  for  j=1:20
      load(sprintf('%d_PES_%d.mat',i,j));
      PESrefmat(20*i+j+1,:)=[PHONEME_NUM_ARRAY];
  end
end
PESrefmat1=[];
PESrefmat1=PESrefmat(2:end,:);

   save('PES_PHONEME','PESrefmat1');