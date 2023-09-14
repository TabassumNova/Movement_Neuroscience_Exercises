clc;
close all;

file = load('Exercise2.mat');
motor_unit = 1;
mupulse = file.MUPulses{1, motor_unit};
sig = file.SIG;
fsamp = file.fsamp;
window_size = ceil(.03 * fsamp);
sig1 = sig{1,1};
cell_row = size(sig, 1);
cell_col = size(sig, 2);
total_cell = cell_row*cell_col;
fsamp = file.fsamp;
time_limit = length(sig{1,1})/file.fsamp;
time = linspace(0,time_limit,length(sig{1,1}));
avg_AP_p = zeros(cell_row*cell_col, 2*window_size);
count = 1;
figure1=figure('Position', [100, 100, 1024, 1200]);
for r=1:cell_row
    for c=1:cell_col
        AP = zeros(1, 2*window_size);
        for spike=1:length(mupulse)
            value = mupulse(1,spike);
            for i=-window_size:window_size
                AP(spike, i+window_size+1) = sig{r,c}(value+i);
            end
            avg_AP = mean(AP);
            size(AP)
            size(avg_AP)
            subplot(13,5,count);
            plot(avg_AP);
            count=count+1;
        end
        avg_AP_p(x*y,:)=avg_AP;
%         subplot(13,5,count);
%         plot(AP);
%         count=count+1;
        avg_AP=zeros(65, length(mupulse));
        
    end
    
end

% x = [];
% y = [];
% for i=1:length(mupulse1)
%     pos = mupulse1(1,i);
%     time = pos/fsamp;
%     x(i) = time;
%     y(i) = sig1(1,pos);
%     
% end
% plot(x,y)

