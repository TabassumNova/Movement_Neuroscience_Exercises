clc
load AllTrials.mat;
data = cell2mat(allTrials);

[W,H] = nnmf(data,2);
figure(4);
plot(H(1));

% artificial data set of 100 variables (genes) and 10 samples
[W, pc] = pca(data');
pc=pc';
W=W';
plot(pc(1,:),pc(2,:),'.'); 
title('Principle Component Analysis'); 
grid on

[coeff,newdata,latend,tsd,variance] = pca(data');