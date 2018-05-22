function codewords=mapping(binary_seq)
%%QAM
% 00 -> -1-j
% 01 -> -1+j
% 10 -> 1-j
% 11 -> 1+j
codewords = 2*binary_seq(1:2:end)-1 + 1j*(2*binary_seq(2:2:end)-1);

%%PAM
% 1 -> 1
% 0 -> -1
%codewords = 2*binary_seq - 1;
