%STEP1: load raw sEMG
        % column 1: timeline;
        % column 2: sEMG of Bicepes;
        % sample rate: 1926Hz
        clc;
        clear;
        close all;
        
        load('sEMG_RAW.mat');        
        Fs = 1000;   % sEMG  Sampling frequency

TimeDormain.orig = sEMG_RAW(:,2);
[Freq.orig,Amp.orig] = FFTOperator( TimeDormain.orig,Fs );
figure(1);
plot(Freq.orig(1:500),Amp.orig(1:500)) 
title('origEMG')
xlabel('f (Hz)')
ylabel('Amplitude')

% STEP2: 50Hz bandstop
[TimeDormain.bandStopResult] = BandStop ( TimeDormain.orig,Fs);
[Freq.bandStop,Amp.bandStop] = FFTOperator( TimeDormain.bandStopResult,Fs );
figure(2);
plot(Freq.bandStop(1:500),Amp.bandStop(1:500)) 
title('50 Hz bandstop')
xlabel('f (Hz)')
ylabel('Amplitude')

% STEP3: [10Hz,450Hz] bandpass
[TimeDormain.bandPassResult] = BandPass ( TimeDormain.bandStopResult,Fs,10,450);
[Freq.bandPass,Amp.bandPass] = FFTOperator( TimeDormain.bandPassResult,Fs );
figure(3);
plot(Freq.bandPass(1:500),Amp.bandPass(1:500)) 
title('bandpass')
xlabel('f (Hz)')
ylabel('Amplitude')

figure(4),hold on,
P1 = plot(Freq.orig(1:450),Amp.orig(1:450));         set(P1,'Color','red','LineWidth',1)
P2 = plot(Freq.bandStop(1:450),Amp.bandStop(1:450)); set(P2,'Color','green','LineWidth',2)
P3 = plot(Freq.bandPass(1:450),Amp.bandPass(1:450)); set(P3,'Color','blue','LineWidth',2)
title('Peprocessed sEMG ')
xlabel('f (Hz)')
ylabel('Amplitude')
legend('origData','bandStop','bandPass');

figure(5),hold on,
time = [1:length(sEMG_RAW(:,1))]/Fs;
P1 = plot(time,TimeDormain.orig);           set(P1,'Color','red','LineWidth',1)
P2 = plot(time,TimeDormain.bandStopResult); set(P2,'Color','green','LineWidth',2)
P3 = plot(time,TimeDormain.bandPassResult); set(P3,'Color','blue','LineWidth',2)
title('sEMG Process')
xlabel('Time (S)')
ylabel('Amplitude')
legend('origData','bandStop','bandPass');
