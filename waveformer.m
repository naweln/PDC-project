function wave = waveformer(codeword, rolloff, span, sps)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

B = rcosdesign(rolloff, span, sps);
fs = span*sps;
t = 0:1/fs:1;
tstart = find(B>1e-3,1,'first');
tend = find(B>1e-3,1,'last');
B_trunc = B(tstart:tend);

f1 = 1500; % Hz
x1 = cos(2*pi*f1*t(1:length(B_trunc)));
y1 = sin(2*pi*f1*t(1:length(B_trunc)));

f2 = 2500; % Hz
x2 = cos(2*pi*f2*t(1:length(B_trunc)));
y2 = sin(2*pi*f2*t(1:length(B_trunc)));

A = real(codeword)*(x1+x2) + imag(codeword)*(y1+y2);

wave = A.*B_trunc;
wave = wave';
wave = wave(:);

end

