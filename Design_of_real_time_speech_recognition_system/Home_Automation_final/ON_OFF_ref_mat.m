clc
clear all;
ON_OFF_REFMAT=[];
for i=1:100
      load(sprintf('ON_sample_%d.mat',i));
      ONrefmat(i,:)=[PHONEME_NUM_ARRAY1];
end
for i=1:100
      load(sprintf('OFF_sample_%d.mat',i));
      OFFrefmat(i,:)=[PHONEME_NUM_ARRAY1];
end
ON_OFF_REFMAT=[ONrefmat;OFFrefmat];

 save('ON_OFF_REFMAT','ON_OFF_REFMAT');