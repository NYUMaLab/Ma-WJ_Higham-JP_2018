{\rtf1\ansi\ansicpg1252\cocoartf1404\cocoasubrtf470
{\fonttbl\f0\fswiss\fcharset0 Helvetica;}
{\colortbl;\red255\green255\blue255;}
\margl1440\margr1440\vieww17600\viewh9420\viewkind0
\pard\tx720\tx1440\tx2160\tx2880\tx3600\tx4320\tx5040\tx5760\tx6480\tx7200\tx7920\tx8640\pardirnatural\partightenfactor0

\f0\b\fs24 \cf0 The role of familiarity in signal-receiver interactions\
Wei Ji Ma and James P. Higham\

\b0 \

\i This is a theoretical paper and there are no data involved. Below are instructions for reproducing the simulation results.
\i0 \
\
First download all files to a computer on which Matlab is installed.\
\

\b To reproduce the figures in the paper:\

\b0 - Figure 1: plotFigure1.m\
- All other figures: plotresults.m\
\

\b To reproduce the simulation results on which the figures in the paper are based:\

\b0 - Run MASTER.m\
- In lines 3 to 6, specify the numbers of males, the number of simulation runs, the synchrony (off or on), and the numbers of females.\
- Dependencies: MASTER.m calls simulate.m, which calls getmeasurements.m (generates noisy measurements), getchoices_overdays (which simulates the males\'92 decisions), and getpaternity.m (which tallies the paternity of the males in the colony)}