function codewords=mapping(binary_seq, constellation)
if strcmp(constellation,'QAM')
    codewords = QAM(binary_seq);
elseif strcmp(constellation,'BPSK')
    codewords = BPSK(binary_seq);
end
return


function codewords = QAM(binary_seq)
%%QAM
% 00 -> -1-j
% 01 -> -1+j
% 10 -> 1-j
% 11 -> 1+j
 codewords = 2*binary_seq(1:2:end)-1 + 1j*(2*binary_seq(2:2:end)-1);
 return

function codewords = BPSK(binary_seq)
%%BPSK
% 0 -> 1
% 1 -> -1
codewords = sqrt(2)*(1-2*binary_seq);
return

