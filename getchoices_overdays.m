function choices = getchoices_overdays(pars, mmt, male_type)
% Gets the sets of choices across days for all males

nmales   = pars.nmales;
simtime  = pars.simtime;

choices = NaN(simtime, nmales);
for T = 1:simtime
    dec_nonlearner      = getdecision_nonlearner(mmt, T);
    ranking_nonlearner  = dec_nonlearner.ranking;
    
    dec_learner         = getdecision_learner(pars, mmt, T);
    ranking_learner     = dec_learner.ranking;
        
    choices(T,:)        = getchoices_perday(ranking_nonlearner, ranking_learner, male_type);
end
