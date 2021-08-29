clc
clear all;
NEW_HOMO_AUTO_PHONEME_REFMAT=[];
for i=1:20
      load(sprintf('OW_sample_%d.mat',i));
      OWrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('F_sample_%d.mat',i));
      Frefmat(i,:)=[a];
end

for i=1:20
      load(sprintf('FA_sample_%d.mat',i));
      FArefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('B_sample_%d.mat',i));
      Brefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('LU_sample_%d.mat',i));
      LUrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('OO_sample_%d.mat',i));
      OOrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('Rr_sample_%d.mat',i));
      Rrrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('HED_sample_%d.mat',i));
      HEDrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('SIL_sample_%d.mat',i));
      SILrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('N_sample_%d.mat',i));
      Nrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('Ha_sample_%d.mat',i));
      Harefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('L_sample_%d.mat',i));
      Lrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('Tt_sample_%d.mat',i));
      Ttrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('Iy_sample_%d.mat',i));
      Iyrefmat(i,:)=[a];
end
for i=1:20
      load(sprintf('Em_sample_%d.mat',i));
      Emrefmat(i,:)=[a];
end
% for i=1:20
%       load(sprintf('Dd_sample_%d.mat',i));
%       Ddrefmat(i,:)=[a];
% end
% for i=1:20
%       load(sprintf('R_sample_%d.mat',i));
%       Rrefmat(i,:)=[a];
% end
NEW_HOMO_AUTO_PHONEME_REFMAT=[SILrefmat;OWrefmat;Frefmat;FArefmat;Brefmat;LUrefmat;OOrefmat;Rrrefmat;HEDrefmat;Nrefmat;Harefmat;Lrefmat;Ttrefmat;Iyrefmat;Emrefmat];
  
  save('NEW_HOMO_AUTO_PHONEME_REFMAT','NEW_HOMO_AUTO_PHONEME_REFMAT');
  