function wave = waveformer(codeword, rolloff, span, sps, threshold)
%WAVEFORMER Summary of this function goes here
%   Detailed explanation goes here

B = rcosdesign(rolloff, span, sps);
fs = span*sps;
t = 0:1/fs:1;
if(threshold)
    tstart = find(B>threshold, 1,'first');
    tend = find(B>threshold, 1,'last');
else
    tstart = 1; tend = length(t);
end
B_trunc = B(tstart:tend);

f1 = 1500; % Hz
harm1 = exp(1i*2*pi*f1*(t(1:length(B_trunc))-t(ceil(length(B_trunc)/2))));

f2 = 2500; % Hz
harm2 = exp(1i*2*pi*f2*(t(1:length(B_trunc))-t(ceil(length(B_trunc)/2))));

A = sqrt(2)*real(codeword*(harm1+harm2));

wave_temp = A.*B_trunc;
wave_temp = wave_temp';
wave = wave_temp(:);

end

