function run(mode)

rolloff = 0.25;
span = 800;
sps = 200;
threshold = 0;

fs = 44100;

 if(strcmp(mode,'transmit') | strcmp(mode,'t'))
    x = transmitter(rolloff, span, sps, threshold);
 elseif(strcmp(mode,'recieve') | strcmp(mode,'r'))
    yfilt = receiver(fs);
 elseif(strcmp(mode,'noise') | strcmp(mode,'n'))
    n = noise(fs);
 end
    