function wave = waveformer(codeword, rolloff, span, sps)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

threshold=1e-3;
B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
t = 0:1/fs:10;
tstart = find(B>threshold, 1,'first');
tend = find(B>threshold, 1,'last');
B_trunc = B(tstart:tend);

f1 = 1500; % Hz
harm1 = exp(1i*2*pi*f1*(t(1:length(B_trunc))-t(ceil(length(B_trunc)/2))));

f2 = 2500; % Hz
harm2 = exp(1i*2*pi*f2*(t(1:length(B_trunc))-t(ceil(length(B_trunc)/2))));

A = sqrt(2)*real(codeword*(harm1+harm2));

wave_temp = A.*B_trunc;
wave_temp = wave_temp';
wave = wave_temp(:);

txsignal_compl=convolve(upsample(codeword,500),B_trunc.');
wave=real(txsignal_compl).*cos(2*pi*1500*t(1:length(txsignal_compl)))'-imag(txsignal_compl).*sin(2*pi*1500*t(1:length(txsignal_compl)))';

end

