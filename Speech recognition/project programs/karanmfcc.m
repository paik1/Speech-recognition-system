clc
clc ;
clear all;
Time=1; % the audio recording time
Fs =16000;% sampling frequency
L=400; %L=size of frame samples
R=200;% R=size  frame shift samples
disp('start recording');
y = wavrecord(Time*Fs,Fs);
%[y,Fs] = wavread('9_sample_10.wav');
disp('stop recording');
sound(y,Fs);
 nsamples=length(y);
    ss=1;% signal starting frame
    energy=[];% energy array declaration
    while (ss+L-1 <= nsamples)
        frame=y(ss:ss+L-1).*hamming(L);
        energy=([energy 10*log10(sum(frame.^2))]);%calculating the log of energy 
        ss=ss+R;% number of shifts
    end
    nfrm=length(energy);
  energy=energy+60;
  %disp(energy);
%   figure(1)
%     subplot(4,1,1)
%     plot(y); grid on;
%     xlabel('time');ylabel('amplitude');
%     title('input audio signal');
%     subplot(4,1,2)
%     plot(1:nfrm,energy,'r'); grid on;
%     xlabel('Number of frames'); ylabel('Log of Energy(dB)');
%     title('Energy plot');
     newen=[];
     newframe=[];
     nnewframe=[];
     ss=1;
     preframe=1;
     nextframe=1;
     for i=1:1:nfrm
         if energy(i)>40
             newen = [newen energy(i)];
             if(nextframe-preframe==1)
             newframe=y(ss+R:ss+L-1);
         
             else
                 newframe=y(ss:ss+L-1);
             end
             nnewframe=[nnewframe ;newframe];
             preframe=nextframe;
         end
         ss=ss+R;
         nextframe=nextframe+1;
     end
     newlen=length(newen);

     xn=nnewframe;
     n=length(xn);
    
     ypr=[];
    ypre=[];
     ypr(1)=xn(1);
     for j=2:1:n 
         ypr(j)=xn(j)-(0.95*xn(j-1));
     end
ypre=transpose(ypr) ;  
soundsc(ypre,Fs)

%%%%%%%pre emphasis is done    %%%
%%framing started%%%%%%%
w_length=400; 
w_step=240;
prelength=length(ypre);
fftypre=[];
premphframe=[];
Nfft=512;
powerspec=[];
w=1;
energy1=[];
    sigs=1;% signal starting frame
    while (sigs+w_length-1<= prelength)
        premphframe = ypre(sigs:sigs+w_length-1).*hamming(w_length);
        ene=0;
        for i=1:400
            ene=ene+(premphframe(i).^2);
        end
        energy1=[energy1 ene];
        fftypre =[fftypre  fft(premphframe,Nfft)];
       sigs=sigs+w_step;% number of shifts
    end
    fftypre1=transpose(fftypre);
    fftypre2=fftypre1(:,1:257);
   conjugatemat=conj(fftypre2);
   dotproduct=(((fftypre2 .* conjugatemat)/Nfft));%change 14/02
f_min=0;
fs=16000;
fnumber=26;
f_low=300;
f_high=8000;
f_max=0.5*fs;
flength=257;
freq=linspace(f_min,f_max,flength);
x=1127*log(1+(300/700));
y1=1127*log(1+(8000/700));
mid=(y1-x)/27;
Mel=[];
for i=x:mid:y1
    Mel=[Mel i];
end
cfreq=[];
for i=1:1:28
    melf=700*(exp(Mel(i)/1127)-1);
    cfreq=[cfreq melf];
end
Fbank=zeros(fnumber,flength);
for i=1:fnumber
    j=freq>=cfreq(i)&freq<=cfreq(i+1);
    Fbank(i,j)=(freq(j)-cfreq(i))/(cfreq(i+1)-cfreq(i));
    j = freq>=cfreq(i+1)&freq<=cfreq(i+2);
    Fbank(i,j)=(cfreq(i+2)-freq(j))/(cfreq(i+2)-cfreq(i+1));
end
tFbank=transpose(Fbank);
filterout=(dotproduct*tFbank);
totalpower=sum(filterout);
logoffilter=log(filterout);
trans=transpose(logoffilter);
dctout=dct(trans); 
%    figure(1)
%    surf(filterout(:,1:26));

%**********************************************************************
[a(:,1),a(:,2)]=max(filterout,[],2);
framesarray=[];
powerarray=[];
filterbankarray=[];
newpowerarray=[];
newframesarray=[];
newfilterbankarray=[];

powerarray=[a(:,1)];
filterbankarray=[a(:,2)]; 
len=length(powerarray);
newfilterbankarraydkkrest=[];
threshold=0.02;
for i=1:len
    if(powerarray(i)>threshold)
        newfilterbankarraydkktest(i)=filterbankarray(i);
    else
        newfilterbankarraydkktest(i)=0;
    end
end

     for z=1:length(powerarray)
         framesarray =[framesarray z];
     end
    
minX = min(powerarray);
maxX = max(powerarray);
len = length(powerarray);

for j = 1:10
    idxMin = j;
    for i = j+1:length(powerarray)       
        if(powerarray(i) > powerarray(idxMin))
            idxMin = i;
        end
    end
    tmp1 = powerarray(idxMin);
     tmp2 = framesarray(idxMin);
      tmp3 = filterbankarray(idxMin);
    powerarray(idxMin) = powerarray(j);
    framesarray(idxMin) = framesarray(j);
    filterbankarray(idxMin) = filterbankarray(j);
    newpowerarray(j) = tmp1;
    newframesarray(j) = tmp2;
    newfilterbankarray(j) = tmp3;
end
% disp( newpowerarray);
% disp(newframesarray);
% disp(newfilterbankarray);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%Sorting based on the frames
NewFRAME=[];
NewFB=[];
NewPOWER=[];

minX = min(newframesarray);
maxX = max(newframesarray);
len = length(newframesarray);

for j = 1:10
    idxMin = j;
    for i = j+1:length(newframesarray)       
        if(newframesarray(i) < newframesarray(idxMin))
            idxMin = i;
        end
    end
    tmp4 = newframesarray(idxMin);
    newframesarray(idxMin) = newframesarray(j);
    NewFRAME(j) = tmp4;
    tmp5 = newfilterbankarray(idxMin);
    newfilterbankarray(idxMin) = newfilterbankarray(j);
    NewFB(j) = tmp5;
    tmp6 = newpowerarray(idxMin);
    newpowerarray(idxMin) = newpowerarray(j);
    NewPOWER(j) = tmp6;
    
end
%delta calculation
for i=2:z-1
    for j=1:26
        delta(j,i-1)=(dctout(j,i-1)-dctout(j,i+1))/2;
    end
end
newfilterbankarraydkktest=[newfilterbankarraydkktest zeros(1,50-length(newfilterbankarraydkktest))];
t=newfilterbankarraydkktest;
t1=[];
    k=1;
    count=0;
    zerocount=0;
    for j=1:50
        if(zerocount==0)
        if(t(j)==0)
            count=count+1;
        else
            t1(k)=t(j);
            zerocount=1;
            k=k+1;
        end
        else
             t1(k)=t(j);
            k=k+1;
        end
    end
    for n=1:count
                t(k)=0;
                k=k+1;
    end
     t2=[];
     t2=t1(:,1:31);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%     
dctfinal=dctout(2:13,2:z-1);
deltafinal=delta(2:13,:);
energy2=energy1(2:z-1);
for i=1:z-2
    finalextract(:,i)=[dctfinal(:,i); deltafinal(:,i) ;energy2(i)];
end

% figure(2) 
% plot(t2);
tfinalextract=transpose(finalextract);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SVM_Classifier%%%%%%%%%%%
PHONEME_NUM_ARRAY=[];
load 'PHONOME_TRAINED_matrix.mat';
ZECOUNT=0; IYCOUNT=0;  ROCOUNT=0;  WANCOUNT=0; TOCOUNT=0;  THCOUNT=0; EYCOUNT=0; FCOUNT=0;  OWCOUNT=0;
FACOUNT=0; IVECOUNT=0; SIHCOUNT=0; KCOUNT=0; SILCOUNT=0; SCOUNT=0; EHVCOUNT=0; NCOUNT=0;
for i=1:z-2
    out=svmclassify(svm_struct(1),tfinalextract(i,:));
    if (out==1)
        disp('SIL');
        SILCOUNT=SILCOUNT+1;
        PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;0];
    else
        out=svmclassify(svm_struct(2),tfinalextract(i,:));
        if (out==1)
        disp('K');
        KCOUNT=KCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;1];
        else
        out=svmclassify(svm_struct(3),tfinalextract(i,:));
        if (out==1)
        disp('SIH');
        SIHCOUNT=SIHCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;2];
        else
        out=svmclassify(svm_struct(4),tfinalextract(i,:));
        if (out==1)
        disp('S');
        SCOUNT=SCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;3];
        else
        out=svmclassify(svm_struct(5),tfinalextract(i,:));
        if (out==1)
        disp('ZE');
        ZECOUNT=ZECOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;4];
        else
        out=svmclassify(svm_struct(6),tfinalextract(i,:));
        if (out==1)
        disp('IY');
        IYCOUNT=IYCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;5];
        else
        out=svmclassify(svm_struct(7),tfinalextract(i,:));
        if (out==1)
        disp('RO');
        ROCOUNT=ROCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;6];
        else
        out=svmclassify(svm_struct(8),tfinalextract(i,:));
        if (out==1)
        disp('WAN');
        WANCOUNT=WANCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;7];
        else
        out=svmclassify(svm_struct(9),tfinalextract(i,:));
        if (out==1)
        disp('TO');
        TOCOUNT=TOCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;8];
        else
        out=svmclassify(svm_struct(10),tfinalextract(i,:));
        if (out==1)
        disp('EY');
        EYCOUNT=EYCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;9];
        else
        out=svmclassify(svm_struct(11),tfinalextract(i,:));
        if (out==1)
        disp('FA');
        FACOUNT=FACOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;10];
        else
        out=svmclassify(svm_struct(12),tfinalextract(i,:));
        if (out==1)
        disp('IVE');
        IVECOUNT=IVECOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;11];
        else
        out=svmclassify(svm_struct(13),tfinalextract(i,:));
        if (out==1)
        disp('EHV');
        EHVCOUNT=EHVCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;12];
        else
        out=svmclassify(svm_struct(14),tfinalextract(i,:));
        if (out==1)
        disp('N');
        NCOUNT=NCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;13];
        else
        out=svmclassify(svm_struct(15),tfinalextract(i,:));
        if (out==1)
        disp('TH');
        THCOUNT=THCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;14];
        else
        out=svmclassify(svm_struct(16),tfinalextract(i,:));
        if (out==1)
        disp('OW');
        OWCOUNT=OWCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;15];
        else
        disp('F');
        FCOUNT=FCOUNT+1;
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;16];
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
        end
    end
end
  PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY ; transpose(zeros(1,(45-(z-2))))];
tPHONEME_NUM_ARRAY=transpose(PHONEME_NUM_ARRAY);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
load DIGIT_TRAINED_matrix.mat
for i=1
    out=svmclassify(svm_struct(1),tPHONEME_NUM_ARRAY(i,:));
    if (out==1)
        disp('ZERO');
    else
        out=svmclassify(svm_struct(2),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('ONE');
        else
        out=svmclassify(svm_struct(3),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('TWO');
        else
        out=svmclassify(svm_struct(4),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('THREE');
        else
        out=svmclassify(svm_struct(5),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('FOUR');
        else
        out=svmclassify(svm_struct(6),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('FIVE');
        else
        out=svmclassify(svm_struct(7),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('SIX');
        else
        out=svmclassify(svm_struct(8),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('SEVEN');
        else
        out=svmclassify(svm_struct(9),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('EIGHT');
        else
         disp('NINE');
         end
       end
      end
     end
    end
   end
  end
 end
 end
end
       
