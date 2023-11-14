# Overview
This repository contains the data and code needed to reproduce the results from the paper
"Risk and loss aversion and attitude to COVID and vaccines in anxious individuals" by
by Filippo Ferrari, Jesse Alexander and Peggy Seriès (2023).


# Requirements
- JASP version 0.17.0
- R version 3.6.3
- hBayesDM version 1.2.1
- Stan version 2.21.7
- HDDM version 0.8.0 (and python 3.6 for it)
  

# Data
- `data_anx_gad7_prior.csv` contains the individual demographic and fitted parameters for the data split according to a GAD-7 score median split of the data.
- `data_anx_gad7_prior_hddm.csv` is the same as`data_anx_gad7_prior.csv` but with the HDDMs parameter estimates from the `atvz` hddm model included.
- `data_single_prior.csv` contains the individual demographic and fitted parameters for the data fitted using a single prior encompassing all participants.
- `hbayesdm_data` contains the individual choice data processed to be used by hBayesDm. 


# JASP
The JASP file contains the entire statistical analysis reported in the paper.
`data_anx_gad7_prior_hddm.jasp` contains the statistical analysis of the HDDMs parameter estimates.


# R
The `fit_all.r` script fits all hBayesDm models used in the paper.
It reports MCMC fitting checks, models comparison and reproduces fig.2 in the paper.  


# HDDMs
The `fit_all.py` script fits all the HDDMS models used in the paper.
The `analysis_` and `winning_model_atvz` notebooks contain the analysis on the HDDMs parameter estimates. 