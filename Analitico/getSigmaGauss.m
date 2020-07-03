function [sigmaX, sigmaY] = getSigmaGauss(Dose, Dose_STD, x, y)
% Fit the distribution to gaussiana

%%
sigmaX = nan(1, 2);
sigmaY = nan(1, 2);
modelFun = @(b,x) b(1)*exp(-((x-b(2))/(b(3))).^2);
% %% Normalization (para qué?)
X = sum(Dose,2);
X_STD = rssq(Dose_STD,2);
% normX = 1/sum(X);
% X_norm = X.*normX;
% X_STD_norm = X_STD.*normX;
Y = sum(Dose,1);
Y_STD = rssq(Dose_STD,1);
% normY = 1/sum(Y);
% Y_norm = Y .* normY;
% Y_STD_norm = Y_STD .* normY;
    %%
% x fit
wx = (X_STD).^(-2);
maskX = ~isinf(wx);
Fx = fit(x(maskX)', X(maskX), 'gauss1', 'Weight', wx(maskX));
sigmaX(1)= Fx.c1/sqrt(2);
CI = confint(Fx);
sigmaX(2)= max(abs(CI(:,3) - Fx.c1));
    
% y fit
wy = (Y_STD).^(-2);
maskY = ~isinf(wy);
Fy = fit(y(maskY)', Y(maskY)', 'gauss1', 'Weight', wy(maskY));
sigmaY(1)= Fy.c1/sqrt(2);
CI = confint(Fy);
sigmaY(2)= max(abs(CI(:,3) - Fy.c1));   

