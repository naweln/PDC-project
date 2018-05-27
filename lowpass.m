function [after] = lowpass(before,f_c,f_s)
% LOWPASS lowpass filter
% Low pass filter for extracting the baseband signal 
%
%   before  : Unfiltered signal
%   conf    : Global configuration variable
%
%   after   : Filtered signal
%
% Note: This filter is very simple but should be decent for most 
% application. For very high symbol rates and/or low carrier frequencies
% it might need tweaking.
%

h_lp=design(fdesign.lowpass('N,Fc',50,f_c,f_s),'all','MinPhase',true);
after = filter(h_lp,before);
