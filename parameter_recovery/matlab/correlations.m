function correlations(sim_params, rec_params)
    [lbcor, lb_p] = corrcoef(sim_params(:,1), rec_params(:,1));
    [rhocor, rho_p] = corrcoef(sim_params(:,2), rec_params(:,2));
    [mucor, mu_p] = corrcoef(sim_params(:,3), rec_params(:,3));
    disp("Lambda - r: " + lbcor(1,2) + " p: " + lb_p(1,2));
    disp("Rho - r: " + rhocor(1,2) + " p: " + rho_p(1,2));
    disp("Mu - r: " + mucor(1,2) + " p: " + mu_p(1,2));
end