function bandPassResult = BandPass ( signalSource,Fs,Fc1,Fc2)
% Butterworth Bandpass filter designed using FDESIGN.BANDPASS.
% All frequency values are in Hz.

%Fc1 : First Cutoff Frequency
%Fc2 :Second Cutoff Frequency
N   = 10;   % Order

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandpass('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

SOS             = Hd.sosMatrix;
G               = Hd.ScaleValues;
bandPassResult  = filtfilt(SOS, G, signalSource);

% [EOF]
