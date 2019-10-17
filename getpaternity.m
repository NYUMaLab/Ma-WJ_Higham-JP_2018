function n_success = getpaternity(pars, mmt, choices)
% Inputs:
% - truetau: females' true ovulation times
% - choices: index of female chosen, by day and by male
% Output: expected number of successful impregnations, by day and male
% Success is shared equally among the males who mate with the female during her fertile period

nfemales = pars.nfemales;
nmales   = pars.nmales;
ndays    = pars.ndays;
fertile  = pars.fertile;
simtime  = pars.simtime;
truetau  = mmt.truetau;

n_success = zeros(simtime, nmales);
for female_ind = 1:nfemales
    
    tau = truetau(female_ind); % between 1 and ndays
    newtau = tau;
    
    while newtau < simtime + fertile % since simtime > ndays, check for multiple ovulations
        days_fertile = max(1,newtau-fertile+1):min(simtime, newtau); % window in which female is fertile
        mask_fertile = zeros(simtime, nmales);
        mask_fertile(days_fertile,:) = 1;
        
        ind_success = find(mask_fertile == 1 & choices == female_ind);
        n_success(ind_success) = 1/length(ind_success);
        
        newtau = newtau + ndays;
    end
end
