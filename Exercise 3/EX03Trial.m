% clearvars, clc, close all
% load('AllTrials.mat')
% 
% x = -2:1/srate:1;
% 
% for muscles = 1:16
%     subplot(4,4,muscles)
%     for trials = 1:size(allTrials,1)
%         
%         Trials(trials,:) = allTrials{trials,muscles}*1000;
%         
%         plot(x,allTrials{trials,muscles}*1000,'color',[0.6 0.6 0.6]), hold on
%         
%     end
%     
%     title(emglab(muscles))
%     
%     plot(x,mean(Trials),'k')
%     
%     ylim([0 roundn(max(mean(Trials))+max(mean(Trials)*2),3)])
%     yticks([0 roundn(max(mean(Trials))+max(mean(Trials)*2),3)])
%     
%     leftside = [ 1 5 9 13];
%     if sum(leftside == muscles) == 1
%         ylabel('\muV')
%     end
%     if muscles >=13
%         xlabel('Time (s)')
%     end
%     
% end

% clearvars, clc, close all
% load('AllTrials.mat')
% 
% x = -2:1/srate:1;
% count = 1;
% for muscles = 1:16
%     %     subplot(4,4,muscles)
%     
%     Muscle = []; 
%     for trials = 1:size(allTrials,1)
%         
%         Trials(trials,:) = allTrials{trials,muscles}*1000;
%         Muscle(trials,:) = allTrials{trials,muscles}*1000;
%         %         plot(x,allTrials{trials,muscles}*1000,'color',[0.6 0.6 0.6]), hold on
%         
%         Variability(muscles,trials) = std(Trials(trials,:))/mean(Trials(trials,:));
%         Variance(muscles,trials) = var(Trials(trials,:));
%         
%     end
%     
%     MusclePattern(muscles,:) = mean(Muscle);
% %     keyboard
%     
%     if muscles <= 8 % left arm
%         plot(muscles,mean(Variability(muscles,:)),'ko'), hold on
%     end
%     if muscles >8 % right arm
%         plot(count,mean(Variability(muscles,:)),'ro'), hold on
%         count = count +1;
%     end
%     %   text(muscles,mean(Variability(muscles,:))+0.01,emglab(muscles))
%     
%     
%     
% end
% 
% set(gca,'xticklabel',emglab(1:8)')
% ylabel('std')
% 
% figure(2)
% 
% plot(MusclePattern(1:8,:)','k')
% 
% figure(3)
% 
% plot(MusclePattern(9:16,:)','r')

%%
[BEMG,AEMG] = butter(3,[20*2/srate]);

AllActivations= vertcat(allTrials{:});
%%

[coeff,score,latent,tsquared,explained,mu] = pca(AllActivations) ;
%%
plot(explained)
xlim([0 10])
xlabel('Components')
ylabel('Variance Explained (%)')

figure(2);
plot(coeff(:,2)); 
