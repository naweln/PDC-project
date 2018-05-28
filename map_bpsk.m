function symbols=map_bpsk(preamble)

symbols(preamble==0)=1;
symbols(preamble==1)=-1;