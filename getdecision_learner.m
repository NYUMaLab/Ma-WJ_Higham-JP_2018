function decision = getdecision_learner(pars, mmt, T)
% Decision of Bayesian male.
% Based on posterior distributions over ovulation day for all females.
% T is the current day

nfemales  = pars.nfemales;

ndays     = pars.ndays;
omega     = pars.omega;
fertile   = pars.fertile;

mu_sbar   = pars.mu_sbar;
sig_sbar  = pars.sig_sbar;
mu_ds     = pars.mu_ds;
sig_ds    = pars.sig_ds;
sig       = pars.sig;

X         = mmt.X;   % all measurements of all females
t         = 1:T;     % vector of all observation days (assumed all males start at day 1)

tauvec    = 1:ndays; % vector of all hypothesized ovulation days
posterior = NaN(length(tauvec), nfemales); % posteriors will go here

upcoming  = 1 + mod(T-1:T+fertile-2, ndays); % window after and including today that would give male a chance
prob_hit  = NaN(1, nfemales); % probability that ovulation will occur soon (size: window)

for female_ind = 1:nfemales
    x = X(1:T, female_ind);
    
    xbar = mean(x);
    a = 1/sig_sbar^2 + T/sig^2;
    b = mu_sbar/sig_sbar^2 + T*xbar/sig^2;
    
    logprotoposterior = NaN(1,length(tauvec));
    
    for tauind = 1:length(tauvec)
        tau_hyp = tauvec(tauind);
        
        c_t = cos(omega*(t-tau_hyp));
        cbar = mean(c_t);
        
        C = 1/sig_ds^2 + 1/sig^2 * sum(c_t.^2)-T^2*cbar^2/sig^4/a;
        D = mu_ds/sig_ds^2 - 1/sig^2 * x'* c_t' + T*cbar/sig^2*b/a;
        
        logprotoposterior(tauind) = 0.5 * log(C) + D.^2/2./C;
    end
    
    lpp_norm = logprotoposterior - max(logprotoposterior);
    posterior(:, female_ind) = exp(lpp_norm)/sum(exp(lpp_norm));
    prob_hit(female_ind) = sum(posterior(upcoming, female_ind));  
end

[~, ranking] = sort(prob_hit,'descend'); % females in decreasing order of desirability

decision.posterior = posterior;
decision.prob_hit  = prob_hit;
decision.ranking   = ranking;
