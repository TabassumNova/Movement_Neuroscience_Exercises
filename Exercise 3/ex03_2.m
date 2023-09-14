clc;
clear;
data=load('AllTrials.mat');
alltrail=data.allTrials;
emgname=data.emglab;
%part1
figure(1)
dev=zeros(16,15001);
mean_sig=zeros(16,15001);
for i=1:16
    sig=alltrail(:,i);
    sigM = cell2mat(sig);
    subplot(4,4,i);
    for j=1:140
    plot(sigM(j,:),'b')
    hold on;
    end
    name=emgname(1,i);
    mean_sig(i,:)=mean(sigM);
    
    
    plot(mean_sig(i,:),'r');
    hold on;
%     plot(var(sigM));
%     hold on;
%     plot(std(sigM));
     title(name);
%     dev(i,:)=std(sigM);
%     
end
%part2
stdev=zeros(140,1);
variablity=zeros(16,1);
range=zeros(16,1);
meanval=zeros(16,1);
for m=1:16
    sig1=alltrail(:,m);
    sigM = cell2mat(sig1);
    for i=1:140
    stdev(i,1)=std(sigM(i,:));
   
    end
    max_val=max(stdev);
    min_val=min(stdev);
    meanval(m,1)=mean(stdev);
    variablity(m,1)=var(stdev);
    range(m,1)=max_val-min_val;
end
[argmax maxi]=max(variablity);
muscle_max=emgname(maxi);
figure(2);
subplot(3,1,1);
title('range');
plot(range(1:8,1));
hold on;
plot(range(9:16,1));
subplot(3,1,2);
title('mean');
 plot(meanval(1:8,1));
hold on;
 plot(meanval(9:16,1));
subplot(3,1,3);
title('variablity');
plot(variablity(1:8,1));
hold on;
plot(variablity(9:16,1));
%Onset
onset=zeros(16,1);
maxmat=zeros(16,1);
figure(3);
for i=1:16
  sig=mean_sig(i,:);
  maxm=max(sig)*0.9;
  maxmat(i,1)=maxm;
  tem=find(mean_sig(i,:)>=maxm);
  onset(i,1)=tem(1,1);
end
[v trig]=min(onset);
emgname(trig);

plot(onset);
%part3
[W,H] = nnmf(mean_sig,2);
figure(4);
plot(H(1,:));
hold on;
% x = H(2,:)
plot(H(2,:));
title('Plot of first two Components');
legend({'1st Component','2nd Component'},'Location','northeast')