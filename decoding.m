function decoded = decoding(coded, n)
    block_len = 2*floor(200/(2*n));
    nb_blocks = ceil(length(coded)/block_len);
    pad_len = block_len - mod(length(coded),block_len);
    pad = 4*ones(1,pad_len);
    coded_pad = [coded pad];
    
    for i=0:nb_blocks-1
        coded_block = coded_pad(1+i*block_len:(i+1)*block_len);
        decode_gf = rsdec(gf(coded_block,8),n*block_len,block_len);
        decoded(:,i+1) = code_gf.x;
    end
    decoded = decoded(:);
    
return