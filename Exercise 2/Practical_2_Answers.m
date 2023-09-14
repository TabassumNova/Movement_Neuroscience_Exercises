clearvars, clc, close all

load('Exercise2.mat','SIG','MUPulses','fsamp','IED')

% Exercise 1

%% STA
win_size = 0.015; %define window size
STA_window = round(win_size*fsamp); %calculates size of STA window

for MUnum = 1:size(MUPulses,2)
    for row = 1:size(SIG,1)
        for col = 1:size(SIG,2)
            if ~isempty(SIG{row,col})
                for spks = 1:size(MUPulses{MUnum},2)
                    if MUPulses{MUnum}(spks)+STA_window < length(SIG{row,col}) && MUPulses{MUnum}(spks)-STA_window>=1 %check if window is inside length of SIG
                        temp_STA(spks,:) = SIG{row,col}(MUPulses{MUnum}(spks)-STA_window:MUPulses{MUnum}(spks)+STA_window); %select time window
                    end
                end

                STA_mean{MUnum}{row,col} = nanmean(temp_STA,1); %average all time windows (all spikes) of 1MU,1 EMG channel (MUAP)
       
                STA_rms{MUnum}(row,col) = rms(nanmean(temp_STA,1));%calculate rms value of the MUAP
          
            end
        end
    end
end

%% Plot
for MUnum = 1:size(MUPulses,2)
    figure
    %figure('units','normalized','outerposition',[0 0 1 1])
    i = 1;
    for EMGrow = 1:size(SIG,1)
        for EMGcol = 1:size(SIG,2)
            Ax(i) = subplot(13,5,i);
            plot(STA_mean{MUnum}{EMGrow,EMGcol},'color','k')
            %axis off;
            %box off;
            hold on
            %set(Ax(i),'YLim',[-0.2 0.2])
            i = i+1;
        end
    end
    hold off
end

%% Exercise 2
close all

for MUnum = 1:size(MUPulses,2)
    for EMGrow = 1:size(SIG,1)
        for EMGcol = 1:size(SIG,2)
            MUAPsRMS{MUnum}(EMGrow,EMGcol) = rms(STA_mean{MUnum}{EMGrow,EMGcol}); %obtain a rms value representing the AP of the channel
        end
    end
    
    MU_img{MUnum} = MUAPsRMS{MUnum};
    %MU_img{MUnum} = fillmissing(MUAPsRMS{MUnum},'nearest'); %filling missing values
    MU_img{MUnum} = imresize(MU_img{MUnum}, [(size(SIG,1)-1)*IED,(size(SIG,2)-1)*IED],'nearest');% Correcting scale according to interelectrode distance
    
    %plot
    figure
    imagesc(MU_img{MUnum})
    colorbar
end

%% 2b

close all

%solution presented here https://www.mathworks.com/help/images/measuring-regions-in-grayscale-images.html
%other option https://blogs.mathworks.com/steve/2007/08/31/intensity-weighted-centroids/

for MUnum = 1:(length(MUPulses))
    I{MUnum} = mat2gray(MU_img{MUnum}); %generating grayscale image for each MU
    %BW{MUnum} = I{MUnum} > 0.8; %selecting high activity region
    %figure;imshow(BW{MUnum},'InitialMagnification',800)
    %figure;imshow(I{MUnum},'InitialMagnification',800)
    %colorbar
    
    %s = regionprops(BW{MUnum},I{MUnum},{'WeightedCentroid'});
    s = regionprops(true(size(I{MUnum})),I{MUnum},{'WeightedCentroid'});
    regionwcentroids = cat(1,s.WeightedCentroid);
    numObj = numel(s);
    for k = 1 : numObj
        rwcentroids{MUnum}{k,1} = [s(k).WeightedCentroid(1), s(k).WeightedCentroid(2)]; %saving ccentroid coordinates
    end
    
    %plot
    figure
    imagesc(I{MUnum})
    colorbar
    hold on
    for k = 1 : numObj
        plot(s(k).WeightedCentroid(1), s(k).WeightedCentroid(2), 'k*')
    end
    title(['MUnum = ' num2str(MUnum)])
    hold off
end
%% Exercise 3
close all

rw = cell2mat(vertcat(rwcentroids{:}));%getting values as a matrix
rwmean = mean(rw,1); %Mean center
rw_stdist = rms(pdist2(rw,rwmean));%Standard distance

%plot
radius = rw_stdist;
th = 0:pi/50:2*pi;
xunit = radius * cos(th) + mean(rw(:,1));
yunit = radius * sin(th) + mean(rw(:,2));
scatter(rw(:,1),rw(:,2),70,'k*')
hold on
scatter(mean(rw(:,1)),mean(rw(:,2)),70,'red','filled')
h = plot(xunit, yunit);
xlabel('(mm)'); ylabel('(mm)');



