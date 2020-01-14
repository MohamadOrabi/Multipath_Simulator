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

%% Testing the fd and pseudorange
load('fDmat.mat')   % In Hz
load('pseudoranges.mat')    % In meters

sat = 9;    %Do not change now!

% Interpolating fD and pseudorange
pseudorange(sat,:) = interpolatevec(pseudoranges(sat,:));
fDs = interpolatevec(fDmat(sat,:));
c = 299792458;


calculated_pr = cumsum(-fDs./1575.42e6*c)*1e-3 + pseudorange(sat,1);

figure; 
hold on;
plot(pseudorange(sat,:));
plot(calculated_pr);
%legend('Actual Pseudorange', 'Calculated Using fD')

 %% MEDLL
    Residual = R;
    
    %Estimating and Removing Multipath Components
    for iterations = 1:2
        
        tau_hat1 = find(abs(real(Residual)) == abs(max(real(Residual))));
        a_hat1 = real(Residual(tau_hat1));
        R_estimate1 = a_hat1*circshift(R_reference,tau_hat1-1);
        
        R_m = Residual - R_estimate1;
        
        tau_hat2 = find(abs(real(R_m)) == abs(max(real(R_m))));
        a_hat2 = real(R_m(tau_hat2));
        R_estimate2 = a_hat2*circshift(R_reference,tau_hat2-1);
        
        Residual = Residual - R_estimate2;
        
%         figure;
%         hold on;
%         plot(real(Residual))
%         plot(real(R_noiseless));
%         plot(real(R_Actual))
%         
%         legend('Residual', 'Original', 'Actual')
%         xlim([tau_hat1-5,tau_hat1+5])

    end
    
    %Running DLL on the residual
    B_DLL = 1;
    
    delta_shift_DLL = round(fs/chip_rate/2);
%     prompt_PRN = circshift(code19,round(code_shift_hat_DLL(n)) - 1);
%     early_PRN = circshift(code19, round(code_shift_hat_DLL(n)) - delta_shift_DLL - 1);
%     late_PRN = circshift(code19, round(code_shift_hat_DLL(n)) + delta_shift_DLL - 1);
    
%     c_prompt = sum(prompt_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
%     c_early = sum(early_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);
%     c_late = sum(late_PRN.*y_lo.*exp(1i*thetashat))./length(y_lo);

    c_prompt = real(Residual(round(code_shift_hat_MEDLL(n)) - 1));
    c_early = real(Residual(round(code_shift_hat_MEDLL(n)) - delta_shift_DLL - 1));
    c_late = real(Residual(round(code_shift_hat_MEDLL(n)) + delta_shift_DLL - 1));
    
    L_t = (real(c_prompt)*(real(c_early) - real(c_late)) + imag(c_prompt)*(imag(c_early) - imag(c_late)));
    e_t = B_DLL*C*L_t;
    shift_MEDLL_samples(n) = -e_t*fs;
    code_shift_hat_MEDLL(n+1) = round(code_shift_hat_MEDLL(n)) + shift_MEDLL_samples(n);
    
    MEDLLError(n) = ShiftsData(n) - code_shift_hat_MEDLL(n);
    
%     figure; plot(real(Residual))


%% Get Erros in seperate regions
runs = length(NNError);
n_2 = length(NNError(round(runs/3):round(2*runs/3)-1))
n_1 = length(NNError([1:round(runs/3)-1]))
n_3 = length(NNError([round(2*runs/3):end]))

%Region1
NN_RMSE1 = norm(NNError([1:round(runs/3)-1]))/sqrt(n_1)/fs*c;
HRC_RMSE1 = norm(HRCError([1:round(runs/3)-1]))/sqrt(n_1)/fs*c;
Narrow_DLL_RMSE1 = norm(Narrow_DLLError([1:round(runs/3)-1]))/sqrt(n_1)/fs*c;
DLL_RMSE1 = norm(DLLError([1:round(runs/3)-1]))/sqrt(n_1)/fs*c;

%Region2
NN_RMSE2 = norm(NNError(round(runs/3):round(2*runs/3)-1))/sqrt(n_2)/fs*c;
HRC_RMSE2 = norm(HRCError(round(runs/3):round(2*runs/3)-1))/sqrt(n_2)/fs*c;
Narrow_DLL_RMSE2 = norm(Narrow_DLLError(round(runs/3):round(2*runs/3)-1))/sqrt(n_2)/fs*c;
DLL_RMSE2 = norm(DLLError(round(runs/3):round(2*runs/3)-1))/sqrt(n_2)/fs*c;

%Region3
NN_RMSE3 = norm(NNError([round(2*runs/3):end]))/sqrt(n_3)/fs*c;
HRC_RMSE3 = norm(HRCError([round(2*runs/3):end]))/sqrt(n_3)/fs*c;
Narrow_DLL_RMSE3 = norm(Narrow_DLLError([round(2*runs/3):end]))/sqrt(n_3)/fs*c;
DLL_RMSE3 = norm(DLLError([round(2*runs/3):end]))/sqrt(n_3)/fs*c;

NN_RMSE = [NN_RMSE1,NN_RMSE2,NN_RMSE3]
HRC_RMSE = [HRC_RMSE1,HRC_RMSE2,HRC_RMSE3]
Narrow_DLL_RMSE = [Narrow_DLL_RMSE1,Narrow_DLL_RMSE2,Narrow_DLL_RMSE3]
DLL_RMSE = [DLL_RMSE1,DLL_RMSE2,DLL_RMSE3]



