clear all
close all

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

rolloff = 0.25;
span = 600;
sps = 40;
wave = waveformer(codewords, rolloff, span, sps);

sound(wave, sps*span);

