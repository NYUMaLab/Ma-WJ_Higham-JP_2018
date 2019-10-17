clear; close all;
addpath(genpath('./'));
plotsettings;
colormap(linspecer);

synchrony = 1;
nfemalesvec = [5 10 15];


%% FIGURE 1: Success rate
panelheight     = 0.31;
subpanelheight  = 0.14;

figure('position', [500, 500, 1200, 1200]); hold on;
for j = 1:length(nfemalesvec)
    filename = strcat('results_synchrony', num2str(synchrony), '_nfemales', num2str(nfemalesvec(j)));
    load(filename)
    
    for i = 1:2*(nmales + 1)
        if mod(i,nmales+1) == 1 % All non-learners (except for one), plot at top
            subplot(6,nmales + 1, (j-1)*(2*(nmales + 1)) + i,'pos', [0.15 + mod(i-1,nmales + 1) * 0.125, 1.165 - panelheight * j - subpanelheight*floor((i-1)/(nmales+1)),  0.1, 0.10]);
        else % All learners (except for one), plot at bottom
            subplot(6,nmales + 1, (j-1)*(2*(nmales + 1)) + i,'pos', [0.16 + mod(i-1,nmales + 1) * 0.125, 1.165 - panelheight * j - subpanelheight*floor((i-1)/(nmales+1)),  0.1, 0.1]);
        end
        switch i
            case  1; y = mean_p_all0; % All non-learners
            case  2; y = mean_p1_rank1; % All non-learners except for the rank-1 male
            case  3; y = mean_p1_rank2;
            case  4; y = mean_p1_rank3;
            case  5; y = mean_p1_rank4;
            case  6; y = mean_p1_rank5;
            case  7; y = mean_p_all1; % All learners
            case  8; y = mean_p0_rank1; % All learners except for the rank-1 male
            case  9; y = mean_p0_rank2;
            case 10; y = mean_p0_rank3;
            case 11; y = mean_p0_rank4;
            case 12; y = mean_p0_rank5;
        end
        hold on;
        plot(1:3:ndays, chance(1:3:ndays), 'k--');
        h = plot(1:ndays, y);
        set(gca,'xtick',[5:5:ndays])
        
        axis([0, ndays+1, 0, 0.6]);
        set(gca,'ytick',0:0.2:0.6);
        if i>nmales+1 & j ==3
            xlabel('Day')
            set(gca,'xticklabel',{'5','','15','','25',''})
        else
            set(gca,'xticklabel',[])
        end
        if mod(i,nmales+1)~=1            
            set(gca,'yticklabel',[])
        end
        if i==1
            h2 = ylabel('Siring probability');
            position = get(h2, 'pos');
            position(1) = position(1) - 1;
            position(2) = position(2) - 0.4;
            set(h2, 'pos', position)
        end
        set(gca,'TickDir','out','TickLength', 2*get(gca,'TickLength'));
        box off;
        
        if i == 1
            L = legend(h, strcat({'Rank'},{' '},num2str((1:nmales)')));
            set(L,'Position',[0.90 .46 .09 .12])
        end
    end
end
ax = axes('position',[0,0,1,1],'visible','off');
text(0.01,0.98,'A','FontSize',20);
text(0.01,0.67,'B','FontSize',20);
text(0.01,0.36,'C','FontSize',20);
for j=1:length(nfemalesvec)
    text(0.15, 0.973 - panelheight*(j-1), 'All non-learners');
    text(0.28, 0.973 - panelheight*(j-1), 'Learner among non-learners');
    text(0.15, 0.973 - panelheight*(j-1) - subpanelheight, 'All learners');
    text(0.28, 0.973 - panelheight*(j-1) - subpanelheight, 'Non-learner among learners');
    text(0.02, 0.84 - panelheight*(j-1), [num2str(nfemalesvec(j)),' females'])
end
figurename = strcat('synchrony', num2str(synchrony),'_success');
printfigure(figurename)

%% FIGURE 2: Cumulative benefits and costs for all males

figure('position', [500, 500, 1200, 1200]); hold on;
for j = 1:length(nfemalesvec)
    filename = strcat('results_synchrony', num2str(synchrony), '_nfemales', num2str(nfemalesvec(j)));
    load(filename)
    
    for i = 1:2*nmales
        subplot(6, nmales, (j-1)*2*nmales + i,'pos', [0.15 + mod(i-1,nmales) * 0.13, 1.165 - panelheight * j - subpanelheight*floor(i/(nmales+1)),  0.1, 0.1]);
        switch i
            case  1; y = mean_p1_rank1 - mean_p_all0;
            case  2; y = mean_p1_rank2 - mean_p_all0;
            case  3; y = mean_p1_rank3 - mean_p_all0;
            case  4; y = mean_p1_rank4 - mean_p_all0;
            case  5; y = mean_p1_rank5 - mean_p_all0;
            case  6; y = mean_p0_rank1 - mean_p_all1;
            case  7; y = mean_p0_rank2 - mean_p_all1;
            case  8; y = mean_p0_rank3 - mean_p_all1;
            case  9; y = mean_p0_rank4 - mean_p_all1;
            case 10; y = mean_p0_rank5 - mean_p_all1;
        end
        y = cumsum(y);
        hold on;
        plot([1 ndays], [0, 0], 'k--');
        h = plot(1:ndays, y);
        
        axis([0, ndays+1, -5, 5]);
        set(gca,'ytick',-4:2:4)
        if i>nmales & j ==3
            xlabel('Day')
            set(gca,'xticklabel',{'5','','15','','25',''})
        else
            set(gca,'xticklabel',[])
        end
        set(gca,'xtick',[5:5:ndays])
        if mod(i,nmales)~=1
            set(gca,'yticklabel','')
        end
        if i==1
            h2 = ylabel('Cumulative advantage');
            position = get(h2, 'pos');
            position(1) = position(1) - 2;
            position(2) = position(2) - 7;
            set(h2, 'pos', position)
        end
        set(gca,'TickDir','out','TickLength', 2*get(gca,'TickLength'));
        box off;
        if i == 1
            L = legend(h, strcat({'Rank'},{' '},num2str((1:nmales)')));
            set(L,'Position',[0.8 .46 .09 .12])
        end
    end
end
ax = axes('position',[0,0,1,1],'visible','off');
text(0.01,0.98,'A','FontSize',20);
text(0.01,0.67,'B','FontSize',20);
text(0.01,0.36,'C','FontSize',20);
for j=1:length(nfemalesvec)
    text(0.15, 0.973 - panelheight*(j-1), 'Learner among non-learners');
    text(0.15, 0.973 - panelheight*(j-1) - subpanelheight, 'Non-learner among learners');
    text(0.02, 0.84 - panelheight*(j-1), [num2str(nfemalesvec(j)),' females'])
end
figurename = strcat('synchrony', num2str(synchrony),'_cumulativeadvantage_full');
printfigure(figurename)

%% FIGURE 3: Cumulative benefits and costs for target male only
benefits = [
    mean_p1_rank1(:,1) - mean_p_all0(:,1), ...
    mean_p1_rank2(:,2) - mean_p_all0(:,2), ...
    mean_p1_rank3(:,3) - mean_p_all0(:,3), ...
    mean_p1_rank4(:,4) - mean_p_all0(:,4), ...
    mean_p1_rank5(:,5) - mean_p_all0(:,5)];

costs = -[
    mean_p0_rank1(:,1) - mean_p_all1(:,1), ...
    mean_p0_rank2(:,2) - mean_p_all1(:,2), ...
    mean_p0_rank3(:,3) - mean_p_all1(:,3), ...
    mean_p0_rank4(:,4) - mean_p_all1(:,4), ...
    mean_p0_rank5(:,5) - mean_p_all1(:,5)];

benefits = cumsum(benefits, 1);
costs = cumsum(costs, 1);

figure('position', [500, 500, 1000, 1200]); hold on;
for j = 1:length(nfemalesvec)
    filename = strcat('results_synchrony', num2str(synchrony), '_nfemales', num2str(nfemalesvec(j)));
    load(filename)
    
    subplot(3,2,(j-1)*2+1,'pos', [0.18 1.02 - panelheight * j  0.25 0.24]);
    plot(1:ndays, benefits); hold on;
    axis([0, ndays+1, 0, 5]);
    if j==3
        xlabel('Day')
    end
    set(gca,'xtick',[5:5:ndays])
    
    set(gca,'ytick',0:1:5)
    set(gca,'TickDir','out','TickLength', 2*get(gca,'TickLength'));
    if j==1
        title('Learner among non-learners')
    end
    h2 = ylabel('Cumulative advantage');
    position = get(h2, 'pos');
    position(1) = position(1) - 1;
    set(h2, 'pos', position)
    box off
    
    subplot(3,2,(j-1)*2+2,'pos', [0.49 1.02 - panelheight * j   0.25 0.24]);
    plot(1:ndays, -costs); hold on;
    axis([0, ndays+1, -5, 0]);
    if j==3
        xlabel('Day')
    end
    set(gca,'xtick',[5:5:ndays])
    set(gca,'ytick',-5:1:0)
    set(gca,'TickDir','out','TickLength', 2*get(gca,'TickLength'));
    if j==1
        title('Non-learner among learners')
    end
    box off;
    L = legend(strcat({'Rank'},{' '},num2str((1:nmales)')));
    set(L,'Position',[0.78 .46 .1 .12])
end
ax = axes('position',[0,0,1,1],'visible','off');
text(0.01,0.98,'A','FontSize',20);
text(0.01,0.66,'B','FontSize',20);
text(0.01,0.34,'C','FontSize',20);
for j=1:length(nfemalesvec)
    text(0.02, 0.84 - panelheight*(j-1), [num2str(nfemalesvec(j)),' females'])
end
figurename = strcat('synchrony', num2str(synchrony),'_cumulativeadvantage_simple');
printfigure(figurename)
