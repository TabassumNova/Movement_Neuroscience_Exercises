clc;
close all;

file = load('Exercise2.mat');
% motor_unit = 6;
% mupulse = file.MUPulses{1, motor_unit};
sig = file.SIG;
fsamp = file.fsamp;
% window_size = ceil(.03 * fsamp);
sig1 = sig{1,1};
cell_row = size(sig, 1);
cell_col = size(sig, 2);
total_cell = cell_row*cell_col;
time = 15/2;
sample = ceil(file.fsamp * (time/1000));
all_center = zeros(18, 2);

figure2=figure('Position', [100, 100, 1024, 1200]);
count2= 1;
for m=1:18
    motor_unit = m;
    mupulse = file.MUPulses{1, motor_unit};
    avg_AP_all = zeros(cell_row,cell_col,length(mupulse));
    rms_AP_all = zeros(cell_row,cell_col);
    count1 = 1;
%     figure1=figure('Position', [100, 100, 1024, 1200]);

    for r=1:cell_row
        for c=1:cell_col
            AP_cell = zeros(1, length(mupulse));
            for spike=1:length(mupulse)
                value = mupulse(1,spike);
                AP = sig{r,c}(value-sample:value+sample);
                avg_AP = mean(AP);
                AP_cell(1,spike) = avg_AP;
            end
%             subplot(13,5,count1);
%             plot(AP_cell);
            count1=count1+1; 
            avg_AP_all(r,c,:) = AP_cell;
            rms_AP_all(r,c) = compute_rms(AP_cell);
        end

    end
%   
    [y,in] = max(rms_AP_all);
    [v,column] = max(y);
    [~,row] = max(rms_AP_all(:,column));
    coordinates = [row, column];
    all_center(m,:) = coordinates;
end

mean_row = mean(all_center(:,1));
mean_col = mean(all_center(:,2));
sum = 0;
for i=1:18
    dist = (all_center(i,1)-mean_row).^2 + (all_center(i,2)-mean_col).^2;
    sum = sum + dist;
end
for m=1:18
    motor_unit = m;
    mupulse = file.MUPulses{1, motor_unit};
    avg_AP_all = zeros(cell_row,cell_col,length(mupulse));
    rms_AP_all = zeros(cell_row,cell_col);
    count1 = 1;
%     figure1=figure('Position', [100, 100, 1024, 1200]);

    for r=1:cell_row
        for c=1:cell_col
            AP_cell = zeros(1, length(mupulse));
            for spike=1:length(mupulse)
                value = mupulse(1,spike);
                AP = sig{r,c}(value-sample:value+sample);
                avg_AP = mean(AP);
                AP_cell(1,spike) = avg_AP;
            end
%             subplot(13,5,count1);
%             plot(AP_cell);
            count1=count1+1; 
            avg_AP_all(r,c,:) = AP_cell;
            rms_AP_all(r,c) = compute_rms(AP_cell);
        end

    end
  
    [y,in] = max(rms_AP_all);
    [v,column] = max(y);
    [~,row] = max(rms_AP_all(:,column));
    coordinates = [row, column];
%     all_center(m,:) = coordinates;
%     mean_row = mean(all_center(:,1));
%     mean_col = mean(all_center(:,2));
    x = ['Barycenter of Motor unit ' , num2str(m), ': (', num2str(row),', ',num2str(column),')'];
    disp(x);
    subplot(6,3,count2);
%     rms_AP_all(row, column) = .2;
    imagesc(rms_AP_all);
%     hold on;
%     for i=0:0.75:6
%         for j=0:1.625:13
%             plot(i,j,'.w')
%         end
%     end
    hold on;
    plot(column,row,'r*');
    hold on;
    disp(mean_col);
    disp(mean_row);
    plot(mean_col, mean_row, 'ob');
    hold on;
    plot([column, mean_col], [row, mean_row], '-b');
    hold on;
    textString = sprintf('(%d, %d)', row, column);
    text(column,row, textString, 'FontSize', 7);  
    
    count2=count2+1;
end

stdist = sqrt(sum/18);

function rms = compute_rms(x)
    s = 0;
    for i=1:length(x)
        s = s + x(1,i).^2;
    end
    rms = sqrt(1/length(x).*(s));
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

