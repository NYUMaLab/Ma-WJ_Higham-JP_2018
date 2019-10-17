function mmt = getmeasurements(pars, synchrony)
% Computes measurements X of intensity for all females. 
% We assume that noise is female-specific so the same for all males.
% Measurements are over the whole cycle. If a male observes only part of the
% cycle, a subset of X will be selected later (in inference.m)
% If synchrony = 1, then ovulation times are correlated

nfemales = pars.nfemales;
ndays    = pars.ndays;
fertile  = pars.fertile;
simtime  = pars.simtime;
omega    = pars.omega;
mu_sbar  = pars.mu_sbar;
sig_sbar = pars.sig_sbar;
mu_ds    = pars.mu_ds;
sig_ds   = pars.sig_ds;
sig      = pars.sig;

% Intensity cycles of all females; truetau is ovulation time
if synchrony == 0
    truetau  = randi(ndays, [1, nfemales]);
else
    mu_tau   = ndays/2 + fertile - 1; % include padding
    sig_tau  = 3;
    truetau  = round(randn(1, nfemales) * sig_tau) + mu_tau;
end
sbar     = mu_sbar + randn(1, nfemales) * sig_sbar; % time-averaged intensity intensity
ds       = mu_ds   + randn(1, nfemales) * sig_ds;   % amplitude of intensity fluctuations

t = 1:simtime;
s = NaN(simtime, nfemales);
for female_ind = 1:nfemales
    s(:,female_ind) = sbar(female_ind) - ds(female_ind) * cos(omega*(t-truetau(female_ind)));
end

% Measurements of all females (shared by all males)
X = s + randn(simtime, nfemales) * sig;

mmt.s       = s;
mmt.X       = X;
mmt.truetau = truetau;