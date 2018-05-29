function wave = transmitter(B_trunc, fs, sync_len)
% Read file and convert to binary ASCII
file = fopen('test.txt');
text_cell = textscan(file,'%c');
text = text_cell{1};
binary_array = dec2bin(text);
if(size(binary_array,2) == 7)
    binary_array = strcat('0',binary_array);
end
binary_seq = str2num(reshape(binary_array',[],1));
codewords = mapping(binary_seq, 'QAM');

wave = waveformer(codewords, B_trunc, fs, sync_len);

sound([zeros(70000,1); wave], fs);
%sound(wave, fs);






