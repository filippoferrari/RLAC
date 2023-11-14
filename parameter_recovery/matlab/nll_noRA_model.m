      % P is a "parameter" matrix, representing experimental design (gambles).  
      % rows are trials, column 1 is the value of the sure option (always 0), 
      % column 2 is the value of the potential gain,
      % column 3 is the value of the potential loss, 
      % column 4 is the binary choice variable: y value (1 if gamble
      % accepted, 0 if gamble rejected).

      
function f = nll_noRA_model(x,P)
%       f = 0;
Pg = zeros(length(P),1);

%sum log likelihood for each observation (trial)
for i=1:1:length(P)
    
    %xb is the "index" of the binary choice model, eg: expected
    %utility
    u_sure = P(i,1);
    u_gamble = .5*P(i,2) - 0.5*x(2)*P(i,3);
    xb = x(1)*(u_gamble-u_sure); 
    %x(1) is mu, x(2) is lambda
    
    if xb<-709
        xb=-709;
    end
    if xb>36
        xb=36;
    end
    
    %if choice value is 1, use one part of likelihood contribution.
    if(P(i,4)==1)
        Pg(i) = (1+exp(-1*xb))^-1;                  
    %if choice value is 0, use other part of likelihood contribution    
    elseif(P(i,4)==0)
        Pg(i) = 1-(1+exp(-1*xb))^-1;          
    end

end
Pg(Pg == 0) = [];
f = -sum(log(Pg)); %negative value of loglikelihood
          

