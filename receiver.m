function decoded = receiver(B_trunc, fs_trans, sync_len)

% sampling frequency at receiver
fs = 48000;

T = ceil(length(B_trunc)*fs/fs_trans);

% recording
recorder = audiorecorder(fs,16,1);
recordblocking(recorder, 10);
y = getaudiodata(recorder);

% detecting frequency band
Yf = abs(fft(y));
f = linspace(0,fs,length(y));
if max(Yf(f>2200 & f<2800)>max(Yf(f>1200 & f<1800)))
    fc = 1500;
else
    fc = 2500;
end

% todo need to remove this
nb_characters=8;
nb_bits=8*nb_characters;
nb_codewords=nb_bits/2;

% downconverter and matched filter
t = linspace(0,(length(y)-1)/fs,length(y));
y_base = sqrt(2)*y.*exp(-2*pi*1i*fc.*t).';
% filtering, not sure if necessary.
% y_base = filter(filters(0,500,fs,'lowpass'),y_base);
y_matched=conv(y_base,B_trunc.');

% synchronization
[frame_start_id,theta_init]=frame_sync(y_matched, T, sync_len);
frame_start_id = frame_start_id - T;
sample_points  = frame_start_id + T:T:frame_start_id+T*nb_codewords;

% decoding
codewords = y_matched(sample_points)*exp(-1i*theta_init);
decoded_bin=dec2bin(demapping(codewords,'QAM'));
decoded_bin=reshape(decoded_bin',[],1);
decoded=reshape(decoded_bin,[],8)';
decoded=char(bin2dec(decoded))';



