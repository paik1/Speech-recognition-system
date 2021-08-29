clc ;
clear all;
Time=1; % the audio recording time
Fs =16000;% sampling frequency
L=400; %L=size of frame samples
R=200;% R=size  frame shift samples
disp('start recording');
y = wavrecord(Time*Fs,Fs);
%[y,Fs] = wavread('8_test_0.wav');
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
    sigs=1;% signal starting frame
    while (sigs+w_length-1<= prelength)
        premphframe = ypre(sigs:sigs+w_length-1).*hamming(w_length);
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
%totalpower=sum(filterout);
logoffilter=log(filterout);
trans=transpose(logoffilter);
dctout=dct(trans);
%  figure(6)
%  surf(filterout(:,1:26));

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
newfilterbankarraydkk=[];
threshold=0.02;
for i=1:len
    if(powerarray(i)>threshold)
        newfilterbankarraydkk(i)=filterbankarray(i);
    else
        newfilterbankarraydkk(i)=0;
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
%%%%%%%%%%%%%%%%%%%%construction of lookup table%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%Euclidean distance calculation%%%%%%

  load newtestmatrix1.mat;
 newfilterbankarraydkk=[newfilterbankarraydkk zeros(1,50-length(newfilterbankarraydkk))];
for i=1:100
    output(i) = sqrt(sum((newfilterbankarraydkk-newtestmatrix1(i,:)).^2));
end

[~,index] = min(output);
disp(floor((index-1)/10));
        