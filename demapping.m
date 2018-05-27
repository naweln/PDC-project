function demap=demapping(received_vec)

demap=zeros(size(received_vec));
demap(real(received_vec)>=0 & imag(received_vec)>=0)=3;
demap(real(received_vec)>=0 & imag(received_vec)<0)=2;
demap(real(received_vec)<0 & imag(received_vec)>=0)=1;
demap(real(received_vec)<0 & imag(received_vec)<0)=0;

%demap=dec2bin(demap);

