%% Decimate vs Resample
[CAcode19, code19] = generate_PRN(3,6);     %for PRN 19

samplesPerCode = floor(fs/chip_rate*1023);
samplesPerCode_hi = floor(fs_hi/chip_rate*1023);

chip_rate = 1.023e6;

fs = 2.5e6;
fs_hi = 500e6;
f_ratio = fs_hi/fs;

code19_hi = resample_PRN(code19,samplesPerCode_hi,chip_rate,fs_hi,0);
code19_1 = resample_PRN(code19,samplesPerCode,chip_rate,fs,0);

shift_lo = 500;
shift_hi = round(shift_lo*f_ratio);
shift = shift_lo*chip_rate/fs;

code19_d1 = circshift(code19_hi, shift_hi);
code19_d1 = round(decimate(code19_d1, f_ratio));

code19_d2 = resample_PRN1(code19,samplesPerCode,chip_rate,fs,shift);
code19_d3 = resample_PRN1(code19,samplesPerCode,chip_rate,fs,1*0.5);


figure;
hold on;
%stairs(code19_d1)
stairs(code19_d2)
stairs(code19_d3)
ylim([-1.5,1.5])

figure;
plot(Corr(code19_d2,code19_d3)/length(code19_d2))


%stairs(circshift(code19_1,round(500*fs/chip_rate)))

legend('decimation','resampling','true')

%Does not work .. do not trust

%%




