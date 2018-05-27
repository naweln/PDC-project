function decoded = receiver(rolloff,span,sps,threshold,fs)

B = rcosdesign(rolloff, span, sps);
if threshold>0
    tstart = find(B>threshold,1,'first');
    tend = find(B>threshold,1,'last');
    B_trunc = B(tstart:tend);
else
    B_trunc = B;
end
T = length(B_trunc);

% recording
% recorder = audiorecorder(fs,16,1);
% recordblocking(recorder, 5);
% y = getaudiodata(recorder);

% synchronization - todo.

% test (remove todo)

y = transmitter(rolloff,span,sps,threshold);
n = noise(fs);
y = y + n(1:length(y));

% detecting frequency band
Yf = abs(fft(y));
f = linspace(0,fs,length(y));
indices1 = find(f>1200 & f<1800);
indices2 = find(f>2200 & f<2800);
if max(Yf(indices2)>max(Yf(indices1)))
    fc = 1500;
else
    fc = 2500;
end

t = 0:1/fs:10000;
y_base = sqrt(2)*y.*exp(-2*pi*1i*fc.*t(1:length(y))).';

y_matched=convolve(y_base,B_trunc.');

decoded_bin=dec2bin(demapping(y_matched(T:T:length(y)+1-T)));
decoded_bin=reshape(decoded_bin',[],1);
decoded=reshape(decoded_bin,[],8)';
decoded=char(bin2dec(decoded))';



