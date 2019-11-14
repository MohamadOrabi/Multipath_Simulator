clc
%close all
clear all

%% Initialization
%Constants
chip_rate = 1.023e6;   %In MHz
Fs = 5e6;             %In MHz
Ts = 1/5e6;
samplesPerCode = floor(Fs/chip_rate*1023);
n_multipath = 1; %Number of Multipath Components

delta_shift_codes = 2;
delta_shift_samples = round(delta_shift_codes*Fs/chip_rate);

t = (0:samplesPerCode-1)/Fs;
t_plot = t*Fs;
%t_p = (1:2*delta_shift)/Fs - delta_shift/Fs;

shift_center_codes = 500;   %Center of MDLL
shift_center = round(shift_center_codes*Fs/chip_rate);

%Initialization
[CAcode5, code5] = generate_PRN(1,9);       %for PRN 5
[CAcode19, code19] = generate_PRN(3,6);     %for PRN 19
[CAcode25, code25] = generate_PRN(5,7);     %for PRN 25

%Resampling the PRNs
code5 = resample_PRN(code5,samplesPerCode,chip_rate*1e6,Fs*1e6,0);
code19 = resample_PRN(code19,samplesPerCode,chip_rate,Fs,0);
code25 = resample_PRN(code25,samplesPerCode,chip_rate,Fs,0);

figure;
shift_codes = shift_center_codes;

runs = 6000;
ShiftsData = zeros(runs,1); %Errros from the center of the MDLL
SamplesData = zeros(runs,2*delta_shift_samples);

plotFlag = 0;
NNErrorFlag = 1;

shift_DLL = 0;

%%

for n = 1:runs
    %% Run Initialization
    clc;
    n/runs*100
  
    noise1 = 1*randn(1,samplesPerCode);
    noise2 = 1*randn(1,samplesPerCode);

    shift_codes = 0.3*randn(1) + shift_center_codes;
    shift = round(shift_codes*Fs/chip_rate);
    ShiftsData(n) = shift - shift_center;
    
    %Shifting PRNs
    code19_d = circshift(code19,shift) + noise1;
    code19_Multipath = 0;
    
    for i = 1:n_multipath
        multipath_shift_samples = round(gamrnd(2.56,65.12)/3e8*Fs);
        
        a = -0.0032;b = -12.3;  %Linear Model for Attenuation
        Att_db = a*(multipath_shift_samples)/Fs*1e3 + b;
        
        A_M = 1*10^(Att_db/20);
        code19_Multipath = code19_Multipath + A_M*circshift(code19,shift + multipath_shift_samples);
    end
    
    code19_Multipath = code19_Multipath + noise2;

    code25_d = circshift(code25,905);
    code5_d = circshift(code5,75);

    y = code19_d + code19_Multipath + noise1;% + code25_d + code5_d;
    A = 1;
    y = y.*A.^0.5.*exp(-2*pi*t);

    R = abs(Corr(y,code19.*exp(j*2*pi*t))./length(y)).^2;
    R_M = abs(Corr(code19_Multipath.*exp(j*-2*pi*t),code19.*exp(j*2*pi*t))./length(y)).^2;
    R_Actual = abs(Corr(code19_d.*exp(j*-2*pi*t),code19.*exp(j*2*pi*t))./length(y)).^2;
    SamplesData(n,:) = R_Actual(shift_center-delta_shift_samples+1:shift_center+delta_shift_samples);
    
    %% DLL
    B_DLL = 1;
    
    delta_shift_DLL = round(Fs/chip_rate/2);
    prompt_PRN = circshift(code19,shift_center);
    early_PRN = circshift(code19, shift_center - delta_shift_DLL);
    late_PRN = circshift(code19, shift_center + delta_shift_DLL);
    
    if n>1
        prompt_PRN = circshift(code19,shift_center + shift_DLL_samples(n-1));
        early_PRN = circshift(code19, shift_center + shift_DLL_samples(n-1) - delta_shift_DLL);
        late_PRN = circshift(code19, shift_center + shift_DLL_samples(n-1) + delta_shift_DLL); 
    end
    
    c_prompt = abs(sum(prompt_PRN.*y.*exp(2*j*pi*t))./length(code19_d)).^2;
    c_early = abs(sum(early_PRN.*y.*exp(2*j*pi*t))./length(code19_d)).^2;
    c_late = abs(sum(late_PRN.*y.*exp(2*j*pi*t))./length(code19_d)).^2;
    
    L_t = c_early - c_late;
    L_t = 4*B_DLL*L_t/(2*chip_rate*c_prompt.^0.5);
    shift_DLL = shift_DLL - 1e-3*L_t;
    shift_DLL_samples(n) = round(shift_DLL*Fs);
    
    DLLError(n) = shift_DLL_samples(n) - ShiftsData(n);
    %%

    %% Prediction
    if (NNErrorFlag)
        NNShift(n) = round(PredictShift(SamplesData(n,:)));
        NNError(n) = NNShift(n) - ShiftsData(n);
    end
    %%
    if (plotFlag)
        %% Plot
        %Plot Actual
        subplot(3,1,1)
        plot(t_plot,R_Actual)
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
        xline(shift);
        if (NNErrorFlag)
           xline(shift_center + NNShift(n),'g');
           xline(shift_center + shift_DLL_samples(n),'r');
        end

        %ylim([0,0.3])

        %Plot Multipath
        subplot(3,1,2)
        plot(t_plot,R_M)
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
        xline(shift);

        %ylim([0,0.3])


        %Plot Total
        subplot(3,1,3)
        hold off
        plot(t_plot,R,'b')
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
        xline(shift);
        if (NNErrorFlag)
           xline(shift_center + NNShift(n),'g');
           xline(shift_center + shift_DLL_samples(n),'r');
        end
        hold on

        plot(shift_center + shift_DLL_samples(n) - delta_shift_DLL,R(shift_center + shift_DLL_samples(n) - delta_shift_DLL + 1),'r*')
        plot(shift_center + shift_DLL_samples(n) + delta_shift_DLL,R(shift_center + shift_DLL_samples(n) + delta_shift_DLL + 1),'r*')
        plot(shift_center + shift_DLL_samples(n),R(shift_center + shift_DLL_samples(n)+1),'r*')
        %%
        pause(0.1)
       
    end
end

Data = [SamplesData,ShiftsData];
csvwrite('Data.csv',Data);


tic
out = PredictShift(SamplesData);
toc

