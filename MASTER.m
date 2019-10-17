clear; close all; tic

nmales       = 5;
nruns        = 10000;
synchronyvec = [0 1];
nfemalesvec  = [5 10 15];

for i = 1:length(synchronyvec)
    synchrony = synchronyvec(i)
    
    for j = 1:length(nfemalesvec)
        nfemales = nfemalesvec(j)
        
        pars     = getparameters(nfemales, nmales, synchrony);
        ndays    = pars.ndays;
        
        [p_all0, p1_rank1, p1_rank2, p1_rank3, p1_rank4, p1_rank5] = deal(NaN(ndays, nmales, nruns));
        [p_all1, p0_rank1, p0_rank2, p0_rank3, p0_rank4, p0_rank5] = deal(NaN(ndays, nmales, nruns));
        
        chance = getchance(pars);
        
        for run = 1:nruns
            if mod(run,nruns/10)==0
                run
            end
            
            p_all0(:,:,run)    = simulate(pars, [0 0 0 0 0], synchrony);
            p1_rank1(:,:,run)  = simulate(pars, [1 0 0 0 0], synchrony);
            p1_rank2(:,:,run)  = simulate(pars, [0 1 0 0 0], synchrony);
            p1_rank3(:,:,run)  = simulate(pars, [0 0 1 0 0], synchrony);
            p1_rank4(:,:,run)  = simulate(pars, [0 0 0 1 0], synchrony);
            p1_rank5(:,:,run)  = simulate(pars, [0 0 0 0 1], synchrony);
            
            p_all1(:,:,run)    = simulate(pars, [1 1 1 1 1], synchrony);
            p0_rank1(:,:,run)  = simulate(pars, [0 1 1 1 1], synchrony);
            p0_rank2(:,:,run)  = simulate(pars, [1 0 1 1 1], synchrony);
            p0_rank3(:,:,run)  = simulate(pars, [1 1 0 1 1], synchrony);
            p0_rank4(:,:,run)  = simulate(pars, [1 1 1 0 1], synchrony);
            p0_rank5(:,:,run)  = simulate(pars, [1 1 1 1 0], synchrony);
        end
        
        mean_p_all0   = mean(p_all0, 3);
        mean_p1_rank1 = mean(p1_rank1, 3);
        mean_p1_rank2 = mean(p1_rank2, 3);
        mean_p1_rank3 = mean(p1_rank3, 3);
        mean_p1_rank4 = mean(p1_rank4, 3);
        mean_p1_rank5 = mean(p1_rank5, 3);
        
        mean_p_all1   = mean(p_all1, 3);
        mean_p0_rank1 = mean(p0_rank1, 3);
        mean_p0_rank2 = mean(p0_rank2, 3);
        mean_p0_rank3 = mean(p0_rank3, 3);
        mean_p0_rank4 = mean(p0_rank4, 3);
        mean_p0_rank5 = mean(p0_rank5, 3);
        
        filename = strcat('results_synchrony', num2str(synchrony), '_nfemales', num2str(nfemales));
        save(filename)
    end
end

toc