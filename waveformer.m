function wave = waveformer(codeword, rolloff, span, sps, threshold)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
if threshold
    tstart = find(B>threshold, 1,'first');
    tend = find(B>threshold, 1,'last');
    B_trunc = B(tstart:tend);
else
    B_trunc = B;
end

f1 = 1500; % Hz
f2 = 2500; % Hz

% preamble for synchronization
symbols_preamble=mapping(lfsr_framesync(100), 'BPSK');
codeword=cat(1,symbols_preamble,codeword);

signal= conv(upsample(codeword,length(B_trunc)),B_trunc.'); % upsampling by length(B_trunc) eliminates ISI (I think)
t = linspace(0,(length(signal)-1)/fs,length(signal));
harm1 = exp(-2*pi*1i*f1*t);
harm2 = exp(-2*pi*1i*f2*t);

wave = sqrt(2)*real(signal.*(harm1+harm2)');

end

