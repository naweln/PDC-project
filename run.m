function run(mode)

rolloff = 0.5;
span = 400;
sps = 100;
threshold = 1e-3;

fs = 44100;

if(strcmp(mode,'transmit') | strcmp(mode,'t'))
    wave = transmitter(rolloff, span, sps, threshold);
elseif(strcmp(mode,'recieve') | strcmp(mode,'r'))
    decode = receiver(rolloff, span, sps, threshold, fs);
elseif(strcmp(mode,'noise') | strcmp(mode,'n'))
    n = noise(fs);
end

    