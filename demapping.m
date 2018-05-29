function demap=demapping(received_vec, constellation)

if strcmp(constellation,'QAM')
    demap = deQAM(received_vec);
elseif strcmp(constellation,'BPSK')
    demap = deBPSK(received_vec);
end
return

function demap = deQAM(received_vec)
demap=zeros(size(received_vec));
demap(real(received_vec)>=0 & imag(received_vec)>=0)=3;
demap(real(received_vec)>=0 & imag(received_vec)<0)=2;
demap(real(received_vec)<0 & imag(received_vec)>=0)=1;
demap(real(received_vec)<0 & imag(received_vec)<0)=0;
return

function demap = deBPSK(received_vec)
demap=zeros(size(received_vec));
demap(real(received_vec)>=0)=0;
demap(real(received_vec)<0)=1;
return
