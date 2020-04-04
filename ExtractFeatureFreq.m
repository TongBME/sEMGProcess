load('sEMG_TIME.mat'); 
Fs = 1926;
EMG_DATA   = double(TimeDormain.bandPassResult(:,1));
N = size(EMG_DATA,1);

% median frequence
% median frequence
medFreq = medfreq(EMG_DATA,Fs);
meanFreq = meanfreq(EMG_DATA,Fs);

% Wavelet Transform
% layerNum = 5;% layer = 5; 
% for i = 1:layerNum
%     [waveTrans.lowTime(:,i),waveTrans.highTime(:,i)] = WaveletTrans(EMG_DATA,5,i ); 
%     [waveTrans.lowFreq(:,i),waveTrans.pLow(:,i)] = FFTOperator( waveTrans.lowTime(:,i),Fs );
%     [waveTrans.highFreq(:,i),waveTrans.pHigh(:,i)] = FFTOperator(waveTrans.highTime(:,i),Fs );
% end
% time = (1:N)/N;
% for i = 1:1:3
%     figure(1),
%     subplot(3,2,2*i-1),
%     P1 = plot(time,EMG_DATA);
%     set(P1,'Color','blue'); hold on, 
%     P2 =plot(time,waveTrans.lowTime(:,2*i-1) + waveTrans.highTime(:,2*i-1));
%     
%     set(P2,'Color','red'); title([' layer',num2str(2*i-1)]);
%     %legend('Origin','Reconstruct');
%     
%     subplot(3,2,2*i) 
%     P1 = plot(waveTrans.lowFreq(1:500,2*i-1),waveTrans.pLow(1:500,2*i-1));
%     set(P1,'Color','m'); hold on, 
%     P2 = plot(waveTrans.highFreq(1:500,2*i-1),waveTrans.pHigh(1:500,2*i-1));
%     set(P2,'Color','g'); title([' layer',num2str(2*i-1)]);
%     %legend('low','high');
% end

% PSD
nfft = N;
noverlap = N/2;
[PXX.boxcar,f2] = pwelch(EMG_DATA,boxcar(nfft),noverlap,nfft,Fs);
%[PXX.triang,f3] = pwelch(EMG_DATA,triang(nfft),noverlap,nfft,Fs,'centered','power');
[PXX.hanning,f4] = pwelch(EMG_DATA,hanning(nfft),noverlap,nfft,Fs);
%[PXX.hamming,f5] = pwelch(EMG_DATA,hamming(nfft),noverlap,nfft,Fs,'centered','power');
[PXX.blackman,f6] = pwelch(EMG_DATA,blackman(nfft),noverlap,nfft,Fs);

figure(3),hold on,
%P1 = plot(f1,10*log10(PXX.normal));set(P1,'Color','red');
P2 = plot(f2,10*log10(PXX.boxcar));set(P2,'Color','red','LineWidth',1);
%P3 = plot(f3,10*log10(PXX.triang));set(P3,'Color','blue');
P4 = plot(f4,10*log10(PXX.hanning));set(P4,'Color','green','LineWidth',1);
% P5 = plot(f5,10*log10(PXX.hamming));set(P5,'Color','m');
P6 = plot(f6,10*log10(PXX.blackman));set(P6,'Color','black','LineWidth',1);
xlabel('Frequency (Hz)')
ylabel('PSD (dB/Hz)')
legend('Boxcar','Hanning','Blackman');
%legend('Normal','Boxcar','Triangle','Hanning','Hamming','Blackman');
