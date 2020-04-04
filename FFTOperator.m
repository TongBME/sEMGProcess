function [f,P1] = FFTOperator( Data,Fs )                    
T = 1/Fs;                % Sampling period       
L = length(Data);        % Length of signal

X = Data - mean(Data);   % Eliminate direct signal
Y = fft(X);              % FFT

P2 = abs(Y/L);
P1 = P2(1:L/2+1); 
f = Fs*(0:(L/2))/L; % Single-Side
end


