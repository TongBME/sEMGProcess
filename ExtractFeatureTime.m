% feature extraction in time dormain
load('sEMG_TIME.mat'); 
Fs = 1000;
EMG_DATA   = double(TimeDormain.bandStopResult(:,1));
N = size(EMG_DATA,1);

% time window length: 200 points(0.2s)
% forward motion increment: 20 points (0.02s)
for i=0:86
    ch1 = EMG_DATA(20*i+1:20*i+200,:);
    % Mean Absolute Value
    MAV(i+1) =  mean(abs(ch1));
    % RMS
    RMS(i+1) = sqrt(mean(ch1.^2)); 
    % Waveform Length 
    WL(i+1) = sum(abs(diff(ch1)))/length(ch1);
    
    % Willison Activation 
    Threshold = mean(abs(EMG_DATA));
    data_size = length(ch1);
    feature = 0;
        for j=2:data_size
            difference = ch1(j) - ch1(j-1);
            if abs(difference) > Threshold
                feature = feature + 1;
            end
        end
    WA(i+1) = feature/data_size;
    
    % Number of Crossing Zero
    DeadZone = 10e-7;
    feature_zc = 0;
    for k=2:data_size
        difference = ch1(k) - ch1(k-1);
        multy      = ch1(k) * ch1(k-1);
        if abs(difference)>DeadZone && multy<0
            feature_zc = feature_zc + 1;
        end
    end
    ZC(i+1) = feature_zc/data_size;
    
   % Sign of Slope Changes SSC
    feature = 0;
    for m=3:data_size
        difference1 = ch1(m-1) - ch1(m-2);
        difference2 = ch1(m-1) - ch1(m);
        Sign = difference1 * difference2;
        if Sign > 0
            if abs(difference1)>DeadZone || abs(difference2)>DeadZone
                feature = feature + 1;
            end
        end
    end
    SSC(i+1) = feature/data_size;
    
    % Auto Regression
    order = 6;              
    f = real(lpc(ch1,order)');    %lpc():Linear prediction filter coefficients
    ARC(i+1) = -f(order+1,:); 
end

figure(1),hold on,
P1 = plot(MAV); set(P1,'Color','red','LineWidth',1)
P2 = plot(RMS); set(P2,'Color','blue','LineWidth',1)
P3 = plot(WL); set(P3,'Color','green','LineWidth',1)
title('Time Dormain Feature Extraction')
xlabel('Delta Window Sequence')
ylabel('Amplitude')
legend('MAV','RMS','WL');

figure(2),hold on,
P1 = plot(ZC); set(P1,'Color','red','LineWidth',1)
P3 = plot(SSC); set(P3,'Color','green','LineWidth',1)
title('Time Dormain Feature Extraction')
xlabel('Delta Window Sequence')
ylabel('Amplitude')
legend('ZC','SSC');

figure(3),hold on,
P1 = plot(ARC); set(P1,'Color','red','LineWidth',1)
%P2 = plot(WA); set(P2,'Color','blue','LineWidth',1)
title('Time Dormain Feature Extraction')
xlabel('Delta Window Sequence')
ylabel('Amplitude')
%legend('ARC','WA');

