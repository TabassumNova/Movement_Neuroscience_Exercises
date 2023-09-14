clearvars, clc, close all
load('Slow_contraction.mat')
FORCE = ref_signal;
FACTOR = 0.0197754; FACTOR_newton = 9.806652;
FORCE = FORCE/FACTOR*FACTOR_newton;

[bb,aa] = butter(3,[5*2/fsamp]);
FORCE = filtfilt(bb,aa,FORCE); 

% exercise 1 
figure, hold on, plot(FORCE)
xlabel('samples')
ylabel('Force (N)')

[x,y] = ginput(); 
FORCE_steady = FORCE(round(x(1)):round(x(2))); 
%
close all, plot(FORCE_steady)
[BEMG,AEMG] = butter(3,[20 500]*2/fsamp);

COV = std(FORCE_steady)/mean(FORCE_steady)*100

%% exercise 2 

clearvars, clc, close all
load('Rapid_Contractions.mat')
FORCE = ref_signal;

FACTOR = 0.0197754; FACTOR_newton = 9.806652; 
FORCE = FORCE/FACTOR*FACTOR_newton;

% plot(FORCE), hold on

[bb,aa] = butter(3,[20*2/fsamp]); % change filter! 
FORCE_filt = filtfilt(bb,aa,FORCE); 

% plot(FORCE_filt)
ONSET = 1808; % 1808

Contraction = FORCE_filt(ONSET:ONSET+0.5*fsamp); % plot to check! 
Contraction = Contraction-Contraction(1); % to remember

for indices = 1:size(Contraction,2)  % 32 = 0.015 seconds 1:size(NeuralDrive
%     keyboard
    RFDmax(indices) = Contraction(indices)/(indices/fsamp);

end

plot((1:size(Contraction,2))./fsamp,RFDmax)

xlabel('Time (s)')
ylabel('RFD N/s')

%%
clearvars, clc, close all
load('Slow_contraction.mat')
FORCE = ref_signal;

EMG = mean(vertcat(SIG{:})); 
EMG_abs = abs(mean(vertcat(SIG{:}))); 

FACTOR = 0.0197754; FACTOR_newton = 9.806652; 
FORCE = FORCE/FACTOR*FACTOR_newton;

windowl = round(0.2*fsamp); 
indices = 1:windowl:length(EMG)-windowl; 

for k1 = 1:size(indices,2)

    EMG_rms(k1) = rms(EMG(indices(k1):indices(k1)+windowl)); 
    FORCE2(k1) = mean(FORCE(indices(k1):indices(k1)+windowl)); 
    EMG_mean(k1) = mean(EMG_abs(indices(k1):indices(k1)+windowl)); 
end


figure(1)
plotregression(FORCE2,EMG_rms)

%%
clearvars, clc, close all
load('Slow_contraction.mat')
FORCE = ref_signal;

EMG = mean(vertcat(SIG{:})); 
EMG_abs = abs(mean(vertcat(SIG{:}))); 

FACTOR = 0.0197754; FACTOR_newton = 9.806652; 
FORCE = FORCE/FACTOR*FACTOR_newton;

windowl = round(0.2*fsamp); 
indices = 1:windowl:length(EMG)-windowl; 

for k1 = 1:size(indices,2)
%     keyboard
    EMG_rms(k1) = rms(EMG(indices(k1):indices(k1)+windowl)); 
    EMG_mean(k1) = mean(EMG_abs(indices(k1):indices(k1)+windowl)); 
    FORCE2(k1) = mean(FORCE(indices(k1):indices(k1)+windowl)); 
%     if k1 == 2
%     keyboard
%     end
end

figure(1)
plotregression(FORCE2,EMG_rms)





