clc
clear all;
Time=4; % the audio recording time
Fs =16000;% sampling frequency
L=400; %L=size of frame samples
R=200;% R=size  frame shift samples
disp('start recording');
y = wavrecord(Time*Fs,Fs);% audio samples are recorded 
disp('stop recording');
%[y,Fs] = getaudiodata('zerosample.wav');
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
  figure(1)
    subplot(4,1,1)
    plot(y); grid on;
    xlabel('time');ylabel('amplitude');
    title('input audio signal');
    subplot(4,1,2)
    plot(1:nfrm,energy,'r'); grid on;
    xlabel('Number of frames'); ylabel('Log of Energy(dB)');
    title('Energy plot');
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
     subplot(4,1,3)
     plot(1:newlen,newen,'r'); grid on;
     xlabel('Number of frames');ylabel('Log of energy(dB)');
     title('The energy of the signal which is greater than Threshold');
   sound(nnewframe,Fs);
     subplot(4,1,4)
     plot(nnewframe);grid on;
     xlabel('Time'); ylabel('amplitude');
     title('New signal');
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

figure(2)
subplot(2,1,1);
pwelch(xn,[],[],[],Fs); hold on;
title('signal before pre emphasis');
subplot(2,1,2)
pwelch(ypre,[],[],[],Fs); hold on;
title('signal after Pre emphasis');
%%%%%%pre emphasis is done    %%%
%%framing started%%%%%%%
w_length=200; 
w_step=80;
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
   dotproduct=(abs(fftypre2 .* conjugatemat));
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
dctout=dct(logoffilter);
 figure(3)
 stem(totalpower); hold on;
 xlabel('Filter Number'); ylabel('Power in watts');
 figure(4)
 surf(filterout(:,1:26)); hold on;

%**********************************************************************
%Delta computation%

    
   


     
         