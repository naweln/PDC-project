function run(mode)

rolloff = 0.5;
span = 400;
sps = 100;
threshold = 0;

fs = 2*span*sps; % sampling frequency, will be different in the end (that of the receiver) TODO

if(strcmp(mode,'transmit') | strcmp(mode,'t'))
    transmitter(rolloff, span, sps, threshold);
elseif(strcmp(mode,'recieve') | strcmp(mode,'r'))
    recorder(fs);
elseif(strcmp(mode,'noise') | strcmp(mode,'n'))
    noise(fs);
end
    