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

T=500;
nb_characters=8;
nb_bits=8*nb_characters;
nb_codewords=nb_bits/2;
conv_length=T*nb_codewords+length(B_trunc)-1;

%filt1=filters(800,2200,fs,'bandpass');
%y1=filter(filt1,y);
y1=y'.*exp(-2*pi*j*1500.*t(1:conv_length));
y1_passband=2*lowpass(y1,1500,fs);

%filt2=filters(1800,3200,fs,'bandpass');
%y2=filter(filt2,y);
y2=y.'.*exp(-2*pi*j*2500.*t(1:conv_length));
y2_passband=2*lowpass(y2,2500,fs);

plot(abs(fft(y1_passband)))
figure
plot(abs(fft(y2_passband)))


y_matched1=convolve(y1_passband.',B_trunc.');
y_matched2=convolve(y2_passband.',B_trunc.');

decoded1_bin=de2bi(demapping(y_matched1(T:T:T*nb_codewords)),'left-msb');
decoded1_bin=reshape(decoded1_bin',[],1);
decoded1=dec2bin(demapping(y_matched1(T:T:T*nb_codewords)));
decoded1=reshape(reshape(decoded1',[],1),[],8)';
decoded1=char(bin2dec(decoded1));

nb_errors_1=sum(abs(binary_seq-decoded1_bin));

decoded2_bin=de2bi(demapping(y_matched2(T:T:T*nb_codewords)),'left-msb');
decoded2_bin=reshape(decoded2_bin',[],1);
decoded2=dec2bin(demapping(y_matched2(T:T:T*nb_codewords)));
decoded2=reshape(reshape(decoded2',[],1),[],8)';
decoded2=char(bin2dec(decoded2));

nb_errors_2=sum(abs(binary_seq-decoded2_bin));






