 % this program is for the genrating refmat(reference  matrix)
clc
clear all;
PHONEME_REFMAT1=[];
for i=1:5
      load(sprintf('SIH_SAMPLE_%d.mat',i));
      SIHrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('K_SAMPLE_%d.mat',i));
      Krefmat(i,:)=[a];
end

for i=1:5
      load(sprintf('SIL_SAMPLE_%d.mat',i));
      SILrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('S_SAMPLE_%d.mat',i));
      Srefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('ZE_SAMPLE_%d.mat',i));
      ZErefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('IY_SAMPLE_%d.mat',i));
      IYrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('RO_SAMPLE_%d.mat',i));
      ROrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('WAN_SAMPLE_%d.mat',i));
      WANrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('TO_SAMPLE_%d.mat',i));
      TOrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('EY_SAMPLE_%d.mat',i));
      EYrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('FA_SAMPLE_%d.mat',i));
      FArefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('IVE_SAMPLE_%d.mat',i));
      IVErefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('EHV_SAMPLE_%d.mat',i));
      EHVrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('N_SAMPLE_%d.mat',i));
      Nrefmat(i,:)=[a];
end
% 
% 
for i=1:5
      load(sprintf('TH_SAMPLE_%d.mat',i));
      THrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('OW_SAMPLE_%d.mat',i));
      OWrefmat(i,:)=[a];
end
for i=1:5
      load(sprintf('F_SAMPLE_%d.mat',i));
      Frefmat(i,:)=[a];
end
%Nrefmat;THrefmat;OWrefmat;Frefmat

PHONEME_REFMAT1=[SILrefmat;Krefmat;SIHrefmat;Srefmat;ZErefmat;IYrefmat;ROrefmat;WANrefmat;TOrefmat;EYrefmat;FArefmat;IVErefmat;EHVrefmat;Nrefmat;THrefmat;OWrefmat;Frefmat];
  
  save('PHONEME_REFMAT1','PHONEME_REFMAT1');
  