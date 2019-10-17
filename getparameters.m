function pars = getparameters(nfemales, nmales, synchrony)
% Nothing random in here. Everything stochastic goes into getmeasurements.m

% Parameters of the population
pars.nfemales    = nfemales;        % number of females
pars.nmales      = nmales;          % number of males

% Parameters related to the female cycles
pars.ndays       = 30;              % number of days in a cycle
pars.omega       = 2*pi/pars.ndays; % frequency of ovulation in radians
pars.fertile     = 4;               % number of fertile days in a month
pars.padding     = pars.fertile - 1; % padding to avoid edge effects
pars.simtime     = pars.ndays + 2*pars.padding; % padding to avoid edge effects

pars.mu_sbar     = 0;               % time-averaged intensity: mean across females
pars.sig_sbar    = 1;               % time-averaged intensity: std across females
pars.mu_ds       = -1;              % amplitude of intensity fluctuations: mean across females
pars.sig_ds      = 0.33;            % amplitude of intensity fluctuations: std across females
pars.sig         = 0.33;            % measurement noise (assumed same for all males)

% Intensity cycles of all females; truetau is ovulation time
if synchrony == 0
    taupdf   = ones(1,pars.ndays)/pars.ndays;
else
    mu_tau   = pars.ndays/2 + pars.padding; % include before-padding
    sig_tau  = 3;
    taupdf   = normpdf(1:pars.ndays, mu_tau, sig_tau);
end
pars.taupdf  = [taupdf taupdf]; % duplicate because simtime > ndays

