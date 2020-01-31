function samplesData = getSamplesData(center,deltashift,PRNcode,received_signal,f_ratio,n,fs)

%2*fs_hi/1.023e6;

%for i = -deltashift+1:deltashift
%for i = -n/2+1 : n/2
for i = ceil(-n/2) : floor(n/2)
    prompt_PRN = resample_PRN(PRNcode,round(fs/1.023e6*1023),1.023e6,fs,-(center + i));
    %prompt_PRN = circshift(PRNcode,center+i*f_ratio); %should not be delta_shift (temporary fix)
    %resampled_PRN_lo = round(decimate(prompt_PRN,f_ratio,1,'fir'));
    c_prompt = sum(prompt_PRN.*received_signal)./length(received_signal);
    %c_prompt = sum(resampled_PRN_lo.*received_signal)./length(received_signal);
    samplesData(i-ceil(-n/2)+1) = abs(c_prompt);
    %samplesData(i+deltashift) = abs(c_prompt);
end

end