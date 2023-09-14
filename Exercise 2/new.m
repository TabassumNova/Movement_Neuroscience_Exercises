clc;
close all;

file = load('Exercise2.mat');
mupulse1 = file.MUPulses{1, 10};
sig = file.SIG;
cell_row = size(sig, 1);
cell_col = size(sig, 2);
total_cell = cell_row*cell_col;
ref_sig = file.ref_signal;
x_axis = zeros(1,length(ref_sig));
time_limit = length(sig{1,1})/file.fsamp;
time = linspace(0,time_limit,length(sig{1,1}));

for i=1:length(mupulse1)
    x = mupulse1(1,i);
    m = 0;
    for r=1:cell_row
        for c=1:cell_col
            m = m + sig{r,c}(1,x);
%             rms_matrix(r,c) = compute_rms(sig{r,c});
        end 
    end
    m = m/total_cell;
%     m = sig1(1,x);
    time = 15/2;
    sample = floor(file.fsamp * (time/1000));
%     sig1(1,x-sample:x+sample) = m;
    x_axis(1,x-sample:x+sample) = m;
%     ref_sig(1,x-sample:x+sample) = m;
%     sig1(1,x-15:x+15)
end
% 
% figure(1)
% plot(sig{12,5});
figure(2)
plot(time,x_axis);
xlabel('samples')
ylabel('average spike')
rms_matrix = [];
for r=1:cell_row
    for c=1:cell_col
        rms_matrix(r,c) = compute_rms(sig{r,c});
    end 
end
figure(3)
imagesc(rms_matrix);
rms_matrix
function rms = compute_rms(x)
    s = 0;
    for i=1:length(x)
        s = s + x(1,i).^2;
    end
    rms = sqrt(1/length(x).*(s));
end
