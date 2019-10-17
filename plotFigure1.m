clear; close all;
addpath(genpath('./'));
plotsettings
colormap(linspecer)

nfemales     = 10;
nmales       = 5;
synchrony    = 0;
pars         = getparameters(nfemales, nmales, synchrony);
ndays        = pars.ndays;
fertile      = pars.fertile;
padding      = pars.padding;
tauvec       = 1:ndays;

mmt          = getmeasurements(pars, synchrony);
truetau      = mmt.truetau;
s            = mmt.s;
s            = s(1:ndays,:);
X            = mmt.X;
X            = X(1 + padding: ndays + padding,:);

T = 10; dec_Bayes10 = getdecision_learner(pars, mmt, T);
T = 30; dec_Bayes30 = getdecision_learner(pars, mmt, T);


% Females intensity cycles
figure('Position', [100, 100, 1000, 800])
subplot(2,2,1); hold on;
for female_ind = 1:nfemales
    
    plot(1:ndays,s(:,female_ind),'Color', lineStyles(female_ind,:));
    plot([truetau(female_ind) truetau(female_ind)], [-4, 4], '--', 'Color', lineStyles(female_ind,:));
end
ylim([-4 4])
xlabel('Day');
ylabel('Noiseless signal (a.u.)');
text(-5, 4.5, 'A')
%title('True cycles')

% Intensity measurements made by male
subplot(2,2,2); hold on;
for female_ind = 1:nfemales
    plot(1:pars.ndays,X(:, female_ind),'Color', lineStyles(female_ind,:))
    plot([truetau(female_ind) truetau(female_ind)], [-4, 4], '--', 'Color', lineStyles(female_ind,:));
end
ylim([-4 4])
xlabel('Day');
ylabel('Measurement (a.u.)');
text(-5, 4.5, 'B')
%title('Measurements')

% Posteriors over ovulation time
subplot(2,2,3); hold on;
for female_ind = 1:nfemales
    plot(tauvec, dec_Bayes10.posterior(:, female_ind),'Color', lineStyles(female_ind,:))
    plot([truetau(female_ind) truetau(female_ind)], [-4, 4], '--', 'Color', lineStyles(female_ind,:));
end
ylim([0 1])
xlabel('Hypothesized ovulation day');
ylabel('Posterior probability');
text(-5, 1.1, 'C')
%title('Posteriors after 10 days of observation')

subplot(2,2,4); hold on;
for female_ind = 1:nfemales
    plot(tauvec, dec_Bayes30.posterior(:, female_ind),'Color', lineStyles(female_ind,:))
    plot([truetau(female_ind) truetau(female_ind)], [-4, 4], '--', 'Color', lineStyles(female_ind,:));
end
ylim([0 1])
xlabel('Hypothesized ovulation day');
ylabel('Posterior probability');
text(-5, 1.1, 'D')
%title('Posteriors after 30 days of observation')

printfigure('Fig1')


