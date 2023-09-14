clc;
close all;

file = load('AllTrials.mat');
channels = file.allTrials;
%%%%%%%%%%% Problem 01 %%%%%%%%%%
figure(1);
count = 1;
muscle_contraction = zeros(16,15001);
for m = 1:16
    muscle = channels(:,m);
    sum = zeros(1,15001);
    for c=1:140
        sum = sum + muscle{c,1};
        subplot(4,4,count);
        plot(muscle{c,1},'b')
        hold on;
    end
%     subplot(4,4,count);
    plot(sum/140, 'r');
    muscle_contraction(m,:) = sum/140;
    t = file.emglab(1,m);
    title(t);
    count = count+1;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Problem 02 %%%%%%%%%%%%
figure(2);
count2 = 1;
muscle_mean = zeros(1,16);
muscle_std = zeros(16,140);
muscle_var = zeros(16,140);
muscle_range = zeros(1,16);
for m=1:16
    for c=1:140
        muscle_std(m,c) = std(channels{c,m});   
    end
    muscle_mean(1,m) = mean(muscle_std(m,:));
    muscle_var(1,m) = var(muscle_std(m,:)/muscle_mean(1,m));
    maximum = max(muscle_std(m,:));
    minimum = min(muscle_std(m,:));
    muscle_range(1,m) = maximum - minimum;
end
subplot(3,1,1)
plot(muscle_mean(1,1:8));
hold on;
plot(muscle_mean(1,8:15));
axis([0 9 0 1.75]);
xticklabels({'','Deltoid','ECR','EDC','Biceps','Brachialis','BR','FCR','FDS',''});
title('Mean');
legend({'Left','Right'},'Location','northeast')

subplot(3,1,2)
plot(muscle_var(1,1:8));
hold on;
plot(muscle_var(1,8:15));
axis([0 9 -1 3]);
xticklabels({'','Deltoid','ECR','EDC','Biceps','Brachialis','BR','FCR','FDS',''});
title('Var');
legend({'Left','Right'},'Location','northeast')

subplot(3,1,3)
plot(muscle_range(1,1:8));
hold on;
plot(muscle_range(1,8:15));
axis([0 9 0 3]);
xticklabels({'','Deltoid','ECR','EDC','Biceps','Brachialis','BR','FCR','FDS',''});
title('Range');
legend({'Left','Right'},'Location','northeast')

%%%% Onset %%%%%
figure(3);
onset = zeros(16,140);
final_onset = zeros(1,16);
for m=1:16
%     plot(channels{1,m});
%     hold on;
    for c=1:140
        maximum = max(channels{c,m});
        for i=1:15001
            if channels{c,m}(i) >= maximum*.9
                onset(m,c) = i;
                break;
            end
        end
    end
    final_onset(1,m) = mean(onset(m,c));
end

plot(final_onset);
% xticklabels({'Deltoid','ECR','EDC','Biceps','Brachialis','BR','FCR','FDS','Deltoid','ECR','EDC','Biceps','Brachialis','BR','FCR','FDS'});
title('Onset');
xlabel('Muscle No.');
ylabel('Sample No.');

%%%%%%%%%% Problem 4 %%%%%%%%
[W,H] = nnmf(muscle_contraction,2);
figure(4);
plot(H(1));