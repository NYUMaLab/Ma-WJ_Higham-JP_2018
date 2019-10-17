function chance = getchance(pars)
% Success rate of male who randomly picks a female on each day.
% Takes into account success sharing and boundary effects

nfemales = pars.nfemales;
nmales   = pars.nmales;
ndays    = pars.ndays;
fertile  = pars.fertile;
padding  = pars.padding;
taupdf   = pars.taupdf;

chance   = NaN(1, ndays + padding);
for T = 1:ndays + padding % includes before-padding, but not after-padding
    T
    upcoming  = T:T+fertile-1; % window after and including today that would give male a chance
    
    p_nmatingmales = binopdf(0:fertile-1,fertile-1,nmales/nfemales);
    success_given_fertile_given_nmatingmales = 1./(1:fertile);
    success_given_fertile = sum(p_nmatingmales .* success_given_fertile_given_nmatingmales);

    p_fertile = sum(taupdf(upcoming));
    chance(T) = p_fertile * success_given_fertile;
end
chance = chance(padding + 1 :end); % remove before-padding


