clc;
close all;

file = load('Exercise2.mat');
sig = file.SIG;
fsamp = file.fsamp;
sig1 = sig{1,1};
cell_row = size(sig, 1);
cell_col = size(sig, 2);
total_cell = cell_row*cell_col;
time = 15/2;
sample = ceil(file.fsamp * (time/1000));
all_center = zeros(18, 2);
figure1=figure('Position', [100, 100, 1024, 1200]);
figure2=figure('Position', [100, 100, 1024, 1200]);
count2= 1;
rms_AP_all_motor = zeros(cell_row,cell_col,18);
figure(1);

for m=1:18
    motor_unit = m;
    mupulse = file.MUPulses{1, motor_unit};
    avg_AP_all = zeros(cell_row,cell_col,length(mupulse));
    rms_AP_all = zeros(cell_row,cell_col);
    count1 = 1;

    for r=1:cell_row
        for c=1:cell_col
            AP_cell = zeros(1, length(mupulse));
            for spike=1:length(mupulse)
                value = mupulse(1,spike);
                AP = sig{r,c}(value-sample:value+sample);
                avg_AP = mean(AP);
                AP_cell(1,spike) = avg_AP;
            end
            avg_AP_all(r,c,:) = AP_cell;
            rms_AP_all(r,c) = compute_rms(AP_cell);
            
            if m==1
                
                subplot(13,5,count1);
                plot(AP_cell);
                count1=count1+1; 
            end
            
        end

    end
    rms_AP_all_motor(:,:,m) = rms_AP_all;

end
sgtitle('Average Action Potential of Motor unit 01 for window size 15ms');

for m=1:18
    [y,in] = max(rms_AP_all_motor(:,:,m));
    [v,column] = max(y);
    [~,row] = max(rms_AP_all_motor(:,column,m));
    coordinates = [row, column];
    all_center(m,:) = coordinates;
    x = ['Barycenter of Motor unit ' , num2str(m), ': (', num2str(row),', ',num2str(column),')'];
    disp(x);
end

mean_row = mean(all_center(:,1));
mean_col = mean(all_center(:,2));
for m=1:18
    figure(2)
    subplot(6,3,count2);
    imagesc(rms_AP_all_motor(:,:,m));
    hold on;
    plot(all_center(m,2),all_center(m,1),'r*')
    hold on;
    plot(mean_col, mean_row, 'ob');
    hold on;
    plot([all_center(m,2), mean_col], [all_center(m,1), mean_row], '-b');
    textString = sprintf('(%d, %d)', all_center(m,1), all_center(m,2));
    text(all_center(m,2),all_center(m,1), textString, 'FontSize', 7); 
    count2=count2+1;
end
sgtitle('Spatial map shown for all 18 motor unit with Barycenter(red star) and Mean center(circle)')

sum = 0;
for i=1:18
    dist = (all_center(i,1)-mean_row).^2 + (all_center(i,2)-mean_col).^2;
    sum = sum + dist;
end
stdist = sqrt(sum/18);

function rms = compute_rms(x)
    s = 0;
    for i=1:length(x)
        s = s + x(1,i).^2;
    end
    rms = sqrt(1/length(x).*(s));
end

