# Overview
This repository contains the data and code needed to reproduce the results from the paper
"Risk and loss aversion and attitude to COVID and vaccines in anxious individuals" by
by Filippo Ferrari, Jesse Alexander and Peggy Seriès (2023).


# Requirements
- JASP version 0.17.0
- R version 3.6.3
- hBayesDM version 1.2.1
- Stan version 2.21.7


# Data
- `data_anx_gad7_prior.csv` contains the individual demographic and fitted parameters for the data split according to a GAD-7 score median split of the data.
- `data_single_prior.csv` contains the individual demographic and fitted parameters for the data fitted using a single prior encompassing all participants.
- `hbayesdm_data` contains the individual choice data processed to be used by hBayesDm. 


# JASP
The JASP file contains the entire statistical analysis reported in the paper.


# R
The `fit_all.r` script fits all hBayesDm models used in the paper.
It reports MCMC fitting checks, models comparison and reproduces fig.3 in the paper.  

