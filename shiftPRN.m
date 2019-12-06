clear all
fs = 2.5e6;             %In Hz
fs_hi = 500e6;
f_ratio = fs/fs_hi;
chip_rate = 1.023e6;

[CAcode19, code19] = generate_PRN(3,6);     %for PRN 19

code19_1(1,:) = resample_PRN(code19,floor(fs_hi/chip_rate*1023),chip_rate,fs_hi,0);
code19_1(2,:) = circshift(code19_1(1,:),round(0*fs_hi/chip_rate));
% code19_1(4,:) = circshift(code19_1(1,:),round(0.02*fs_hi/chip_rate));
% code19_1(5,:) = circshift(code19_1(1,:),round(0.03*fs_hi/chip_rate));
% code19_1(6,:) = circshift(code19_1(1,:),round(0.04*fs_hi/chip_rate));

corr = (Corr(code19_1(1,:),code19_1(2,:)));
corr(1)/length(corr)

%figure; subplot(2,1,1); stairs(code19_1(1,:)); 
ylim([-2,2])
xlim([0,1000])
%subplot(2,1,2); stairs(code19_1(2,:))
ylim([-2,2])
xlim([0,1000])

code19_1_low = round(decimate(code19_1(1,:),1/f_ratio));
code19_2_low = round(decimate(code19_1(2,:),1/f_ratio));

corr_low = (Corr(code19_1_low,code19_2_low))/2500;
corr_low(1)


figure; plot(round(code19_1_low')); hold on ; plot(round(code19_2_low'))


