function p_success = simulate(pars, male_type, synchrony)
% male_type: 0 for non-learner, 1 for learner; sorted by rank
% Output is success rate (ndays by nmales)

ndays     = pars.ndays;
padding   = pars.padding;

mmt       = getmeasurements(pars, synchrony);
choices   = getchoices_overdays(pars, mmt, male_type);
p_success = getpaternity(pars, mmt, choices);
p_success = p_success(1 + padding : ndays + padding,:); % remove before- and after-padding