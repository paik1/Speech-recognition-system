clc
clear all;
RBF_HEL_TI_REFMAT=[];
for i=1:60
      load(sprintf('RED_sample_%d.mat',i));
      REDrefmat(i,:)=[PHONEME_NUM_ARRAY];
end
for i=1:60
      load(sprintf('BLUE_sample_%d.mat',i));
      BLUErefmat(i,:)=[PHONEME_NUM_ARRAY];
end

for i=1:60
      load(sprintf('FAN_sample_%d.mat',i));
      FANrefmat(i,:)=[PHONEME_NUM_ARRAY];
end
for i=1:60
      load(sprintf('TIME_sample_%d.mat',i));
      TIMErefmat(i,:)=[PHONEME_NUM_ARRAY];
end
for i=1:60
      load(sprintf('HELLO_sample_%d.mat',i));
      HELLOrefmat(i,:)=[PHONEME_NUM_ARRAY];
end

RBF_HEL_TI_REFMAT=[REDrefmat;BLUErefmat;FANrefmat;TIMErefmat;HELLOrefmat];
  
  save('RBF_HEL_TI_REFMAT','RBF_HEL_TI_REFMAT');
