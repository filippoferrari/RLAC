function Pgen = generate_choices(x,P)

Pg      = NaN(length(P),1);
Ugamble = NaN(length(P),1);
Usure   = NaN(length(P),1);
pred_ch = NaN(length(P),1);
ll      = NaN(length(P),1);
corr    = NaN(length(P),1);
ll_S    = NaN(length(P),1);

lambda = x(1);
rho = x(2);
mu = x(3);
%disp("FUNCTION ACTIVATED")
%sum log likelihood for each observation (trial)
for i=1:length(P)
    safe = P(i,1);
    gain = P(i,2);
    loss = P(i,3);
    left = 0.5 * (gain.^rho);
    right = 0.5 * lambda * (abs(loss).^rho);
    Ugamble(i) = left - right;
    Usure(i) = safe.^rho;
    xb = mu*(Ugamble(i) - Usure(i));
    %x(1) is lambda, x(2) is rho, and x(3) is mu
    
    

    if xb<-709
      xb=-709;
    end
    if xb>36
      xb=36;
    end

    Pg(i) = (1+exp(-xb))^-1;
%     power = -1 * xb;
% 
%     Pg(i) = 1 / (1 + (exp(1).^power));

    %Pg(i) = (1+exp(-1*xb))^-1;
    
    n=rand();
    %disp("n: " + n + " Pg: " + Pg(i));
    if n<Pg(i)
        
        pred_ch(i) = 1; %predicted choice is gamble   
        ll(i) = Pg(i); %loglikelihood
    else
        pred_ch(i) = 0; %predicted choice is right
        ll(i) = 1-Pg(i); %loglikelihood
    end 
    if pred_ch(i) == P(i,1) %if predicted choice is subject's choice
        corr(i) = 1;
    else
        corr(i) = 0;
    end
    if P(i,1)==0 %calculate likelihood of predicting subject choice
        ll_S(i) = Pg(i);
    elseif P(i,1)==1
        ll_S(i) = 1-Pg(i);
    end

end
Pgen = [Ugamble Usure Pg pred_ch ll corr ll_S];
      