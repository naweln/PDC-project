function codewords=mapping(binary_seq)

% 00 -> -1-j
% 01 -> -1+j
% 10 -> 1-j
% 11 -> 1+j
codewords=((2*binary_seq(1:2:end)-1) + 1j*(2*binary_seq(2:2:end)-1));
