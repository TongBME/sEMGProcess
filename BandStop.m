function bandStopResult = BandStop ( signalSource,Fs)
%BANDSTOP Returns a discrete-time filter object.

% MATLAB Code
% Butterworth Bandstop filter designed using FDESIGN.BANDSTOP.

% All frequency values are in Hz.

N   = 10;    % Order
Fc1 = 49.9;  % First Cutoff Frequency
Fc2 = 50.1;  % Second Cutoff Frequency

% Construct an FDESIGN object and call its BUTTER method.
h  = fdesign.bandstop('N,F3dB1,F3dB2', N, Fc1, Fc2, Fs);
Hd = design(h, 'butter');

SOS             = Hd.sosMatrix;
G               = Hd.ScaleValues;
bandStopResult  = filtfilt(SOS, G, signalSource);

% [EOF]
