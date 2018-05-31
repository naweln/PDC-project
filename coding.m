function code = coding(old_bytes, n)

bytes = zlibencode(old_bytes);% compression doesn't work!!!! todo
block_len = 2*floor(56/(2*n));% block length
nb_blocks = ceil(length(bytes)/block_len);
pad_len = block_len - mod(length(bytes),block_len);
pad = 4*ones(1,pad_len);
bytes_pad = [bytes pad];

code = zeros(n*block_len,nb_blocks);
for i=0:nb_blocks-1
    bytes_block = bytes_pad(1+i*block_len:(i+1)*block_len);
    code_gf = rsenc(gf(bytes_block,8),n*block_len,block_len);
    code(:,i+1) = code_gf.x;
end

code = code(:)';

return