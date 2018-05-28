function n = noise(fs)

x = randn(1e7,1);
coin = randi(2,1);

if mod(coin,2)
    filt = filters(2000,3000,fs,'bandstop');
else
    filt = filters(1000,2000,fs,'bandstop');
end

n = filter(filt, x);
sound(n, fs);


% check if filtered correctly
% rn = xcorr(n,'biased');
% sn = fft(rn);
% 
% plot(linspace(0,fs,length(sn)),abs(sn))
