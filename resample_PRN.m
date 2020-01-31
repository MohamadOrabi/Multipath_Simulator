function r_PRN = resample_PRN(PRN,samples_code,chip_rate,fs,starting_index)
%Output is the resampled PRN with samples_code samples per code.
%The starting index is necessary for Acquisiotion with accumulation since
%fs/chip_rate is not a real number .. accumulation without accounting for
%this leads to drifting of the code (or skipping a sample).

r_PRN = zeros(1,samples_code);

if(nargin == 4); starting_index = 1; end

for i = 1:samples_code
    index = mod(floor((i+starting_index-1)*chip_rate/fs),1023)+1;
    if (index <= 0)
       index = 1023 - (mod(-index,1023));  
    end
    r_PRN(i) = PRN(index);
end

end