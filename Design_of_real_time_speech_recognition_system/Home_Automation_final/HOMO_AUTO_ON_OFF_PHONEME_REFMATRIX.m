clc
clear all;
HOMO_AUTO_PHONEME_REFMAT=[];
for i=1:20
      load(sprintf('SIL_sample_%d.mat',i));
      SILrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('OW_sample_%d.mat',i));
      OWrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('F_sample_%d.mat',i));
      Frefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('N_sample_%d.mat',i));
      Nrefmat(i,:)=[a];
end
HOMO_AUTO_ON_OFF_PHONEME_REFMAT=[SILrefmat;OWrefmat;Frefmat;Nrefmat];
  
  save('HOMO_AUTO_ON_OFF_PHONEME_REFMAT','HOMO_AUTO_ON_OFF_PHONEME_REFMAT');
  
