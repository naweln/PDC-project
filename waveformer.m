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
f2 = 2500; % Hz
T=500;

signal=convolve(upsample(codeword,T),B_trunc.');
wave=real(signal).*cos(2*pi*f1*t(1:length(signal)))'-imag(signal).*sin(2*pi*f1*t(1:length(signal)))';
wave=wave+real(signal).*cos(2*pi*f2*t(1:length(signal)))'-imag(signal).*sin(2*pi*f2*t(1:length(signal)))';

end

