clc
%close all
clear all

%NOTES!
%SamplesData now has abs
%CNR is 45 now (was 50)

%% Initialization

net = importKerasNetwork('modelRegression_2mhz.h5')
%layers = importKerasLayers('modelRegression_10mhz_env.h5')
% lossLayer = maeRegressionLayer('mae loss');
% layers = replaceLayer(layers,'gaussian_noise_1',lossLayer);
% net = assembleNetwork(layers)

%net = importKerasLayers('modelRegression.h5','ImportWeights',true);

load('fDmat.mat')   % In Hz
%load('sat_poss.mat')
load('pseudoranges.mat')    % In meters
load('Elevations.mat')

sat = 9;    %Do not change now!  7

% Interpolating fD and pseudorange
pseudorange(sat,:) = interpolatevec(pseudoranges(sat,:));
fDs = interpolatevec(fDmat(sat,:));
El = interpolatevec(Elevations(sat,:))*180/pi;
skip = 0;
pseudorange(sat,:) = circshift(pseudorange(sat,:),-skip);
fDs = circshift(fDs,-skip);
El = circshift(El,-skip);

% Interpolating fD and pseudorange
pseudorange(sat,:) = interpolatevec(pseudoranges(sat,:));
fDs = interpolatevec(fDmat(sat,:));
El = interpolatevec(Elevations(sat,:))*180/pi;
skip = 0;
pseudorange(sat,:) = circshift(pseudorange(sat,:),-skip);
fDs = circshift(fDs,-skip);
El = circshift(El,-skip);
                                              %To switch between training
                                              %and envelop don't foget: 
%Constants                                    %n_multipath,shift,multipath_shift, theta,A_M
c = 299792458;
chip_rate = 1.023e6;   %In Hz
fs = 2.5e6;             %In Hz
fs_hi = 2.5e6;
f_ratio = fs_hi/fs;
fD = 0;             % In Hz
shift_Tc = 0.5;    %max shift, in chips
CNR_dB = 45;        % in dB-Hz
runs = 5000;    % # runs
n_multipath = 0; %Number of Multipath Components

useCIR = false;
plotCIR = false;

envelope_flag = false;
plotFlag = false;   %Set to plot
NNErrorFlag = false; %Set to use NNDLL
shift_right = 0;

EstimateDoppler = false; %Set to use PLL to estimate doppler frequency
delta_shift_codes = 1;  %Delta Codes used as input to DLL
delta_shift_samples = ceil(delta_shift_codes*fs/chip_rate);

samplesPerCode = floor(fs/chip_rate*1023);
%samplesPerCode_hi = floor(fs_hi/chip_rate*1023);

t = (0:samplesPerCode-1)/fs;
t_plot = t*fs;

%t_hi = (0:samplesPerCode_hi-1)/fs_hi;
%t_p = (1:2*delta_shift)/fs - delta_shift/fs;


%Initialization
[CAcode19, code19_1023] = generate_PRN(3,6);     %for PRN 19

%Resampling the PRNs
%code19_hi = resample_PRN(code19_1023,samplesPerCode_hi,chip_rate,fs_hi,0);
code19 = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,0);



%Initializing training data matrices
ShiftsData = zeros(runs,1); %Errros from the center of the MDLL (in samples)
ShiftsData1 = zeros(runs,1); %Errros from the center of the MDLL (in time)

SamplesData = zeros(runs,2*delta_shift_samples+1);
SamplesData_noiseless = zeros(runs,2*delta_shift_samples+1);  %This is used for the autoencoder
Data = zeros(runs,size(ShiftsData,2) + size(SamplesData,2));

if EstimateDoppler
    B_PLL = 50;
    [AA BB CC DD] = PLL_getss(B_PLL,fs);
    fDhat = fDs(1,1)
    x = [2*pi*fDhat/CC];
    phasehat = 0;
end

if(useCIR)
   %% CIR Initialization
pth = cd;
addpath(pth,'LandMobileMultipathChannelModel32');
addpath ([pth,'/LandMobileMultipathChannelModel32','/Knife Edge']);
addpath ([pth,'/LandMobileMultipathChannelModel32/Parameter Files']);

Parameters.SampFreq=1e3;        % Hz
Parameters.MaximumSpeed=7;      % km/h
Parameters.SatElevation=30;     % Deg
Parameters.SatAzimut=-45;       % Deg (North == 0, East == 90, South == 180, West == 270)
%Parameters.NumberOfSteps=500;

% ---- General Parameters ----

ChannelParams.CarrierFreq=1.57542e9;     % Hz
ChannelParams.SampFreq=Parameters.SampFreq;
ChannelParams.EnableDisplay=0;           % 3D visualization is not available in the free version
ChannelParams.EnableCIRDisplay=1;        % enables CIR display

% ---- Mode Parameters ----

ChannelParams.UserType = 'Pedestrian';
ChannelParams.Surrounding = 'Urban';
ChannelParams.AntennaHeight = 1;         % m Height of the Antenna
ChannelParams.MinimalPowerdB=-40;        % Echos below this Limit are not initialised

% ---- UserParameters ---

ChannelParams.DistanceFromRoadMiddle=-6.5;% negative: continental (right), positive: England (left)

% ---- Graphics Parameters ---           

ChannelParams.GraphicalPlotArea=50;      % 
ChannelParams.ViewVector = [-60,20];     % 3D visualization is not available in the free version
ChannelParams.RoadWidth = 10;            %

% --- Building Params ---

ChannelParams.BuildingRow1=1;            % logigal to switch Building Row right(heading 0 deg) on
ChannelParams.BuildingRow2=1;            % logigal to switch Building Row left (heading 0 deg) on
ChannelParams.BuildingRow1YPosition=-8;  % m
ChannelParams.BuildingRow2YPosition=8;   % m

ChannelParams.HouseWidthMean=22;         % m
ChannelParams.HouseWidthSigma=25;        % m
ChannelParams.HouseWidthMin=10;          % m
ChannelParams.HouseHeightMin=4;          % m
ChannelParams.HouseHeightMax=50;         % m
ChannelParams.HouseHeightMean=16;        % m
ChannelParams.HouseHeightSigma=6.4;      % m
ChannelParams.GapWidthMean=27;           % m
ChannelParams.GapWidthSigma=25;          % m
ChannelParams.GapWidthMin=10;            % m
ChannelParams.BuildingGapLikelihood=0.18;% lin Value

% --- Tree Params ---

ChannelParams.TreeHeight = 6;            % m
ChannelParams.TreeDiameter = 3;          % m
ChannelParams.TreeTrunkLength=2;         % m
ChannelParams.TreeTrunkDiameter=.2;      % m

ChannelParams.TreeAttenuation = 1.1;     % dB/m

ChannelParams.TreeRow1Use=1;             % logical switches tree row 1 on
ChannelParams.TreeRow2Use=1;             % logical switches tree row 2 on

ChannelParams.TreeRow1YPosition=-6;      % m
ChannelParams.TreeRow2YPosition=6;       % m

ChannelParams.TreeRow1YSigma=0.5;        % m
ChannelParams.TreeRow2YSigma=0.5;        % m

ChannelParams.TreeRow1MeanDistance=60;   % m
ChannelParams.TreeRow2MeanDistance=40;   % m

ChannelParams.TreeRow1DistanceSigma=20;  % m
ChannelParams.TreeRow2DistanceSigma=20;  % m

% --- Pole Params ---

ChannelParams.PoleHeight = 10;           % m
ChannelParams.PoleDiameter = .2;         % m

ChannelParams.PoleRow1Use=1;             % logical switches Pole row 1 on
ChannelParams.PoleRow2Use=0;             % logical switches Pole row 2 on

ChannelParams.PoleRow1YPosition=-6;      % m
ChannelParams.PoleRow2YPosition=0;       % m

ChannelParams.PoleRow1YSigma=0.5;        % m
ChannelParams.PoleRow2YSigma=0.5;        % m

ChannelParams.PoleRow1MeanDistance=25;   % m
ChannelParams.PoleRow2MeanDistance=10;   % m

ChannelParams.PoleRow1DistanceSigma=10;  % m
ChannelParams.PoleRow2DistanceSigma=10;  % m

% --- Initialising the channel object ---
pause(1)
disp('Initialising the channel ...')
TheChannelObject=LandMobileMultipathChannel(ChannelParams); 
end

sigma_noise = sqrt(0.0005/(10.^(CNR_dB/10)))*samplesPerCode;
%sigma_noise = 0;
Tc = 1/chip_rate;
C = Tc/2/(1 - 2*(sigma_noise/samplesPerCode)^2);
%%
shift_center_lo = 500;%ceil(500*fs/chip_rate); %In Chips
%shift_center_hi = ceil(shift_center_lo*f_ratio); %In Chips

if (plotFlag)
    figure;
end
phase = 0;
tic;
for n = 1:runs
    %% Run Initialization
    clc;
    n/runs*100
    
    n_multipath = randi(8)-1;
    
    fD = 0;%fDs(n);
    
    A_LOS = 1+randn*0.15;
    %A_LOS = 0.5;
  
    noise1 = sigma_noise*randn(1,samplesPerCode);
    noise2 = sigma_noise*randn(1,samplesPerCode);
    noise = 1*noise1 + 1*1i*noise2;
    
    %shift = shift_Tc/chip_rate*fs*(1*(rand-0.5));
    shift = 0.2*shift_Tc/chip_rate*fs*randn;
    if (envelope_flag)
       shift = 0;
       n_multipath = 1;
    end
    %shift = 0;
    %shift = 0*fs_hi/chip_rate;
    ShiftsData(n) = shift;
    ShiftsData1(n) = shift;
    %ShiftsData(n) = shift/f_ratio;
    %ShiftsData1(n) = shift/f_ratio;

    %Shifting PRNs
    %code19_d = circshift(code19_hi,ceil(shift)+shift_center_hi);
    code19_d = A_LOS*resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift+shift_center_lo));
%     batata = Corr(code19_d,code19)/samplesPerCode;
%     figure; plot(batata)
    code19_Multipath = 0;
    %code19_Multipath = 0.5*exp(1i*0)*circshift(code19_hi,ceil(shift + 75)+shift_center_hi);
    
    if (useCIR && n_multipath > 0)

        Parameters.SatElevation = El(n)-30;
        CIR_time = n/Parameters.SampFreq;
        ActualSpeed=Parameters.MaximumSpeed/2/3.6*(1+sin(CIR_time));   
        ActualHeading=20*sin(CIR_time);     % Deg (North == 0, East == 90, South == 180, West == 270)

        [TheChannelObject,LOS,LOSDelays,ComplexOutputVec,DelayVec,EchoNumberVec,WayVec(n),CIR_time]=generate(TheChannelObject,ActualSpeed,ActualHeading,Parameters.SatElevation,Parameters.SatAzimut);
        LOS_mag = abs(LOS(1));
        LOS_phase = angle(LOS(1));
        for ii = 1:length(DelayVec)
            multipath_shift_samples = DelayVec(ii)*fs;
            theta = angle(ComplexOutputVec(ii)) - LOS_phase; %This is to keep LOS doppler = 1
            A_M = abs(ComplexOutputVec(ii))/LOS_mag; %This is to keep the LOS amplitude = 1
            multipath_amplitudes(n,ii) = A_M;
            code19_Multipath = code19_Multipath + A_LOS*A_M*exp(1i*theta)*resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(multipath_shift_samples+shift_center_lo));
        end

        if (plotCIR)
            figure(hh);
            subplot(211)
            cla
            title(['Channel Impulse Response (CIR), T = ',num2str(CIR_time,'%5.2f'),' s, v = ',num2str(ActualSpeed*3.6,'%4.1f'),' km/h'])
            stem(LOSDelays,abs(1),'r');
            stem(DelayVec,abs(ComplexOutputVec)/abs(LOS));

            subplot(212)
            cla
            stem(LOSDelays,angle(LOS),'r');
            stem(DelayVec,angle(ComplexOutputVec));
        end
    
    else
    
        for ii = 1:n_multipath
            %multipath_shift_samples = gamrnd(2.56,65.12)/c*fs_hi; %2.56,65.12
            multipath_shift_samples = randn()*1*fs/chip_rate;
            %multipath_shift_samples = 2*ceil((n-1)/runs*fs_hi/chip_rate); %2.56,65.12
            theta =pi/sqrt(3)*randn;
            %theta = pi*randn;
            %Linear Model for Attenuation
            %a = -0.0039 + (0.0039-0.0025)*rand();   % a = (-0.0039,-0.0025)
            %b = -12.7 + (12.7-11.9)*rand();
            %Att_db = a*(multipath_shift_samples)/fs_hi*1e3 + b;
            Att_db = 0.25*rand();

            A_M = 1*10^(Att_db/20);
            if (envelope_flag)
                %multipath_shift_samples = 2*ceil((n-1)/runs*fs_hi/chip_rate);
                multipath_shift_samples = 2*(n-1)/runs*fs/chip_rate;

                %theta = pi*rand;
                batata = [0,pi];
                theta = batata(randi(2));
                A_M = 0.5;
                %A_M = 10^-1.2;
            end
            multipathshifts(n) = multipath_shift_samples;

            code19_Multipath = code19_Multipath + A_LOS*A_M*exp(1i*theta)*resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(multipath_shift_samples+shift_center_lo));
        end
    end
    
%     thetas = 2*pi*fD*t_hi + phase;
%     phase = phase + 2*pi*fD*(t_hi(end) + 1/fs_hi);
    %thetas_lo = decimate(thetas,f_ratio,1,'fir');
%     thetas_lo = 2*pi*fD*t + phase;
%     phase_lo = phase + 2*pi*fD*(t(end) + 1/fs);
    
    if(EstimateDoppler)
        %thetas = 2*pi*fD*t_hi + phase;
        %phase = phase + 2*pi*fD*(t_hi(end) + 1/fs_hi);
        
        thetas_lo = 2*pi*fD*t + phase;
        phase_lo = phase + 2*pi*fD*(t(end) + 1/fs);
        
        thetashat = 2*pi*fDhat*t + phasehat;
        phasehat = phasehat + 2*pi*fDhat*(t(end) + 1/fs);
    else
        %phase = 0;
        %thetas = 0;
        thetas_lo = 0;
        thetashat = thetas_lo;
    end

    y = code19_d + code19_Multipath;% + code25_d + code5_d;
    A = 1;
    %y = y.*A.^0.5.*exp(-1i*thetas);
    
    %Resampling to low fs
    %y_lo_noiseless = decimate(y,f_ratio,1,'fir');
    y_lo_noiseless = y;
    y_lo = y_lo_noiseless + noise;

    y_lo = y_lo.*A.^0.5.*exp(-1i*thetas_lo);
    y_lo_noiseless = y_lo_noiseless.*A.^0.5.*exp(-1i*thetas_lo);

    %code19_d_lo = ceil(decimate(code19_d,f_ratio,1,'fir'));
    code19_d_lo = code19_d;

    if(plotFlag)
        R = Corr(y_lo.*exp(1i*thetashat),code19)./length(y_lo);
        R_noiseless = Corr(y_lo_noiseless.*exp(1i*thetashat),code19)./length(y_lo);
        R_Actual = Corr((code19_d_lo).*exp(-1i*(thetas_lo-thetashat)),code19)./length(y_lo);
        SamplesData(n,:) = R(shift_center_lo+1-delta_shift_samples:shift_center_lo+1+delta_shift_samples+0);
        %samplesData = getSamplesData(shift_center_lo,5,code19_1023,y_lo,f_ratio,7,fs);

        %SamplesData1(n,:) = decimate(SamplesData(n,:),10);
        %SamplesData(n,:) = SamplesData(n,:)/max(SamplesData(n,:));
        SamplesData_noiseless(n,:) = R_noiseless(shift_center_lo+1-delta_shift_samples:shift_center_lo+1+delta_shift_samples);
        %SamplesData(n,:) = R(shift_center-delta_shift_samples:shift_center+delta_shift_samples);

        if (n_multipath > 0)
            %code19_Multipath_lo = decimate(code19_Multipath,f_ratio,1,'fir');
            code19_Multipath_lo = code19_Multipath;
            R_M = Corr((code19_Multipath_lo).*exp(-1i*(thetas_lo-thetashat)),code19)./length(y_lo);
        else
            R_M = zeros(size(R,1),size(R,2));
        end
    else
        SamplesData(n,:) = getSamplesData(shift_center_lo,5,code19_1023,y_lo,f_ratio,7,fs);
        SamplesData_noiseless(n,:) = getSamplesData(shift_center_lo,5,code19_1023,y_lo_noiseless,f_ratio,7,fs);

    end
    
    %% DLL
    B_DLL = 1;
    
    %delta_shift_DLL = ceil(fs/chip_rate/2);
    %delta_shift_DLL = ceil(fs/chip_rate/2/10);
    delta_shift_DLL = 1; % In samples
%     prompt_PRN = circshift(code19,shift_center_lo  );
%     early_PRN = circshift(code19, shift_center_lo - delta_shift_DLL );
%     late_PRN = circshift(code19, shift_center_lo + delta_shift_DLL );
    
    prompt_PRN = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo));
    early_PRN = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo - delta_shift_DLL));
    late_PRN = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo + delta_shift_DLL));
    
    c_prompt = sum(prompt_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_early = sum(early_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_late = sum(late_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    
    L_t = (real(c_prompt)*(real(c_early) - real(c_late)) + imag(c_prompt)*(imag(c_early) - imag(c_late)));
    e_t = B_DLL*C*L_t;
    shift_DLL_samples(n) = -e_t*fs;
    
    DLLError(n) = ShiftsData(n) - shift_DLL_samples(n);
    %% HRC
    B_HRC = 2;
    
    %delta_shift_DLL = ceil(fs/chip_rate/2);
    %delta_shift_DLL = ceil(fs/chip_rate/2/10);
    delta_shift_HRC = 1;
    
%     early_PRN = circshift(code19, shift_center_lo - delta_shift_HRC );
%     late_PRN = circshift(code19, shift_center_lo + delta_shift_HRC );
%     early_PRN1 = circshift(code19, shift_center_lo - 2*delta_shift_HRC );
%     late_PRN1 = circshift(code19, shift_center_lo + 2*delta_shift_HRC );
    
    early_PRN = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo - delta_shift_HRC));
    late_PRN = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo + delta_shift_HRC));
    early_PRN1 = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo - 2*delta_shift_HRC));
    late_PRN1 = resample_PRN(code19_1023,samplesPerCode,chip_rate,fs,-(shift_center_lo + 2*delta_shift_HRC));

    
    c_early = sum(early_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_late = sum(late_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_early1 = sum(early_PRN1.*y_lo.*exp(1i*thetashat))./length(y_lo);
    c_late1 = sum(late_PRN1.*y_lo.*exp(1i*thetashat))./length(y_lo);
    
    L_HRC = (c_early - c_late) - 0.5*(c_early1 - c_late1);
    e_HRC = C*L_HRC;
    shift_HRC_samples(n) = -e_HRC*fs;
    
    HRCError(n) = ShiftsData(n) - shift_HRC_samples(n);
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
        %NNShift_Keras(n) = (PredictShift_2p5(real(SamplesData(n,:))));
        %SamplesData_scaled = (SamplesData(n,:) - means)./stds;
        NNShift_Keras(n) = double(predict(net,real(SamplesData(n,:))));
        %NNError(n) = ShiftsData(n) - NNShift_Keras(n);
        NNError_Keras(n) = ShiftsData(n) - NNShift_Keras(n);
        %prompt_PRN = circshift(code19,shift_center + ceil(NNError(n)));
        %_promptNN = sum(prompt_PRN.*y.*exp(1i*thetashat))./length(code19_d);
        %I_DataNN(n) = c_promptNN;

    end
    %% Plot
    if (plotFlag)
        %% Plot
        %Plot Actual
        subplot(3,1,1)
        plot(t_plot,real(R_Actual))
        xlim([shift_center_lo-delta_shift_samples,shift_center_lo+delta_shift_samples]);
        xline(shift_center_lo + ShiftsData(n) +1*shift_right);
        xline(shift_center_lo + shift_DLL_samples(n) +1*shift_right,'r');           

        if (NNErrorFlag)
           xline(shift_center_lo + NNShift_Keras(n)-1 +1*shift_right,'g');
           %xline(shift_center_lo + NNShift_Keras(n)-1 +1*shift_right,'b');

        end
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Line of Sight Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (DLL)','Estimated Prompt (NN)','Keras')

        %ylim([0,0.3])

        %Plot Multipath
        subplot(3,1,2)
        plot(t_plot,real(R_M))
        xlim([shift_center_lo-delta_shift_samples,shift_center_lo+delta_shift_samples]);
        xline(shift_center_lo + ShiftsData(n));
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Multipath Signal')
        legend('Correlation')


        %ylim([0,0.3])


        %Plot Total
        subplot(3,1,3)
        hold off
        plot(t_plot,real(R),'b')
        xlim([shift_center_lo-delta_shift_samples,shift_center_lo+delta_shift_samples]);
        xline(shift_center_lo + ShiftsData(n));
        if (NNErrorFlag)
           xline(shift_center_lo + NNShift_Keras(n),'g');
           xline(shift_center_lo + shift_DLL_samples(n),'r');
        end
        hold on

        plot(shift_center_lo -1 + ceil(shift_DLL_samples(n)) - delta_shift_DLL,...
            real(R(shift_center_lo + ceil(shift_DLL_samples(n)) - delta_shift_DLL)),'r*')
        plot(shift_center_lo -1 + ceil(shift_DLL_samples(n)) + delta_shift_DLL,...
            real(R(shift_center_lo + ceil(shift_DLL_samples(n)) + delta_shift_DLL)),'r*')
        plot(shift_center_lo -1 + ceil(shift_DLL_samples(n)),...
            real(R(shift_center_lo + ceil(shift_DLL_samples(n)))),'r*')
        xlabel('Shifts in Code')
        ylabel('Correlation Power')
        title('Received Signal')
        legend('Correlation','Prompt Shift','Estimated Prompt (NN)','Estimated Prompt (DLL)','Early - Prompt - Late')

        %%
        drawnow
       
    end
end
toc
%% Calculate RMSE
if (NNErrorFlag)
    NN_Keras_RMSE = norm(NNError_Keras)/sqrt(runs)/fs*3e8
    %NN_RMSE = norm(NNError)/sqrt(runs)/fs*3e8
end

HRC_RMSE = norm(HRCError)/sqrt(runs)/fs*3e8

DLL_RMSE = norm(DLLError)/sqrt(runs)/fs*3e8


Data = [abs(SamplesData),ShiftsData1];
X_noiseless = real(SamplesData_noiseless);
csvwrite('Data_new.csv',Data);
csvwrite('AutoencoderData_new.csv',[real(SamplesData),X_noiseless]);

%% Plot Envelope
if (envelope_flag)
%     figure; scatter(multipathshifts/fs_hi*3e8,NNError_Keras/fs*3e8,'.')
%     hold on; scatter(multipathshifts/fs_hi*3e8,DLLError/fs*3e8,'.')
%     scatter(multipathshifts/fs_hi*3e8,HRCError/fs*3e8,'.')
    
    figure; scatter(multipathshifts/fs*3e8,NNError_Keras/fs*3e8,'.')
    hold on; scatter(multipathshifts/fs*3e8,DLLError/fs*3e8,'.')
    scatter(multipathshifts/fs*3e8,HRCError/fs*3e8,'.')
    
    legend('NN Error','E-P-L Error','HRC Error')
    xlabel('Multipath Shift Delay (m)')
    ylabel('Code Phase Error (m)')
    title(['Error Envelopes', ' ~CNR: ', num2str(CNR_dB),'dB-Hz'])
    grid on;
end