function decode = run(mode)

rolloff = 0.25;
span = 300;
sps = 40;
threshold = 1e-3;

fs = 48000;

if(strcmp(mode,'transmit') | strcmp(mode,'t'))
    transmitter(rolloff, span, sps, threshold);
elseif(strcmp(mode,'recieve') | strcmp(mode,'r'))
    decode = receiver(rolloff, span, sps, threshold, fs);
elseif(strcmp(mode,'noise') | strcmp(mode,'n'))
    noise(fs);
end

    