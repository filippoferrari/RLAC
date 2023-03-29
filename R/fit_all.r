library(hBayesDM)
library(patchwork)
library(ggplot2)



# Single prior
single_prior_csv = read.csv('../data/hbayesdm_data/single_prior.csv')
single_prior = ra_prospect(data=single_prior_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)



# Vaccination prior
vaxxed_prior_csv = read.csv('../data/hbayesdm_data/vaccination_split/vaxxed.csv')
vaxxed_prior = ra_prospect(data=vaxxed_prior_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

unvaxxed_prior_csv = read.csv('../data/hbayesdm_data/vaccination_split/unvaxxed.csv')
unvaxxed_prior = ra_prospect(data=unvaxxed_prior_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)



# GAD-7 median split prior

## anxiety split
gad7_high_anx_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_high_anxious.csv')
gad7_high_anx = ra_prospect(data=gad7_high_anx_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

gad7_low_anx_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_low_anxious.csv')
gad7_low_anx = ra_prospect(data=gad7_low_anx_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

## anxiety and vaccination split
gad7_high_anx_vax_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_high_anxious_vax.csv')
gad7_high_anx_vax = ra_prospect(data=gad7_high_anx_vax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

gad7_high_anx_unvax_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_high_anxious_unvax.csv')
gad7_high_anx_unvax = ra_prospect(data=gad7_high_anx_unvax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

gad7_low_anx_vax_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_low_anxious_vax.csv')
gad7_low_anx_vax = ra_prospect(data=gad7_low_anx_vax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

gad7_low_anx_unvax_csv = read.csv('../data/hbayesdm_data/gad7_median_split/gad7_median_low_anxious_unvax.csv')
gad7_low_anx_unvax = ra_prospect(data=gad7_low_anx_unvax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)




# Trait anxiety median split prior

## anxiety split
trait_anx_high_anx_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_high_anxious.csv')
trait_anx_high_anx = ra_prospect(data=trait_anx_high_anx_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

trait_anx_low_anx_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_low_anxious.csv')
trait_anx_low_anx = ra_prospect(data=trait_anx_low_anx_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

## anxiety and vaccination split
trait_high_anx_vax_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_high_anxious_vax.csv')
trait_high_anx_vax = ra_prospect(data=trait_high_anx_vax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

trait_high_anx_unvax_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_high_anxious_unvax.csv')
trait_high_anx_unvax = ra_prospect(data=trait_high_anx_unvax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

trait_low_anx_vax_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_low_anxious_vax.csv')
trait_low_anx_vax = ra_prospect(data=trait_low_anx_vax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)

trait_low_anx_unvax_csv = read.csv('../data/hbayesdm_data/trait_anx_median_split/trait_anx_median_low_anxious_unvax.csv')
trait_low_anx_unvax = ra_prospect(data=trait_low_anx_unvax_csv, niter=8000, nwarmup=2000, nchain=4, ncore=4)



# Fitting checks
plot(single_prior, type="trace", inc_warmup=T)
plot(vaxxed_prior, type="trace", inc_warmup=T)
plot(unvaxxed_prior, type="trace", inc_warmup=T)
plot(gad7_high_anx, type="trace", inc_warmup=T)
plot(gad7_low_anx, type="trace", inc_warmup=T)
plot(gad7_high_anx_vax, type="trace", inc_warmup=T)
plot(gad7_high_anx_unvax, type="trace", inc_warmup=T)
plot(gad7_low_anx_vax, type="trace", inc_warmup=T)
plot(gad7_low_anx_unvax, type="trace", inc_warmup=T)
plot(trait_anx_high_anx, type="trace", inc_warmup=T)
plot(trait_anx_low_anx, type="trace", inc_warmup=T)
plot(trait_high_anx_vax, type="trace", inc_warmup=T)
plot(trait_high_anx_unvax, type="trace", inc_warmup=T)
plot(trait_low_anx_vax, type="trace", inc_warmup=T)
plot(trait_low_anx_unvax, type="trace", inc_warmup=T)

rhat(single_prior)
rhat(vaxxed_prior)
rhat(unvaxxed_prior)
rhat(gad7_high_anx)
rhat(gad7_low_anx)
rhat(gad7_high_anx_vax)
rhat(gad7_high_anx_unvax)
rhat(gad7_low_anx_vax)
rhat(gad7_low_anx_unvax)
rhat(trait_anx_high_anx)
rhat(trait_anx_low_anx)
rhat(trait_high_anx_vax)
rhat(trait_high_anx_unvax)
rhat(trait_low_anx_vax)
rhat(trait_low_anx_unvax)




# Analysis

## LOOIC comparisons

fits = printFit(single_prior, 
                vaxxed_prior, unvaxxed_prior,
                gad7_high_anx, gad7_low_anx,
                gad7_high_anx_vax, gad7_high_anx_unvax, gad7_low_anx_vax, gad7_low_anx_unvax,
                trait_anx_high_anx, trait_anx_low_anx,
                trait_high_anx_vax, trait_high_anx_unvax, trait_low_anx_vax, trait_low_anx_unvax)

single_prior_LOOIC = sum(fits[1,2])
vaxxed_prior_LOOIC = sum(fits[2:3,2])
gad7_split_LOOIC = sum(fits[4:5,2])
gad7_vax_split_LOOIC = sum(fits[6:9,2])
trait_split_LOOIC = sum(fits[10:11,2])
trait_vax_LOOIC = sum(fits[12:15,2])

LOOICtable <- matrix(c(single_prior_LOOIC, vaxxed_prior_LOOIC, gad7_split_LOOIC, gad7_vax_split_LOOIC, trait_split_LOOIC, trait_vax_LOOIC), ncol=1, byrow=TRUE)

rownames(LOOICtable)<-c("Single_Prior", "Vaxxed_Prior", "GAD7_Anxiety_Prior", "GAD7_Vaxxed_Prior", "Trait_Anxiety_Prior", "Trait_Vaxxed_Prior",)
colnames(LOOICtable)<-c("LOOIC")
LOOICtable




## GAD7 models differences in parameters
diff_gad7_anx_lambda = gad7_high_anx$parVals$mu_lambda - gad7_low_anx$parVals$mu_lambda
diff_gad7_anx_rho = gad7_high_anx$parVals$mu_rho - gad7_low_anx$parVals$mu_rho
diff_gad7_anx_mu = gad7_high_anx$parVals$mu_tau - gad7_low_anx$parVals$mu_tau

hdi_gad7_anx_lambda = HDIofMCMC(diff_gad7_anx_lambda)
hdi_gad7_anx_rho = HDIofMCMC(diff_gad7_anx_rho)
hdi_gad7_anx_mu = HDIofMCMC(diff_gad7_anx_mu)

p1 <- plotHDI(diff_gad7_anx_lambda, Title='lambda')
p2 <- plotHDI(diff_gad7_anx_rho, Title='rho')
p3 <- plotHDI(diff_gad7_anx_mu, Title='mu')

p4 <- p1+p2+p3  
ggsave(p4, filename = "hdi_parameters.pdf", height = 3, width = 10)