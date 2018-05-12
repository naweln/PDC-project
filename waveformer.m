clear all
rolloff = 0.25;
span = 800;
sps = 8;

B = rcosdesign(rolloff, span, sps);
h = impz(B,1);
H = fft(h);
bw = length(H);
plot([(-bw+1)/2:1:(bw-1)/2],abs(fftshift(H)))

fs = span*sps;
t = [0:1/fs:1];

f1 = 1500; % Hz
x = sin(2*pi*f1*t);
h1 = x'.*h;
H1 = fft(h1);
hold on
plot([(-bw+1)/2:1:(bw-1)/2],abs(fftshift(H1)))

player = audioplayer(10*h1,fs);
playblocking(player)

f2 = 2500; % Hz
y = sin(2*pi*f2*t);
h2 = y'.*h;
H2 = fft(h2);
hold on
plot([(-bw+1)/2:1:(bw-1)/2],abs(fftshift(H2)))

player = audioplayer(10*h2,fs);
playblocking(player)



