The role of familiarity in signal-receiver interactions
Wei Ji Ma and James P. Higham

This is a theoretical paper and there are no data involved. Below are instructions for reproducing the simulation results.

First download all files to a computer on which Matlab is installed.

To reproduce the figures in the paper:
- Figure 1: plotFigure1.m
- All other figures: plotresults.m

To reproduce the simulation results on which the figures in the paper are based:
- Run MASTER.m
- In lines 3 to 6, specify the numbers of males, the number of simulation runs, the synchrony (off or on), and the numbers of females.
- Dependencies: MASTER.m calls simulate.m, which calls getmeasurements.m (generates noisy measurements), getchoices_overdays (which simulates the males’ decisions), and getpaternity.m (which tallies the paternity of the males in the colony)