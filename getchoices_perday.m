function choices = getchoices_perday(ranking_nonlearner, ranking_learner, male_type)
% Computes which females males choose on a given day
% Inputs: ranking based on a naive strategy, ranking based on a Bayesian
% strategy, strategy by male

nmales = length(male_type);
choices = NaN(1, nmales);

for male_ind = 1:nmales % go through males in order of decreasing rank
    
    unavailable = choices(1:male_ind-1); % indices of females that higher-ranked males have already mated with today
    
    switch male_type(male_ind)
        case 0 % non-learner
            ranking_available = setdiff(ranking_nonlearner, unavailable, 'stable');
            choices(male_ind) = ranking_available(1);
        case 1 % learner
            ranking_available = setdiff(ranking_learner, unavailable, 'stable');
            choices(male_ind) = ranking_available(1);
    end
end


