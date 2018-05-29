function filter = filters(f1, f2, fs, type)
% returns a filter
if f1>f2
    temp = f1;
    f1 = f2;
    f2 = temp;
end
% convert f1 and f2 to normalized frequency a,b in [0,1]
a = 2*f1/fs;
b = 2*f2/fs;

if(strcmp(type,'bandstop'))
    filter = bandstop(a,b);
elseif(strcmp(type,'lowpass'))
    c = 2*(0.9*f2)/fs;
    filter = lowpass(c,b);
end
return

function filter = bandstop(f1, f2)
% This function returns bandstop filter which 
% only attenuates frequencies between f1 and f2.
width = (f2-f1)/10;
d = fdesign.bandstop(f1,f1+width,f2-width,f2,0.1,60,0.1);
filter = design(d, 'butter');
return

function filter = lowpass(fpass, fstop)
d = fdesign.lowpass('N,Fp,Fst',120,fpass, fstop);
filter = design(d);
return
