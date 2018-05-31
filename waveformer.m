function wave = waveformer(codeword, B_trunc, fs, sync_len)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

f1 = 1500; % Hz
f2 = 2500; % Hz

% preamble for synchronization
symbols_preamble=mapping(lfsr_framesync(sync_len), 'BPSK');
codeword = [symbols_preamble; codeword];

signal= conv(upsample(codeword,length(B_trunc)),B_trunc.'); % upsampling by length(B_trunc) eliminates ISI (I think)
t = linspace(0,(length(signal)-1)/fs,length(signal));
harm1 = exp(-2*pi*1i*f1*t);
harm2 = exp(-2*pi*1i*f2*t);

wave = sqrt(2)*real(signal.*(harm1+harm2)');

end

