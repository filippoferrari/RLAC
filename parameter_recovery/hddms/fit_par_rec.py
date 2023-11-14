import pandas as pd
import matplotlib.pyplot as plt
import kabuki
import hddm
print(hddm.__version__)

# For later convergence check
# import multiprocessing as mp





#############################################################################
##### Functions data
#############################################################################

def name_model(depends_on, suffix=''):
    if depends_on:
        return ''.join(depends_on.keys()) + suffix
    else:
        return 'none'


def fit_model(data, group, depends_on={}, n_chains=4, n_samples=4000, n_burn=1000, include=('a', 't', 'v', 'z'), suffix=''):
    # models = []
    for i in range(n_chains):
        name = f'{name_model(depends_on, suffix)}_{group}_{n_chains}c_{n_samples}s_{n_burn}b'
        print(name)
        m = hddm.HDDM(data, depends_on=depends_on, include=include)
        m.find_starting_values()
        m.sample(n_samples, burn=n_burn, dbname=f'{name}_{i}chain.db', db='pickle')
        m.save(f'{name}_{i}model')
    #     models.append(m)
    # return models





#############################################################################
##### Load data
#############################################################################

high_anx = hddm.load_csv('./data_hia.csv')
low_anx = hddm.load_csv('./data_loa.csv')
# print(f'# high anxiety: {high_anx["subjID"].nunique()}')
# print(f'# low anxiety: {low_anx["subjID"].nunique()}')


# preprocess for HDDM
# high_anx = high_anx.rename(columns={'subjID':'subj_idx', 'gamble':'response'})
# high_anx['rt'] = high_anx['rt'] / 1000
high_anx = hddm.utils.flip_errors(high_anx)


# low_anx = low_anx.rename(columns={'subjID':'subj_idx', 'gamble':'response'})
# low_anx['rt'] = low_anx['rt'] / 1000
low_anx = hddm.utils.flip_errors(low_anx)



print('data loaded')





#############################################################################
##### atvz
#############################################################################
fit_model(high_anx, group='hia', depends_on={'a':'trial_type', 't':'trial_type', 'v':'trial_type', 'z':'trial_type'}, 
          n_chains=4, n_samples=4000, n_burn=1000, suffix='_par_rec')

fit_model(low_anx, group='loa', depends_on={'a':'trial_type', 't':'trial_type', 'v':'trial_type', 'z':'trial_type'}, 
          n_chains=4, n_samples=4000, n_burn=1000, suffix='_par_rec')

print('fit atvz completed')

print('done')