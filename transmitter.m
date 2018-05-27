clear all
close all

% Read file and convert to binary ASCII
file = fopen('test.txt');
text_cell = textscan(file,'%c');
text = text_cell{1};
binary_array = dec2bin(text);
if(size(binary_array,2) == 7)
    binary_array = strcat('0',binary_array);
end
binary_seq = str2num(reshape(binary_array',[],1));
codewords = mapping(binary_seq);

rolloff = 0.25;
span = 300;
sps = 40;
wave = waveformer(codewords, rolloff, span, sps);

fs = 2*span*sps;
%sound(wave, fs);

y=wave;

rolloff = 0.25;
span = 300;
sps = 40;

B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
t = 0:1/fs:1;
tstart = find(B>1e-3,1,'first');
tend = find(B>1e-3,1,'last');
B_trunc = B(tstart:tend);

f1=filters(800,2200,fs,'bandpass');
%y1=filter(f1,y);
y1=y'.*exp(-2*pi*j*1500.*t(1:16584));
rx=2*lowpass(y1,1500,fs);

f2=filters(1800,3200,fs,'bandpass');
y2=filter(f2,y);
y2=y2.'.*exp(-2*pi*j*2500.*t(1:16584));

plot(abs(fft(rx)))
figure
plot(abs(fft(y2)))


y_matched1=convolve(rx.',B_trunc.');
y_matched2=convolve(y2.',B_trunc.');


T=tend-tstart+2;
a=dec2bin(demapping(y_matched1(500:500:500+500*31)));

%a=demapping(y1(1:T:end));




