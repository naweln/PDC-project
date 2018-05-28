function decoded=demap_bpsk(received_signal)

received_signal=reshape(received_signal,[1,length(received_signal)]);

decoded(real(received_signal)>=0)=0;
decoded(real(received_signal)<0)=1;
decoded=decoded';