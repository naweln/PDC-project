function decode = run(mode)

rolloff = 0.25;
span = 300;
sps = 40;
threshold = 1e-3; % TRY 2e-3 !!!!
% 1e-3 => 30 seconds
% 2e-3 => 18 seconds

%root raised cosine
B = rcosdesign(rolloff, span, sps);
fs_trans = 2*span*sps;
if threshold
    tstart = find(B>threshold, 1,'first');
    tend = find(B>threshold, 1,'last');
    B_trunc = B(tstart:tend);
else
    B_trunc = B;
end

% length of synchronization sequence
sync_len = 200;

% reed solomon "rate" (?)
n = 2;

if(strcmp(mode,'transmit') | strcmp(mode,'t'))
    transmitter(B_trunc, fs_trans, sync_len, n);
elseif(strcmp(mode,'recieve') | strcmp(mode,'r'))
    decode = receiver(B_trunc, fs_trans, sync_len, n);
elseif(strcmp(mode,'noise') | strcmp(mode,'n'))
    noise(50000);
end

    