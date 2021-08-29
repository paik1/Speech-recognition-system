clc
clear all;
f_min=0;
fs=16000;
fnumber=26;
f_low=300;
f_high=8000;
f_max=0.5*fs;
flength=257;
freq=linspace(f_min,f_max,flength);
x=1127*log(1+(300/700));
y=1127*log(1+(8000/700));
mid=(y-x)/27;
Mel=[];
for i=x:mid:y
    Mel=[Mel i];
end
cfreq=[];
for i=1:1:28
    melf=700*(exp(Mel(i)/1127)-1);
    cfreq=[cfreq melf];
end
Fbank=zeros(fnumber,flength);
for i=1:fnumber
    j=freq>cfreq(i)&freq<=cfreq(i+1);
    Fbank(i,j)=(freq(j)-cfreq(i))/(cfreq(i+1)-cfreq(i));
    j=freq==cfreq(i);
    Fbank(i,j)=1;
    j = freq>cfreq(i+1)&freq<=cfreq(i+2);
    Fbank(i,j)=(cfreq(i+2)-freq(j))/(cfreq(i+2)-cfreq(i+1));
end

      
plot(freq,Fbank(1,:),'r');
hold on;
plot(freq,Fbank(2,:),'y');
hold on;
plot(freq,Fbank(3,:),'g');
hold on;
plot(freq,Fbank(4,:),'b');
hold on;
plot(freq,Fbank(5,:),'r');
hold on;
plot(freq,Fbank(6,:),'r');
hold on;
plot(freq,Fbank(7,:),'y');
hold on;
plot(freq,Fbank(8,:),'g');
hold on;
plot(freq,Fbank(9,:),'b');
hold on;
plot(freq,Fbank(10,:),'r');
hold on;
plot(freq,Fbank(11,:),'r');
hold on;
plot(freq,Fbank(12,:),'y');
hold on;
plot(freq,Fbank(13,:),'g');
hold on;
plot(freq,Fbank(14,:),'b');
hold on;
plot(freq,Fbank(15,:),'y');
hold on;
plot(freq,Fbank(16,:),'r');
hold on;
plot(freq,Fbank(17,:),'y');
hold on;
plot(freq,Fbank(18,:),'g');
hold on;
plot(freq,Fbank(19,:),'b');
hold on;
plot(freq,Fbank(20,:),'y');
hold on;
plot(freq,Fbank(21,:),'r');
hold on;
plot(freq,Fbank(22,:),'y');
hold on;
plot(freq,Fbank(23,:),'g');
hold on;
plot(freq,Fbank(24,:),'b');
hold on;
plot(freq,Fbank(25,:),'r');
hold on;
plot(freq,Fbank(26,:),'r');
hold on;
xlabel('Frequency in Hz'); 
ylabel('Normalized Amplitude');
title('Mel filter Bank');
