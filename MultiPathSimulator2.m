clc
close all
clear all

%% Initialization

net = importKerasNetwork('modelRegression.h5')
%net = importKerasLayers('modelRegression.h5','ImportWeights',true);

%load('means.mat')
%load('stds.mat')
load('fDmat.mat')

%fDs = fDmat(6,:);
fDs = fDmat(1,:);

%Constants
chip_rate = 1.023e6;   %In Hz
fs = 2.5e6;             %In Hz
fD = 0;             % In Hz
shift_Tc = 0.5;    %max shift, in chips
CNR_dB = 35;        % in dB-Hz
runs = 500;    % # runs
n_multipath = 7; %Number of Multipath Components
plotFlag = false;   %Set to plot
NNErrorFlag = true; %Set to use NNDLL
EstimateDoppler = false; %Set to use PLL to estimate doppler frequency
delta_shift_codes = 2;  %Delta Codes used as input to DLL
delta_shift_samples = round(delta_shift_codes*fs/chip_rate);

samplesPerCode = floor(fs/chip_rate*1023);
t = (0:samplesPerCode-1)/fs;
t_plot = t*fs;
%t_p = (1:2*delta_shift)/fs - delta_shift/fs;


%Initialization
[CAcode19, code19] = generate_PRN(3,6);     %for PRN 19

%Resampling the PRNs
code19 = resample_PRN(code19,samplesPerCode,chip_rate,fs,0);


%Initializing training data matrices
ShiftsData = zeros(runs,1); %Errros from the center of the MDLL
SamplesData = zeros(runs,2*delta_shift_samples);
SamplesData_noiseless = zeros(runs,2*delta_shift_samples);  %This is used for the autoencoder
Data = zeros(runs,size(ShiftsData,2) + size(SamplesData,2));

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
%%
shift_center = 500;
if (plotFlag)
    figure;
end
phase = 0;
for n = 1:runs
    %% Run Initialization
    clc;
    n/runs*100
    
    fD = fDs(n);
  
    noise1 = sigma_noise*randn(1,samplesPerCode);
    noise2 = sigma_noise*randn(1,samplesPerCode);
    noise = noise1 + 1i*noise2;
    
    shift = shift_Tc/chip_rate*fs*(2*(rand-0.5));
    ShiftsData(n) = round(shift);
    
    %Shifting PRNs
    code19_d = circshift(code19,round(shift)+shift_center);
    code19_Multipath = 0;
    
    for ii = 1:n_multipath
        multipath_shift_samples = gamrnd(2.56,65.12)/3e8*fs;
        theta =pi/sqrt(3)*randn;
        a = -0.0032;b = -12.3;  %Linear Model for Attenuation
        Att_db = a*(multipath_shift_samples)/fs*1e3 + b;
        
        A_M = 1*10^(Att_db/20);
        code19_Multipath = code19_Multipath + A_M*exp(1i*theta)*circshift(code19,round(shift + multipath_shift_samples)+shift_center);
    end
    
    thetas = 2*pi*fD*t + phase;
    phase = phase + 2*pi*fD*(t(end) + 1/fs);
    
    if(EstimateDoppler)
        thetashat = 2*pi*fDhat*t + phasehat;
        phasehat = phasehat + 2*pi*fDhat*(t(end) + 1/fs);
    else
        thetashat = thetas;
    end

    y = code19_d + code19_Multipath + noise;% + code25_d + code5_d;
    A = 1;
    y = y.*A.^0.5.*exp(-1i*thetas);

    R = Corr(y,code19.*exp(-1i*thetashat))./length(y);
    R_M = Corr((code19_Multipath + noise).*exp(-1i*thetas),code19.*exp(-1i*thetashat))./length(y);
    R_Actual = Corr((code19_d + noise).*exp(-1i*thetas),code19.*exp(-1i*thetashat))./length(y);
    SamplesData(n,:) = R(shift_center-delta_shift_samples+1:shift_center+delta_shift_samples);
    %SamplesData(n,:) = R(shift_center-delta_shift_samples:shift_center+delta_shift_samples);

    
    %% DLL
    B_DLL = 1;
    
    delta_shift_DLL = round(fs/chip_rate/2);
    prompt_PRN = circshift(code19,shift_center);
    early_PRN = circshift(code19, shift_center - delta_shift_DLL);
    late_PRN = circshift(code19, shift_center + delta_shift_DLL);
    
    c_prompt = sum(prompt_PRN.*y.*exp(1i*thetashat))./length(code19_d);
    c_early = sum(early_PRN.*y.*exp(1i*thetashat))./length(code19_d);
    c_late = sum(late_PRN.*y.*exp(1i*thetashat))./length(code19_d);
    
    L_t = (real(c_prompt)*(real(c_early) - real(c_late)) + imag(c_prompt)*(imag(c_early) - imag(c_late)));
    e_t = C*L_t;
    shift_DLL_samples(n) = round(-e_t*fs);
    
    %prompt_PRN = circshift(code19,shift_center + shift_DLL_samples(n));
    %c_prompt = sum(prompt_PRN.*y.*exp(1i*thetashat))./length(code19_d);
    %c_prompt1 = sum(prompt_PRN.*y.*exp(1i*thetas))./length(code19_d);
    %I_Data(n) = real(c_prompt);
    %I_Data1(n) = real(c_prompt1);


    
    DLLError(n) = ShiftsData(n) - shift_DLL_samples(n);
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
        NNShift(n) = (PredictShift_2p5(real(SamplesData(n,:))));
        %SamplesData_scaled = (SamplesData(n,:) - means)./stds;
        NNShift_Keras(n) = double(predict(net,real(SamplesData(n,:))));
        NNError(n) = ShiftsData(n) - NNShift(n);
        NNError_Keras(n) = ShiftsData(n) - NNShift_Keras(n);
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
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
        xline(shift);
        if (NNErrorFlag)
           xline(shift_center + NNShift(n),'g');
           xline(shift_center + shift_DLL_samples(n),'r');           
           xline(shift_center + NNShift_Keras(n),'b');

        end
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Line of Sight Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (NN)','Estimated Prompt (DLL)')

        %ylim([0,0.3])

        %Plot Multipath
        subplot(3,1,2)
        plot(t_plot,real(R_M))
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
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
        xlim([shift_center-delta_shift_samples,shift_center+delta_shift_samples]);
        xline(shift);
        if (NNErrorFlag)
           xline(shift_center + NNShift(n),'g');
           xline(shift_center + shift_DLL_samples(n),'r');
        end
        hold on

        plot(shift_center + shift_DLL_samples(n) - delta_shift_DLL,...
            real(R(shift_center + shift_DLL_samples(n) - delta_shift_DLL + 1)),'r*')
        plot(shift_center + shift_DLL_samples(n) + delta_shift_DLL,...
            real(R(shift_center + shift_DLL_samples(n) + delta_shift_DLL + 1)),'r*')
        plot(shift_center + shift_DLL_samples(n),...
            real(R(shift_center + shift_DLL_samples(n)+1)),'r*')
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Received Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (NN)','Estimated Prompt (DLL)','Early - Prompt - Late')

        %%
        drawnow
       
    end
end
if (NNErrorFlag)
    NN_Keras_RMSE = norm(NNError_Keras)/sqrt(runs)/fs*3e8
    NN_RMSE = norm(NNError)/sqrt(runs)/fs*3e8
end
DLL_RMSE = norm(DLLError)/sqrt(runs)/fs*3e8

Data = [real(SamplesData),ShiftsData];
csvwrite('Data.csv',Data);

%%
% clear X Y
% for i = 1:length(Data)
%     X(1,1:40,1,i) = Data(i,1:40);
%     Y(1,1,1,i) = Data(i,41);
% end
% 