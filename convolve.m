function y=convolve(x,h)

y=zeros(length(x)+length(h)-1,1);
signal_pad=[zeros(1,length(h)-1), x.', zeros(1,length(h)-1)].';
signal_pad=fliplr(signal_pad);

for k=1:(length(h)+length(x)-1)
    y(k) = h.'*signal_pad(k:k+length(h)-1);
end


