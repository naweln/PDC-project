function wave = transmitter(B_trunc, fs, sync_len, n)
% Read file and convert to binary ASCII
file = fopen('test.txt');
text_cell = textscan(file,'%s');
text = text_cell{1};
message = [];
for i=1:length(text)
    message = [message text{i} ' '];
end
message = message(1:end-1);
% coding
binary_array = dec2bin(coding(uint8(message), n));

% mapping
if(size(binary_array,2) == 7)
    binary_array = strcat('0',binary_array);
end
binary_seq = str2num(reshape(binary_array',[],1));
codewords = mapping(binary_seq, 'QAM');

wave = waveformer(codewords, B_trunc, fs, sync_len);

sound([zeros(70000,1); wave], fs);
%sound(wave, fs);
audiowrite('pdc.wav',wave,fs);






