function r_PRN = resample_PRN1(PRN,samples_code,chip_rate,fs,shift_in_samples)
%Output is the resampled PRN with samples_code samples per code.
%The starting index is necessary for Acquisiotion with accumulation since
%fs/chip_rate is not a real number .. accumulation without accounting for
%this leads to drifting of the code (or skipping a sample).

if(nargin == 4); %shift_in_samples = 1; end
end

for i = 1:samples_code
   r_PRN(i) = PRN(mod(floor((i-1+shift_in_samples)*chip_rate/fs+1),1023)+1);
end

end