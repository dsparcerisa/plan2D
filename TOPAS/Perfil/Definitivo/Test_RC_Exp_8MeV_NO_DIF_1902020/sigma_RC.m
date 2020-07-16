function [sigmaX, sigmaY] = sigma_RC(Dose, Dose_STD, x, y)

%%
sigmaX = nan(1, 2);
sigmaY = nan(1, 2);



X = sum(Dose,2);
X_STD = rssq(Dose_STD,2);
Y = sum(Dose,1);
Y_STD = rssq(Dose_STD,1);

    %%
% x fit
wx = (X_STD).^(-2);
maskX = ~isinf(wx);
Fx = fit(x(maskX)', X(maskX), 'gauss1', 'Weight', wx(maskX));
sigmaX(1)= Fx.c1/sqrt(2);
CI = confint(Fx);
sigmaX(2)= max(abs(CI(:,3) - Fx.c1))/sqrt(2);
    
% y fit
wy = (Y_STD).^(-2);
maskY = ~isinf(wy);
Fy = fit(y(maskY)', Y(maskY)', 'gauss1', 'Weight', wy(maskY));
sigmaY(1)= Fy.c1/sqrt(2);
CI = confint(Fy);
sigmaY(2)= max(abs(CI(:,3) - Fy.c1))/sqrt(2);