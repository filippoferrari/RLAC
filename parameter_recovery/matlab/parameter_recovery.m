% Optimisation settings
opts = [];
% Change these for 2 blocks (144 trials), 3 blocks (222 trials), 4 blocks (296 trials)
opts.n_blocks = 2;
% Model to use to compute NLL [nll_all_params_model, nll_noLA_model, nll_noRA_model]
opts.model = @nll_all_params_model;
opts.options = optimoptions(@fmincon,'Display','none','MaxIterations',400);
opts.lb = [0.001 0.001 0.001];
opts.ub = [Inf Inf Inf];
opts.n_sims = 100;
opts.n_par_sim = 10;
opts.n_par = 3;




% Parameters from Charpentier et al. 2017
mu_anx = 5.119;
mu_anx_std = 4.124;

mu_con = 3.857;
mu_con_std = 4.502;

lambd_anx = 2.013;
lambd_anx_std = 0.494;

lambd_con = 2.067;
lambd_con_std = 0.752;

rho_anx = 0.564;
rho_anx_std = 0.313;

rho_con = 0.875;
rho_con_std = 0.537;

low_ip_m = 2;
high_ip_m = 8;
low_ip_g = 1;
high_ip_g = 4;
ip_std = 2;


% Initial guesses
lambda_guess = 2;
rho_guess = 0.75;
mu_guess = 4;



low_anx_params = [lambd_anx, rho_anx, mu_anx, low_ip_m, low_ip_g];
low_anx_std = [lambd_anx_std, rho_anx_std, mu_anx_std, ip_std];

high_anx_params = [lambd_anx, rho_anx, mu_anx, high_ip_m, high_ip_g];
high_anx_std = [lambd_anx_std, rho_anx_std, mu_anx_std, ip_std];

low_con_params = [lambd_con, rho_con, mu_con, low_ip_m, low_ip_g];
low_con_std = [lambd_con_std, rho_con_std, mu_con_std, ip_std, ];

high_con_params = [lambd_con, rho_con, mu_con, high_ip_m, high_ip_g];
high_con_std = [lambd_con_std, rho_con_std, mu_con_std, ip_std];


[sim_anx_low_params, rec_anx_low_params] = run_recovery(low_anx_params, low_anx_std, opts);
[sim_anx_high_params, rec_anx_high_params] = run_recovery(high_anx_params, high_anx_std, opts);
[sim_con_low_params, rec_con_low_params] = run_recovery(low_con_params, low_con_std, opts);
[sim_con_high_params, rec_con_high_params] = run_recovery(high_con_params, high_con_std, opts);

display("Pearson");
correlations(sim_anx_low_params, rec_anx_low_params);
correlations(sim_anx_high_params, rec_anx_high_params);
correlations(sim_con_low_params, rec_con_low_params);
correlations(sim_con_high_params, rec_con_high_params);

display("Spearman");
[h,p] = corr(sim_anx_low_params(:,1:3), rec_anx_low_params(:,1:3), 'Type', 'Spearman')
[h,p] = corr(sim_anx_high_params(:,1:3), rec_anx_high_params(:,1:3), 'Type', 'Spearman')
[h,p] = corr(sim_con_low_params(:,1:3), rec_con_low_params(:,1:3), 'Type', 'Spearman')
[h,p] = corr(sim_con_high_params(:,1:3), rec_con_high_params(:,1:3), 'Type', 'Spearman')


[h, p] = ttest(sim_anx_low_params(:,1:3), rec_anx_low_params(:,1:3))
[h, p] = ttest(sim_anx_high_params(:,1:3), rec_anx_high_params(:,1:3))
[h, p] = ttest(sim_con_low_params(:,1:3), rec_con_low_params(:,1:3))
[h, p] = ttest(sim_con_high_params(:,1:3), rec_con_high_params(:,1:3))

figure; 
scatter(sim_anx_low_params(:,1:3), rec_anx_low_params(:,1:3)); 
ylim([0,20]);
legend('lambda', 'rho', 'mu');
title('anx params - low ip')

figure; 
scatter(sim_anx_high_params(:,1:3), rec_anx_high_params(:,1:3)); 
ylim([0,20]);
legend('lambda', 'rho', 'mu');
title('anx params - high ip')

figure; 
scatter(sim_con_low_params(:,1:3), rec_con_low_params(:,1:3)); 
ylim([0,20]);
legend('lambda', 'rho', 'mu');
title('control params - low ip')

figure; 
scatter(sim_con_high_params(:,1:3), rec_con_high_params(:,1:3)); 
ylim([0,20]);
legend('lambda', 'rho', 'mu');
title('control params - high ip')

fit_results.sim_anx_low_params = sim_anx_low_params;
fit_results.sim_anx_high_params = sim_anx_high_params;
fit_results.sim_con_low_params = sim_con_low_params;
fit_results.sim_con_high_params = sim_con_high_params;

fit_results.rec_anx_low_params = rec_anx_low_params;
fit_results.rec_anx_high_params = rec_anx_high_params;
fit_results.rec_con_low_params = rec_con_low_params;
fit_results.rec_con_high_params = rec_con_high_params;

save('matlab_recovery.mat','fit_results');

function [sim_params, rec_params] = run_recovery(params, stds, opts)
    sim_params = [];
    rec_params = [];

    for n=1:opts.n_sims
        lambd = abs(params(1) + stds(1) * randn());
        rho = abs(params(2) + stds(2) * randn());
        mu = abs(params(3) + stds(3) * randn());

        ip_m = abs(params(4) + stds(4) * randn());
        ip_g = abs(params(5) + stds(4) * randn());

        sim_params(n,:) = [lambd rho mu ip_m ip_g];

        trials_list = generate_trials(ip_m, ip_g, opts.n_blocks);
        % generate_trials return negative losses
        losses = trials_list(:,2);
        gains = trials_list(:,3);
        sure = trials_list(:,4);

        data = [sure gains losses];

        p_gen = generate_choices(sim_params(n,1:3), data);
        sim_choices = p_gen(:,4);
        
        data = [sure gains losses sim_choices];
        
        params_rand = [];
        for i_rand=1:opts.n_par_sim
            % select random value within bounds
            % here x0 is [mu, lambda, rho]
            x0 = [3*rand() 2*rand()+1 rand()*8/10+0.2];
            [paramtracker, lltracker, ex] = fmincon(opts.model,[x0],[],[],[],[],opts.lb,opts.ub,[],opts.options,data);
            params_rand = [params_rand; paramtracker lltracker ex];
        end
        % Check if optimisation was successfull 
        bad_fit = params_rand(:,opts.n_par+2)<=0;
        if sum(bad_fit) < opts.n_par_sim
            params_rand(bad_fit,:)=[];
        end
        % Sort by neg log likelihood values
        [~,ids] = sort(params_rand(:,opts.n_par+1));
        best_params = params_rand(ids(1),:);
    
        % we want them as lambda, rho, mu
        rec_params(n,:) = [best_params(:,2) best_params(:,3) best_params(:,1)];
    end

end
