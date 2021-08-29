clc
clear all;
Time=5; % the audio recording time
Fs = 16000;% sampling frequency
L=800; %L=size of frame samples
R=400;% R=size  frame shift samples
disp('start recording');
y = wavrecord(Time*Fs,Fs);% audio samples are recorded 
%[y,Fs] = wavread('0_sample_1.wav');
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
  disp(energy);
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
    figure(2)
    subplot(2,1,1)
    plot(y); grid on;
    xlabel('time');ylabel('amplitude');
    title('input audio signal');
    subplot(2,1,2)
    plot(nnewframe);grid on;
     xlabel('Time'); ylabel('amplitude');
     title('End point detected signal');
     figure(3)
     subplot(2,1,1)
    plot(1:nfrm,energy,'r'); grid on;
    xlabel('Number of frames'); ylabel('Log of Energy(dB)');
    title('Energy plot for the recorded signal ');
     subplot(2,1,2)
     plot(1:newlen,newen,'r'); grid on;
     xlabel('Number of frames');ylabel('Log of energy(dB)');
     title('The energy of the signal which is greater than Threshold 40dB');