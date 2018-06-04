function decomp = decoding(coded, n)
    block_len = 2*floor(64/2);
    nb_blocks = ceil(length(coded)/block_len);
    pad_len = block_len - mod(length(coded),block_len);
    pad = zeros(1,pad_len);
    coded_pad = [coded pad];
    
    for i=0:nb_blocks-1
        coded_block = coded_pad(1+i*block_len:(i+1)*block_len);
        decode_gf = rsdec(gf(coded_block,8),block_len,block_len/n);
        decoded(:,i+1) = decode_gf.x;
    end
    decoded = decoded(:);
    decomp = zlibdecode(uint8(decoded(1:end-ceil(pad_len/2))));
return