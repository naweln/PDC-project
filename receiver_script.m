clear all
rolloff = 0.25;
span = 300;
sps = 40;
threshold = 1e-3;

B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
t = 0:1/fs:100; % todo too slow
if threshold>0
    tstart = find(B>threshold,1,'first');
    tend = find(B>threshold,1,'last');
    B_trunc = B(tstart:tend);
else
    B_trunc = B;
end

y = transmitter(rolloff, span, sps, threshold);
n = noise(fs);

y = y + n(1:length(y));

T = length(B_trunc);

nb_characters=8;
nb_bits=8*nb_characters;
nb_codewords=nb_bits/2;
conv_length=T*(nb_codewords+100)+length(B_trunc)-1;

y1=sqrt(2)*y.*exp(-2*pi*1i*1500.*t(1:conv_length)).';
%y1_passband=2*lowpass(y1,1500,fs);

y2=sqrt(2)*y.*exp(-2*pi*1i*2500.*t(1:conv_length)).';
%y2_passband=2*lowpass(y2,2500,fs);

%plot(abs(fft(y1_passband)))
%figure
%plot(abs(fft(y2_passband)))

y_matched1=conv(y1,B_trunc.');
y_matched2=conv(y2,B_trunc.');

% ----- NEW -----
[frame_start_id,theta_init]=frame_sync(y_matched1, T);
frame_start_id=frame_start_id-length(B_trunc);

% ----- NEW -----
decoded1_bin=dec2bin(demapping(y_matched1(frame_start_id+T:T:frame_start_id+T*nb_codewords),'QAM'));
decoded1_bin=reshape(decoded1_bin',[],1);
decoded1=reshape(decoded1_bin,[],8)';
decoded1=char(bin2dec(decoded1))';

% ----- NEW -----
decoded2_bin=dec2bin(demapping(y_matched2(frame_start_id+T:T:frame_start_id+T*nb_codewords), 'QAM'));
decoded2_bin=reshape(decoded2_bin',[],1);
decoded2=reshape(decoded2_bin,[],8)';
decoded2=char(bin2dec(decoded2))';

% ----- NEW -----
% constellation
figure
plot(y_matched1(frame_start_id+T:T:frame_start_id+T*nb_codewords),'o')


