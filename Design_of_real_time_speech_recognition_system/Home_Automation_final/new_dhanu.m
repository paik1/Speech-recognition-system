clear all
clc
rd=0;
bl=0;
on=0;
of=0;
fn=0;
tim=0;
hel=0;
%   ser_obj=serial('COM7','BaudRate',9600);
%   fopen(ser_obj);
Time=7; % the audio recording time
Fs=16000;% sampling frequency
L=800; %L=size of frame samples
R=400;% R=size  frame shift samples
 disp('start recording');
   recobj=audiorecorder(16000,16,1);
   recordblocking(recobj,Time)
   y = getaudiodata(recobj);
%y = wavrecord(Time*Fs,Fs);
%[y,Fs] = audioread('door2.wav');
 disp('stop recording');
%sound(y,Fs,16);
 nsamples=length(y);
    ss=1;% signal starting frame
    energy=[];% energy array declaration
    while (ss+L-1 <= nsamples)
        frame=y(ss:ss+L-1).*hamming(L);
        energy=([energy 10*log10(sum(frame.^2))]);%calculating the log of energy 
        ss=ss+R;% number of shifts
    end
    nfrm=length(energy);
  energy=energy+50;
%   disp(energy);
%   figure(1)
%     subplot(4,1,1)
%     plot(y); grid on;
%     xlabel('time');ylabel('amplitude');
%     title('input audio signal');
%     subplot(4,1,2)
%     plot(1:nfrm,energy,'r'); grid on;
%     xlabel('Number of frames'); ylabel('Log of Energy(dB)');
%     title('Energy plot');
%      newen=[];
     newframe=[];
     nnewframe1=[];
      nnewframe2=[];
       nnewframe3=[];
     ss=1;
     preframe=1;
     nextframe=1;
     h=0;
     first=0;
     newen=[];
     i=1;
      while(i<nfrm)
         if energy(i)<=50
             i=i+1;
         end
         if energy(i)>50
             h=h+1;
          while(energy(i)>50)
           newen = [newen energy(i)];
                if(nextframe-preframe==1)
             newframe=y(ss+R:ss+L-1);
              else
                 newframe=y(ss:ss+L-1);
                 end
             if(h==1)
             nnewframe1=[nnewframe1 ;newframe];
             elseif(h==2)
                 nnewframe2=[nnewframe2 ;newframe];
             else
                 nnewframe3=[nnewframe3 ;newframe];
             end
             preframe=nextframe;
             i=i+1;
             ss=ss+R;
         nextframe=nextframe+1;
             end
            end
         ss=ss+R;
         nextframe=nextframe+1;
          end
     newlen=length(newen);
     %sound(nnewframe1,Fs);
     xn=nnewframe1;
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
%*******************************************************************************
%    figure(1)
%   surf(filterout(:,1:26));
% xlabel('Filter Bank Numbers');ylabel('Number of Frames');
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
    
% minX = min(powerarray);
% maxX = max(powerarray);
% len = length(powerarray);
% 
% for j = 1:10
%     idxMin = j;
%     for i = j+1:length(powerarray)       
%         if(powerarray(i) > powerarray(idxMin))
%             idxMin = i;
%         end
%     end
%     tmp1 = powerarray(idxMin);
%      tmp2 = framesarray(idxMin);
%       tmp3 = filterbankarray(idxMin);
%     powerarray(idxMin) = powerarray(j);
%     framesarray(idxMin) = framesarray(j);
%     filterbankarray(idxMin) = filterbankarray(j);
%     newpowerarray(j) = tmp1;
%     newframesarray(j) = tmp2;
%     newfilterbankarray(j) = tmp3;
% end
% %%%%%%%%Sorting based on the frames
% NewFRAME=[];
% NewFB=[];
% NewPOWER=[];
% minX = min(newframesarray);
% maxX = max(newframesarray);
% len = length(newframesarray);
% for j = 1:10
%     idxMin = j;
%     for i = j+1:length(newframesarray)       
%         if(newframesarray(i) < newframesarray(idxMin))
%             idxMin = i;
%         end
%     end
%     tmp4 = newframesarray(idxMin);
%     newframesarray(idxMin) = newframesarray(j);
%     NewFRAME(j) = tmp4;
%     tmp5 = newfilterbankarray(idxMin);
%     newfilterbankarray(idxMin) = newfilterbankarray(j);
%     NewFB(j) = tmp5;
%     tmp6 = newpowerarray(idxMin);
%     newpowerarray(idxMin) = newpowerarray(j);
%     NewPOWER(j) = tmp6;
% end
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
%  figure(2) 
%  plot(t2);
tfinalextract=transpose(finalextract);
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SVM_Classifier%%%%%%%%%%%
 PHONEME_NUM_ARRAY=[];
load NEW_HOMO_AUTO_PHONOME_TRAINED_matrix.mat
for i=1:z-2
    out=svmclassify(svm_struct(1),tfinalextract(i,:));
    if (out==1)
        disp('SIL')
     PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;0];
    else
    out=svmclassify(svm_struct(2),tfinalextract(i,:));
    if(out==1)
        disp('OW')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;1];
    else
        out=svmclassify(svm_struct(3),tfinalextract(i,:));
        if (out==1)
        disp('F');
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;2];
        else
        out=svmclassify(svm_struct(4),tfinalextract(i,:));
        if (out==1)
        disp('FA')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;3];
        else
        out=svmclassify(svm_struct(5),tfinalextract(i,:));
        if (out==1)
        disp('B')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;4];
        else
        out=svmclassify(svm_struct(6),tfinalextract(i,:));
        if (out==1)
        disp('LU')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;5];
        else
        out=svmclassify(svm_struct(7),tfinalextract(i,:));
        if (out==1)
        disp('00')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;6];
        else
        out=svmclassify(svm_struct(8),tfinalextract(i,:));
        if (out==1)
        disp('Rr')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;7];
         else
        out=svmclassify(svm_struct(9),tfinalextract(i,:));
        if (out==1)
        disp('HED')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;8];
         else
        out=svmclassify(svm_struct(10),tfinalextract(i,:));
        if (out==1)
        disp('N')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;9];
         else
        out=svmclassify(svm_struct(11),tfinalextract(i,:));
        if (out==1)
        disp('Ha')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;10];
         else
        out=svmclassify(svm_struct(12),tfinalextract(i,:));
        if (out==1)
        disp('L')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;11];
         else
        out=svmclassify(svm_struct(13),tfinalextract(i,:));
        if (out==1)
        disp('Tt')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;12];
         else
        out=svmclassify(svm_struct(14),tfinalextract(i,:));
        if (out==1)
        disp('Iy')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;13];
         else
        out=svmclassify(svm_struct(15),tfinalextract(i,:));
        if (out==1)
        disp('Em')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;14];
         else
        out=svmclassify(svm_struct(16),tfinalextract(i,:));
        if (out==1)
        disp('Dd')
         PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY;15];
       else
        disp('R');
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
LENGTH_PHONEME_ARRAY=length(PHONEME_NUM_ARRAY);
if(LENGTH_PHONEME_ARRAY>=35)
    PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY(1:35,:)];
    tPHONEME_NUM_ARRAY=transpose(PHONEME_NUM_ARRAY);
else
  PHONEME_NUM_ARRAY=[PHONEME_NUM_ARRAY ; transpose(zeros(1,(35-(z-2))))];
tPHONEME_NUM_ARRAY=transpose(PHONEME_NUM_ARRAY);
end
load RBF_HEL_TI_TRAINED_matrix.mat
for i=1
    out=svmclassify(svm_struct(1),tPHONEME_NUM_ARRAY(i,:));
    if (out==1)
        disp('RED');
        rd=1;
    else
        out=svmclassify(svm_struct(2),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('BLUE');
        bl=1;
         else
        out=svmclassify(svm_struct(3),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('FAN');
        fn=1;
         else
        out=svmclassify(svm_struct(4),tPHONEME_NUM_ARRAY(i,:));
        if (out==1)
        disp('TIME');
        tim=1;
        else
        disp('HELLO');
        hel=1;
         end
       end
        end
    end
end

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if(tim==0 && hel==0)
        
   if(rd==1 || bl==1)
       xn1=nnewframe3;
   elseif(fn==1)
       xn1=nnewframe2;
   end

  n=length(xn1);
    
     ypr1=[];
    ypre1=[];
     ypr1(1)=xn1(1);
     for j=2:1:n 
         ypr1(j)=xn1(j)-(0.95*xn1(j-1));
     end
ypre1=transpose(ypr1) ;  
soundsc(ypre1,Fs)
%%%%%%%pre emphasis is done    %%%
%%framing started%%%%%%%
w_length=400; 
w_step=240;
prelength1=length(ypre1);
fftypre1=[];
premphframe1=[];
Nfft1=512;
powerspec1=[];
w=1;
energy2=[];
    sigs=1;% signal starting frame
    while (sigs+w_length-1<= prelength1)
        premphframe1 = ypre1(sigs:sigs+w_length-1).*hamming(w_length);
        ene1=0;
        for i=1:400
            ene1=ene1+(premphframe1(i).^2);
        end
        energy2=[energy2 ene1];
        fftypre1 =[fftypre1  fft(premphframe1,Nfft)];
       sigs=sigs+w_step;% number of shifts
    end
    fftypre3=transpose(fftypre1);
    fftypre4=fftypre3(:,1:257);
   conjugatemat=conj(fftypre4);
   dotproduct=(((fftypre4 .* conjugatemat)/Nfft));%change 14/02
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
% %    figure(1)
% %   surf(filterout(:,1:26));
% % xlabel('Filter Bank Numbers');ylabel('Number of Frames');
% %**********************************************************************
[b(:,1),b(:,2)]=max(filterout,[],2);
framesarray1=[];
powerarray1=[];
filterbankarray=[];
newpowerarray1=[];
newframesarray1=[];
newfilterbankarray1=[];

powerarray1=[b(:,1)];
filterbankarray1=[b(:,2)]; 
len=length(powerarray1);
newfilterbankarraydkkrest1=[];
threshold=0.02;
for i=1:len
    if(powerarray1(i)>threshold)
        newfilterbankarraydkktest1(i)=filterbankarray1(i);
    else
        newfilterbankarraydkktest1(i)=0;
    end
end
     for z1=1:length(powerarray1)
         framesarray1 =[framesarray1 z1];
     end 
% %%%%%%%%%%%%%%commentted blocks start
%%%%%%%%%%%%%%%commemtted blocks end
%delta calculation
for i=2:z1-1
    for j=1:26
        delta(j,i-1)=(dctout(j,i-1)-dctout(j,i+1))/2;
    end
end
newfilterbankarraydkktest1=[newfilterbankarraydkktest1 zeros(1,50-length(newfilterbankarraydkktest1))];
t3=newfilterbankarraydkktest1;
t4=[];
    k=1;
    count=0;
    zerocount=0;
    for j=1:50
        if(zerocount==0)
        if(t(j)==0)
            count=count+1;
        else
            t4(k)=t(j);
            zerocount=1;
            k=k+1;
        end
        else
             t4(k)=t(j);
            k=k+1;
        end
    end
    for n=1:count
                t3(k)=0;
                k=k+1;
    end
     t5=[];
     t5=t4(:,1:31);
% %%%%%%%%%%%%%%%%%%%%%%%%%%%% 
finalextract1=[];
dctfinal1=dctout(2:13,2:z1-1);
deltafinal1=delta(2:13,:);
energy3=energy2(2:z1-1);
for i=1:z1-2
    finalextract1(:,i)=[dctfinal1(:,i); deltafinal1(:,i) ;energy3(i)];
end
% % % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SVM_Classifier%%%%%%%%%%%
tfinalextract1=transpose(finalextract1);
 PHONEME_NUM_ARRAY1=[];
load HOMO_AUTO_ON_OFF_PHONOME_TRAINED_matrix.mat
for i=1:z1-2
    out=svmclassify(svm_struct(1),tfinalextract1(i,:));
    if (out==1)
        disp('SIL')
     PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1;0];
    else
    out=svmclassify(svm_struct(2),tfinalextract1(i,:));
    if(out==1)
        disp('OW')
         PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1;1];
    else
        out=svmclassify(svm_struct(3),tfinalextract1(i,:));
        if (out==1)
        disp('F');
        PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1;2];
       else
        disp('N');
         PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1;3];
        end
        end
        end
        
end
LENGTH_PHONEME_ARRAY1=length(PHONEME_NUM_ARRAY1);
if(LENGTH_PHONEME_ARRAY1>=40)
    PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1(1:40,:)];
    tPHONEME_NUM_ARRAY1=transpose(PHONEME_NUM_ARRAY1);
else
  PHONEME_NUM_ARRAY1=[PHONEME_NUM_ARRAY1 ; transpose(zeros(1,(40-(z1-2))))];
tPHONEME_NUM_ARRAY1=transpose(PHONEME_NUM_ARRAY1);
 end
load ON_OFF_TRAINED_matrix.mat
for i=1
    out=svmclassify(svm_struct(1),tPHONEME_NUM_ARRAY1(i,:));
        if (out==1)
        disp('ON');
        on=1;
        else
         disp('OFF');
         of=1;
         end
       end
    end
% %********************************************************************************
      if(rd==1 && on==1)
        disp('RED LIGHT ON');
         %fwrite(ser_obj,'3');
      % set(handles.text2,'String', 'RED LIGHT ON');
    elseif(rd==1 && of==1)
        disp('RED LIGHT OFF');
         %fwrite(ser_obj,'4');
     %  set(handles.text2,'String', 'RED LIGHT OFF');
    elseif(bl==1 && on==1)
        disp('BLUE LIGHT ON');
         %fwrite(ser_obj,'1');
    % set(handles.text2,'String', 'BLUE LIGHT ON');
    elseif(bl==1 && of==1)
        disp('BLUE LIGHT OFF');
         %fwrite(ser_obj,'2');
   % set(handles.text2,'String', 'BLUE LIGHT OFF');
     elseif(fn==1 && on==1)
         disp('FAN ON');
         %fwrite(ser_obj,'5');
      %set(handles.text2,'String', 'FAN ON');
     elseif(fn==1 && of==1)
         disp('FAN OFF');
        % fwrite(ser_obj,'6');
         %set(handles.text2,'String', 'FAN OFF');
 elseif(tim==1)
         disp('TIME');
         %set(handles.text2,'String', 'TIME');
       %  fwrite(ser_obj,'b');
         c=clock;
         year=c(1);
         month=c(2);
         day=c(3);
         hour=c(4);
         minute=c(5);
         second=c(6);
         d=round(c(6));
         Current_time=[];
         Current_time=[c(4) c(5) d];
         Date=[];
         Date=[ c(3) c(2) c(1)];
         display(Current_time);
         display(Date);
          elseif(hel==1)
               c=clock;
               hour=c(4);
              if(hour<12 && hour>6)
                  [cht,Fs] = audioread('GOODMORNING.wav');
                  sound(cht,Fs);
      %           fwrite(ser_obj,'7');
              elseif(hour>=12 && hour<17)
                  [cht,Fs] = audioread('GOODAFTERNOON.wav');
                  sound(cht,Fs);
     %                fwrite(ser_obj,'8');
              elseif(hour>=17 && hour<20)
                  [cht,Fs] = audioread('GOODEVENGING.wav');
                  sound(cht,Fs);
     %              fwrite(ser_obj,'9');
              else(hour>=20  && hour<=6)
                 [cht,Fs] = audioread('GOODNIGHT.wav');
                  sound(cht,Fs);
    %                 fwrite(ser_obj,'a');
              end
            disp('HELLO');
         %set(handles.text2,'String', 'HELLO');

     end
   %delete(instrfindall)