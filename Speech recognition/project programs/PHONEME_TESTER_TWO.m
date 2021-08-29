 % this program is for the genrating refmat(reference  matrix)
clc
clear all;
PHONEME_REFMAT2=[];
for i=6:10
  for  j=1:5
      load(sprintf('SIH_SAMPLE_%d.mat',i));
      SIHrefmat(j,:)=[a];
end
end
for i=6:10
    for j=1:5
      load(sprintf('K_SAMPLE_%d.mat',i));
      Krefmat(j,:)=[a];
    end
end

for i=6:10
     for j=1:5
      load(sprintf('SIL_SAMPLE_%d.mat',i));
      SILrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('S_SAMPLE_%d.mat',i));
      Srefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('ZE_SAMPLE_%d.mat',i));
      ZErefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('IY_SAMPLE_%d.mat',i));
      IYrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('RO_SAMPLE_%d.mat',i));
      ROrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('WAN_SAMPLE_%d.mat',i));
      WANrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('TO_SAMPLE_%d.mat',i));
      TOrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('EY_SAMPLE_%d.mat',i));
      EYrefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('FA_SAMPLE_%d.mat',i));
      FArefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('IVE_SAMPLE_%d.mat',i));
      IVErefmat(j,:)=[a];
     end
end
for i=6:10
     for j=1:5
      load(sprintf('EHV_SAMPLE_%d.mat',i));
      EHVrefmat(j,:)=[a];
     end
end
for i=6:10
 for   j=1:5
      load(sprintf('N_SAMPLE_%d.mat',i));
      Nrefmat(j,:)=[a];
 end
end
% 
% 
for i=6:10
     for   j=1:5
      load(sprintf('TH_SAMPLE_%d.mat',i));
      THrefmat(j,:)=[a];
    end
end
for i=6:10
     for   j=1:5
      load(sprintf('OW_SAMPLE_%d.mat',i));
      OWrefmat(j,:)=[a];
     end
end
for i=6:10
     for   j=1:5
      load(sprintf('F_SAMPLE_%d.mat',i));
      Frefmat(j,:)=[a];
     end
end
PHONEME_REFMAT2=[SILrefmat;Krefmat;SIHrefmat;Srefmat;ZErefmat;IYrefmat;ROrefmat;WANrefmat;TOrefmat;EYrefmat;FArefmat;IVErefmat;EHVrefmat;Nrefmat;THrefmat;OWrefmat;Frefmat];
  
  save('PHONEME_REFMAT2','PHONEME_REFMAT2');
  