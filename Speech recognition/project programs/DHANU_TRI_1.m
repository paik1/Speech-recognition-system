clc
clear all;
DHANUrefmat=[];
for i=0:9
  for  j=1:10
      load(sprintf('%d_PES_%d.mat',i,j));
      DHANUrefmat(10*i+j+1,:)=[PHONEME_NUM_ARRAY];
end
end
DHANUrefmat1=[];
DHANUrefmat1=DHANUrefmat(2:end,:);

   save('DHANU_PHONEME_1','DHANUrefmat1');