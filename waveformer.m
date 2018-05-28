function wave = waveformer(codeword, rolloff, span, sps, threshold)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
t = 0:1/fs:100; % todo too slow
if threshold
    tstart = find(B>threshold, 1,'first');
    tend = find(B>threshold, 1,'last');
    B_trunc = B(tstart:tend);
else
    B_trunc = B;
end


f1 = 1500; % Hz
f2 = 2500; % Hz

signal = conv(upsample(codeword,length(B_trunc)),B_trunc.'); % faster (todo
%signal= convolve(upsample(codeword,length(B_trunc)),B_trunc.'); % upsampling by B_trunc eliminates ISI
harm1 = exp(-2*pi*1i*f1*t(1:length(signal)));
harm2 = exp(-2*pi*1i*f2*t(1:length(signal)));

wave = sqrt(2)*real(signal.*(harm1+harm2)');

end

