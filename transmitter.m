function wave = transmitter(rolloff, span, sps, threshold)
% Read file and convert to binary ASCII
file = fopen('test.txt');
text_cell = textscan(file,'%c');
text = text_cell{1};
binary_array = dec2bin(text);
if(size(binary_array,2) == 7)
    binary_array = strcat('0',binary_array);
end
binary_seq = str2num(reshape(binary_array',[],1));
codewords = mapping(binary_seq);

%codewords = [1]; %TODO not real codewords
wave = waveformer(codewords, rolloff, span, sps, threshold);

fs = span*sps;
sound(wave, fs);
audiowrite('pdc.wav',wave,fs)





