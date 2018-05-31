function message = receiver(B_trunc, fs_trans, sync_len, n)

% sampling frequency at receiver
fs = 48000;

T = ceil(length(B_trunc)*fs/fs_trans);

% recording
recorder = audiorecorder(fs,16,1);
recordblocking(recorder, 60);
y = getaudiodata(recorder);

% detecting frequency band
Yf = abs(fft(y));
f = linspace(0,fs,length(y));
if max(Yf(f>2200 & f<2800)>max(Yf(f>1200 & f<1800)))
    fc = 1500;
else
    fc = 2500;
end

% downconverter and matched filter
t = linspace(0,(length(y)-1)/fs,length(y));
y_base = sqrt(2)*y.*exp(-2*pi*1i*fc.*t).';
% filtering, not sure if necessary.
y_base = filter(filters(0,500,fs,'lowpass'),y_base);
y_matched=conv(y_base,B_trunc.');

% synchronization (time)
[frame_start_id,theta_init]=frame_sync(y_matched, T, sync_len);
frame_start_id = frame_start_id - T;
sample_points  = frame_start_id + T:T:length(y_matched);

% synchronization (phase)
sync_code = y_matched(frame_start_id-T*(sync_len-1):T:frame_start_id);
sync_code_theta_init = sync_code.*exp(1i*theta_init)';

sync_bin = lfsr_framesync(sync_len);
angle1 = angle(sync_code(1:sync_len/2));
angle2 = angle(sync_code(sync_len/2+1:end));
angle_diff = mod(angle2-angle1 - (sync_bin(1:sync_len/2)-sync_bin(sync_len/2+1:end))*pi,2*pi);
angle_diff(angle_diff>pi) = angle_diff(angle_diff>pi)-2*pi;
theta = 2*mean(angle_diff)/sync_len;

sync_codewords_time = sync_code_theta_init.*exp(1i*(0:length(sync_code)-1)*theta)';
angle_avg0 = mean(angle(sync_codewords_time(angle(sync_codewords_time)<pi/2 & angle(sync_codewords_time)>-pi/2)));
angle_avg1 = mean(mod(angle(sync_codewords_time(angle(sync_codewords_time)>pi/2 | angle(sync_codewords_time)<-pi/2))+2*pi,2*pi));
angle_avg = (angle_avg0 + angle_avg1 - pi)/2;

sync_codewords = sync_codewords_time.*exp(-1i*angle_avg);

code = y_matched(sample_points);
code_theta_init = code*exp(-1i*theta_init);
codewords_time = code_theta_init.*exp(1i*(sync_len:length(code_theta_init)+sync_len-1)*theta)';
codewords = codewords_time.*exp(-1i*angle_avg);


% demapping
demapped_bin=dec2bin(demapping(codewords,'QAM'));
demapped_bin=reshape(demapped_bin',[],1);
demapped_bin = demapped_bin(1:length(demapped_bin)-mod(length(demapped_bin),8));
demapped=reshape(demapped_bin,8,[])';
% decoding
decoded = decoding(bin2dec(demapped)',n);
% finding end sequence 0 0 0 0 0 1 0 0 = 4 in int
index = find(decoded == 4, 1, 'first');
if(index)
    message=char(decoded(1:index-1))';
else
    message=char(decoded)';
end




