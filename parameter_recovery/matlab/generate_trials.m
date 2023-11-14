% % Indifference points from Charpentier et al. 2017
% ip_anx = 5.06;
% ip_anx_std = 2.30;
% 
% ip_con = 3.74;
% ip_con_std = 2.37;
% 
% IP = ip_anx + ip_anx_std * randn();
% 
% 
function trials_list = generate_trials(ip_m, ip_g, n_blocks)
%-----------------------------------------
% Returns
% - index
% - losses (negative values)
% - gains
% - sure
% - ev 
%------ 

IProunded_m = round_ip(ip_m);
IProunded_g = round_ip(ip_g);

losses = [-2; -3; -4; -5; -6; -8; -10];
gains = 2 * (IProunded_m - 0.5 * losses);

all_gamble_pairs = [];

sure = [3;4;5;6;7];
gain_high = 2 * (IProunded_g + sure);

for n=1:n_blocks
    %compute gambles associations (all possible pairs of gains and losses)
    k=1;
    gamble_pairs=zeros(length(losses)*length(gains),4);
    for i=1:length(losses)
        for j=1:length(gains)
            gamble_pairs(k,1) = losses(i);
            gamble_pairs(k,2) = gains(j);
            gamble_pairs(k,3) = 0;
            gamble_pairs(k,4) = 0.5*losses(i) + 0.5*gains(j);
            k=k+1;
        end
    end

    k = 1;
    gamble_sure_asso=zeros(length(sure)*length(gain_high),4);
    for i=1:length(sure)
        for j=1:length(gain_high)
            gamble_sure_asso(k,1) = 0;
            gamble_sure_asso(k,2) = gain_high(j);
            gamble_sure_asso(k,3) = sure(i);
            gamble_sure_asso(k,4) = 0.5*gain_high(j) - sure(i);
            k=k+1;
        end
    end
    gamble_sure_asso = sortrows(gamble_sure_asso,4);

    all_gamble_pairs = [all_gamble_pairs; gamble_pairs; gamble_sure_asso];
end


trials_list = [randperm(length(all_gamble_pairs(:,1)))' all_gamble_pairs];
trials_list = sortrows(trials_list,1);

end

function IProunded_m = round_ip(ip)
    IPlr = floor(ip);
    %select closest rounded indifference point at 0.5 precision
    if ip - IPlr <= 0.25
        indiff_l = IPlr;
    elseif ip-IPlr > 0.25 && ip-IPlr < 0.75
        indiff_l = IPlr + 0.5;
    elseif ip-IPlr >=0.75
        indiff_l = IPlr +1;
    end
    if indiff_l < -0.5
        indiff_l = -0.5; %indifference point cannot be lower than 0.5 otherwise gains will become negative values
    end
    if indiff_l > 10
        indiff_l = 10; %indifference point cannot be higher than 10 otherwise gain will become higher than 30 and main task will crash
    end
    IProunded_m = indiff_l;
end