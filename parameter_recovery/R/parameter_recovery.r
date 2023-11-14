library(hBayesDM)


# helper function
get_simulation_params <- function(data) {
  sim_params = data[c('subjID', 'rho', 'lambda', 'mu')]
  sim_params = sim_params[!duplicated(sim_params),]
}


correlations <- function(sim_params, fitted_params, method="spearman", digits=2) {
  print(paste("lambda: ", signif(cor(sim_params$lambda, fitted_params$allIndPars$lambda, method=method), digit=digits)))
  print(paste("rho: ", signif(cor(sim_params$rho, fitted_params$allIndPars$rho, method=method), digit=digits)))
  print(paste("mu: ", signif(cor(sim_params$mu, fitted_params$allIndPars$tau, method=method), digit=digits)))
}



# Load trials, 100 participants in each
# trials were generated using a matlab script
highip_highanx_2b_csv = read.csv('../data/par_rec_highip_highanx_2blocks_hbayesdm.csv')
highip_highanx_3b_csv = read.csv('../data/par_rec_highip_highanx_3blocks_hbayesdm.csv')
highip_highanx_4b_csv = read.csv('../data/par_rec_highip_highanx_4blocks_hbayesdm.csv')

lowip_highanx_2b_csv = read.csv('../data/par_rec_lowip_highanx_2blocks_hbayesdm.csv')
lowip_highanx_3b_csv = read.csv('../data/par_rec_lowip_highanx_3blocks_hbayesdm.csv')
lowip_highanx_4b_csv = read.csv('../data/par_rec_lowip_highanx_4blocks_hbayesdm.csv')

highip_lowanx_2b_csv = read.csv('../data/par_rec_highip_lowanx_2blocks_hbayesdm.csv')
highip_lowanx_3b_csv = read.csv('../data/par_rec_highip_lowanx_3blocks_hbayesdm.csv')
highip_lowanx_4b_csv = read.csv('../data/par_rec_highip_lowanx_4blocks_hbayesdm.csv')

lowip_lowanx_2b_csv = read.csv('../data/par_rec_lowip_lowanx_2blocks_hbayesdm.csv')
lowip_lowanx_3b_csv = read.csv('../data/par_rec_lowip_lowanx_3blocks_hbayesdm.csv')
lowip_lowanx_4b_csv = read.csv('../data/par_rec_lowip_lowanx_4blocks_hbayesdm.csv')



# Get simulations parameters
highip_highanx_2b_sim_params = get_simulation_params(highip_highanx_2b_csv)
highip_highanx_3b_sim_params = get_simulation_params(highip_highanx_3b_csv)
highip_highanx_4b_sim_params = get_simulation_params(highip_highanx_4b_csv)

lowip_highanx_2b_sim_params = get_simulation_params(lowip_highanx_2b_csv)
lowip_highanx_3b_sim_params = get_simulation_params(lowip_highanx_3b_csv)
lowip_highanx_4b_sim_params = get_simulation_params(lowip_highanx_4b_csv)

highip_lowanx_2b_sim_params = get_simulation_params(highip_lowanx_2b_csv)
highip_lowanx_3b_sim_params = get_simulation_params(highip_lowanx_3b_csv)
highip_lowanx_4b_sim_params = get_simulation_params(highip_lowanx_4b_csv)

lowip_lowanx_2b_sim_params = get_simulation_params(lowip_lowanx_2b_csv)
lowip_lowanx_3b_sim_params = get_simulation_params(lowip_lowanx_3b_csv)
lowip_lowanx_4b_sim_params = get_simulation_params(lowip_lowanx_4b_csv)



# Fit models
highip_highanx_2b = ra_prospect(data=highip_highanx_2b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
highip_highanx_3b = ra_prospect(data=highip_highanx_3b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
highip_highanx_4b = ra_prospect(data=highip_highanx_4b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

lowip_highanx_2b = ra_prospect(data=lowip_highanx_2b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
lowip_highanx_3b = ra_prospect(data=lowip_highanx_3b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
lowip_highanx_4b = ra_prospect(data=lowip_highanx_4b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

highip_lowanx_2b = ra_prospect(data=highip_lowanx_2b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
highip_lowanx_3b = ra_prospect(data=highip_lowanx_3b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
highip_lowanx_4b = ra_prospect(data=highip_lowanx_4b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

lowip_lowanx_2b = ra_prospect(data=lowip_lowanx_2b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
lowip_lowanx_3b = ra_prospect(data=lowip_lowanx_3b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)
lowip_lowanx_4b = ra_prospect(data=lowip_lowanx_4b_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)



# Report correlations
correlations(highip_highanx_2b_sim_params, highip_highanx_2b)
correlations(highip_highanx_3b_sim_params, highip_highanx_3b)
correlations(highip_highanx_4b_sim_params, highip_highanx_4b)

correlations(lowip_highanx_2b_sim_params, lowip_highanx_2b)
correlations(lowip_highanx_3b_sim_params, lowip_highanx_3b)
correlations(lowip_highanx_4b_sim_params, lowip_highanx_4b)

correlations(highip_lowanx_2b_sim_params, highip_lowanx_2b)
correlations(highip_lowanx_3b_sim_params, highip_lowanx_3b)
correlations(highip_lowanx_4b_sim_params, highip_lowanx_4b)

correlations(lowip_lowanx_2b_sim_params, lowip_lowanx_2b)
correlations(lowip_lowanx_3b_sim_params, lowip_lowanx_3b)
correlations(lowip_lowanx_4b_sim_params, lowip_lowanx_4b)