clc
close all
clear all

%% Initialization

net = importKerasNetwork('modelRegression.h5') %Imports the Keras network
%load('means.mat')  %Used for scaling inputs to NN
%load('stds.mat')
load('fDmat.mat')   % In Hz
%load('sat_poss.mat')
load('pseudoranges.mat')    % In meters
sat = 9;    %Do not change now!

% Interpolating fD and pseudorange
pseudorange(sat,:) = interpolatevec(pseudoranges(sat,:));
fDs = interpolatevec(fDmat(sat,:));

%fDs = fDmat(6,:);
%fDs = fDmat(sat,:);

%Constants
c = 299792458;
chip_rate = 1.023e6;   %In Hz
fs = 2.5e6;             %In Hz
fs_hi = 500e6;
f_ratio = fs_hi/fs;
fD = 0;             % In Hz
shift_Tc = 0.5;    %max shift, in chips
CNR_dB = 35;        % in dB-Hz
runs = 500;    % # code_lengths to process
n_multipath = 7; % Number of Multipath Components
plotFlag = false;   %Set to plot.. plotting now is currently very slow
NNErrorFlag = true; %Set to use NNDLL
EstimateDoppler = false; %Set to use PLL to estimate doppler frequency
delta_shift_codes = 2;  %Delta Codes used as input to DLL
delta_shift_samples = round(delta_shift_codes*fs/chip_rate);

samplesPerCode = floor(fs/chip_rate*1023);
samplesPerCode_hi = floor(fs_hi/chip_rate*1023);

t = (0:samplesPerCode-1)/fs;
t_plot = t*fs;

t_hi = (0:samplesPerCode_hi-1)/fs_hi;
%t_p = (1:2*delta_shift)/fs - delta_shift/fs;


%Initialization
[CAcode19, code19] = generate_PRN(3,6);     %for PRN 19

%Resampling the PRNs
code19_hi = resample_PRN(code19,samplesPerCode_hi,chip_rate,fs_hi,0);
code19 = resample_PRN(code19,samplesPerCode,chip_rate,fs,0);


%Initializing training data matrices
ShiftsData = zeros(runs,1); %Errros from the center of the MDLL
SamplesData = zeros(runs,2*delta_shift_samples);
Data = zeros(runs,size(ShiftsData,2) + size(SamplesData,2));

%Initialize state space representation of PLL
if EstimateDoppler
    B_PLL = 50;
    [AA BB CC DD] = PLL_getss(B_PLL,fs);
    fDhat = fDs(1,1)
    x = [2*pi*fDhat/CC];
    phasehat = 0;
end

sigma_noise = sqrt(0.0005/(10.^(CNR_dB/10)))*samplesPerCode;
Tc = 1/chip_rate;
C = Tc/2/(1 - 2*(sigma_noise/samplesPerCode)^2);

%Initialize the Estimated variables
shift_center_hi = 0; %Estimated Shift
shift_center_lo = shift_center_hi/f_ratio;
code_shift_hat_DLL(1) = round(shift_center_hi + mod(pseudorange(sat,1),300e3)/c*fs); % Initial Value 
code_shift_hat_NN(1) = round(shift_center_hi + mod(pseudorange(sat,1),300e3)/c*fs); % Initial Value 

if (plotFlag)
    figure;
end
phase = 0;
for n = 1:runs
    %% Run Initialization
    clc;
    n/runs*100
    
    %Calculate code_shift from pseudorange(n)
    code_shift(n) = mod(pseudorange(sat,n),300e3)/c*fs_hi;   %This might cause a problem
    
    fD = fDs(n);
    
    noise1 = sigma_noise*randn(1,samplesPerCode);
    noise2 = sigma_noise*randn(1,samplesPerCode);
    noise = noise1 + 1i*noise2;
    
    %shift = shift_Tc/chip_rate*fs*(rand-0.5);
    shift = mod(code_shift(n)-1,samplesPerCode_hi)+1;
    %shift = 1868*f_ratio;
    ShiftsData(n) = shift/f_ratio;
    
    %Shifting PRNs
    code19_d = circshift(code19_hi,round(shift)+shift_center_lo);
    code19_Multipath = 0;
    
    %Generate Multipath Signals
    for ii = 1:n_multipath
        multipath_shift_samples = gamrnd(2.56,65.12)/c*fs_hi;
        theta =pi/sqrt(3)*randn;
        a = -0.0032;b = -12.3;  %Linear Model for Attenuation
        Att_db = a*(multipath_shift_samples)/fs_hi*1e3 + b;
        
        A_M = 1*10^(Att_db/20);
        code19_Multipath = code19_Multipath + A_M*exp(1i*theta)*circshift(code19_hi,round(shift + multipath_shift_samples)+shift_center_hi);
    end
    
    thetas = 2*pi*fD*t_hi + phase;
    phase = phase + 2*pi*fD*(t_hi(end) + 1/fs_hi);
    %thetas_lo = decimate(thetas,f_ratio);
    thetas_lo = 2*pi*fD*t + phase;
    phase_lo = phase + 2*pi*fD*(t(end) + 1/fs);
    
    if(EstimateDoppler)
        thetashat = 2*pi*fDhat*t + phasehat;
        phasehat = phasehat + 2*pi*fDhat*(t(end) + 1/fs);
    else
        thetas = 0;
        thetas_lo = 0;
        thetashat = thetas_lo;
    end

    y = code19_d + code19_Multipath;% + noise;% + code25_d + code5_d;
    A = 1;
    %y = y.*A.^0.5.*exp(-1i*thetas);
    
    %Resampling to low fs
    y_lo_noiseless = decimate(y,f_ratio);
    y_lo = y_lo_noiseless + noise;

    y_lo = y_lo.*A.^0.5.*exp(-1i*thetas_lo);
    y_lo_noiseless = y_lo_noiseless.*A.^0.5.*exp(-1i*thetas_lo);

    code19_d_lo = round(decimate(code19_d,f_ratio));

    R = Corr(y_lo.*exp(1i*thetashat),code19)./length(y_lo);
    R_noiseless = Corr(y_lo_noiseless.*exp(1i*thetashat),code19)./length(y_lo);
    R_Actual = Corr((code19_d_lo).*exp(-1i*(thetas_lo-thetashat)),code19)./length(y_lo);
    SamplesData(n,:) = R(round(code_shift_hat_NN(n))-delta_shift_samples+1:round(code_shift_hat_NN(n))+delta_shift_samples);
    SamplesData_noiseless(n,:) = R_noiseless(round(code_shift_hat_NN(n))-delta_shift_samples+1:round(code_shift_hat_NN(n))+delta_shift_samples);
    %SamplesData(n,:) = R(shift_center-delta_shift_samples:shift_center+delta_shift_samples);

    if (n_multipath > 0)
        code19_Multipath_lo = decimate(code19_Multipath,f_ratio);
        R_M = Corr((code19_Multipath_lo).*exp(-1i*(thetas_lo-thetashat)),code19)./length(y_lo);
    else
        R_M = zeros(size(R,1),size(R,2));
    end
    %% DLL
    B_DLL = 1;
    
    delta_shift_DLL = round(fs/chip_rate/2);
    prompt_PRN = circshift(code19,round(code_shift_hat_DLL(n)) - 1);
    early_PRN = circshift(code19, round(code_shift_hat_DLL(n)) - delta_shift_DLL - 1);
    late_PRN = circshift(code19, round(code_shift_hat_DLL(n)) + delta_shift_DLL - 1);
    
    c_prompt = sum(prompt_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_early = sum(early_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_late = sum(late_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    
    L_t = (real(c_prompt)*(real(c_early) - real(c_late)) + imag(c_prompt)*(imag(c_early) - imag(c_late)));
    e_t = B_DLL*C*L_t;
    shift_DLL_samples(n) = -e_t*fs;
    code_shift_hat_DLL(n+1) = round(code_shift_hat_DLL(n)) + shift_DLL_samples(n);
    
    DLLError(n) = ShiftsData(n) - code_shift_hat_DLL(n);
    %% PLL
    if EstimateDoppler
        u(n) = -atan(imag(c_prompt)./real(c_prompt));
        %u(t) = asin(imag(p(t)).*real(p(t)))/2;
        x = AA*x + BB*u(n);
        o(n) = CC*x + DD*u(n);
        o(n) = o(n)/2/pi;
        fDhat = o(n);
    end

    %% Prediction
    if (NNErrorFlag)
        %NNShift(n) = (PredictShift_2p5(real(SamplesData(n,:))));
        NNShift(n) = double(predict(net,real(SamplesData(n,:))));
        code_shift_hat_NN(n+1) = round(code_shift_hat_NN(n)) + NNShift(n);
        %code_shift_hat = code_shift_hat + round(NNShift(n));
        %SamplesData_scaled = (SamplesData(n,:) - means)./stds;
        NNError(n) = ShiftsData(n) - code_shift_hat_NN(n);
        %prompt_PRN = circshift(code19,shift_center + round(NNError(n)));
        %_promptNN = sum(prompt_PRN.*y.*exp(1i*thetashat))./length(code19_d);
        %I_DataNN(n) = c_promptNN;

    end
    %%
    if (plotFlag)
        %% Plot
        %Plot Actual
        subplot(3,1,1)
        plot(t_plot,real(R_Actual))
        xlim([round(ShiftsData(n))-delta_shift_samples,round(ShiftsData(n))+delta_shift_samples]-1);
        xline(ShiftsData(n)-1);
        if (NNErrorFlag)
           xline(code_shift_hat_NN(n)-1,'g');
           xline(code_shift_hat_DLL(n)-1,'r');
        end
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Line of Sight Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (NN)','Estimated Prompt (DLL)')

        %ylim([0,0.3])

        %Plot Multipath
        subplot(3,1,2)
        plot(t_plot,real(R_M))
        xlim([code_shift_hat_DLL(n)-delta_shift_samples,code_shift_hat_DLL(n)+delta_shift_samples]-1);
        xline(shift);
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Multipath Signal')
        legend('Correlation')


        %ylim([0,0.3])


        %Plot Total
        subplot(3,1,3)
        hold off
        plot(t_plot,real(R),'b')
        xlim([round(code_shift_hat_DLL(n))-delta_shift_samples,round(code_shift_hat_DLL(n))+delta_shift_samples] - 1);
        xline(shift);
        if (NNErrorFlag)
           xline(shift_center_lo + NNShift(n),'g');
           xline(shift_center_lo + shift_DLL_samples(n),'r');
        end
        hold on

%         plot(shift_center + shift_DLL_samples(n) - delta_shift_DLL,...
%             real(R(shift_center + shift_DLL_samples(n) - delta_shift_DLL + 1)),'r*')
%         plot(shift_center + shift_DLL_samples(n) + delta_shift_DLL,...
%             real(R(shift_center + shift_DLL_samples(n) + delta_shift_DLL + 1)),'r*')
%         plot(shift_center + shift_DLL_samples(n),...
%             real(R(shift_center + shift_DLL_samples(n)+1)),'r*')
        plot(round(code_shift_hat_DLL(n)) - delta_shift_DLL - 1,...
            real(R(round(code_shift_hat_DLL(n)) - delta_shift_DLL)),'r*')
        plot(round(code_shift_hat_DLL(n)) + delta_shift_DLL - 1,...
            real(R(round(code_shift_hat_DLL(n)) + delta_shift_DLL)),'r*')
        plot(round(code_shift_hat_DLL(n)) - 1,...
            real(R(round(code_shift_hat_DLL(n)))),'g*')

        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Received Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (NN)','Estimated Prompt (DLL)','Early - Prompt - Late')

        %%
        drawnow
       
    end
end
if (NNErrorFlag)
    NN_RMSE = norm(NNError)/sqrt(runs)/fs*c
end
DLL_RMSE = norm(DLLError)/sqrt(runs)/fs*c

Data = [real(SamplesData),ShiftsData];
csvwrite('Data.csv',Data);

%%
figure;
title('Code Shift')
hold on
plot(ShiftsData(1:n))
%plot(cumsum(round(NNShift))+ShiftsData(1))
plot(code_shift_hat_NN(2:n+1))
%plot(cumsum(round(shift_DLL_samples))+ShiftsData(1))
plot(code_shift_hat_DLL(2:n+1))
legend('Actual Shift', 'Estimated Shift NN', 'Estimated Shift DLL')
%%
% This is to check if fD is compatible with the pseudorange
% figure; plot(pseudoranges(sat,:)); hold on; plot(cumsum(-fDmat(sat,:)*1e-3/1575.42e6*c)+ pseudoranges(sat,1))
