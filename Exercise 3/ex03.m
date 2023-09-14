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
    end
    subplot(4,4,count);
    plot(sum/140);
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
for m=1:16
    muscle_mean(1,m) = mean(muscle_contraction(m,:));
    muscle = channels(:,m);
    sum = zeros(1,15001);
    for c=1:140
        sum = sum + (muscle{c,1}-muscle_mean(1,m)).^2;
    %     subplot(4,5,count2);
    %     plot(muscle{d,1});
    %     count2 = count2+1;
    end
    % test = min(new_matrix);
    % size(test)
    % var = zeros(1,15001);
%     minimum = min(new_matrix);
%     maximum = max(new_matrix);
%     diff = maximum - minimum;
    subplot(4,4, count2);
    plot(sqrt(sum/140));
    t = file.emglab(1,m);
    title(t);
    count2 = count2+1;
end
% for c=1:15001
%     min = min(new_matrix(:,c));
%     max = max(new_matrix(:,c));
%     dif = max - min;
% %     var(1,c) = dif;
% end
% min
% max
% dif
% plot(var);

% A = [2 8 4; 7 3 9];
% M = max(A)
%  
