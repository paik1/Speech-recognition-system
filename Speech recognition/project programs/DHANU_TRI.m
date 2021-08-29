clc
clear all;
DHANUrefmat=[];
for i=0:9
  for  j=11:20
      load(sprintf('%d_PES_%d.mat',i,j));
      for k=1:10
      DHANUrefmat(10*i+k+1,:)=[PHONEME_NUM_ARRAY];
      end
 
end
end
DHANUrefmat2=[];
DHANUrefmat2=DHANUrefmat(2:end,:);

   save('DHANU_PHONEME_2','DHANUrefmat2');