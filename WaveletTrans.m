function [ appcoef_t,decoef_t ] = WaveletTrans( data,layerNum,num )
% Input:                           % Output:
%       data: sEMG data                     % waveTrans.decoef:  detail coefficient
%       layerNum: WT layer number           % waveTrans.appcoef: appropriate coefficient
%       num: current layer 

% Wavelet Transform
        % wavedec: wavelet decompose
        % waverec: wavelet reconstruct
        % wrcoef: wavelet reconstruct coefficient
        
db = 'sym4';
[c,l] = wavedec(data,layerNum,db);
% appropriate coefficient
appcoef_t = wrcoef('a',c,l,db,num);
% detail coefficient
decoef_t = wrcoef('d',c,l,db,num);

end

