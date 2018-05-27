clear all
close all

recorder = audiorecorder(44100,16,1); 
recordblocking(recorder, 5);
y = getaudiodata(recorder);

rolloff = 0.25;
span = 300;
sps = 40;

B = rcosdesign(rolloff, span, sps);
fs = 2*span*sps;
t = 0:1/fs:1;
tstart = find(B>1e-3,1,'first');
tend = find(B>1e-3,1,'last');
B_trunc = B(tstart:tend+~mod(tend-tstart,2));

y_matched=convolve(y,B_trunc.');