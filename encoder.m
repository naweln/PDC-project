clear all
close all

% Read file and convert to binary ASCII
file=fopen('test.txt');
text_cell=textscan(file,'%c');
text=text_cell{1};
text=reshape(dec2bin(text)',[],1);

