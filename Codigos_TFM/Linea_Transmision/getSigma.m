function [sigmaX, sigmaY] = getSigma(D, D_STD, x, y)
%% Returns sigma from a gaussian distribution

sigmaX = nan(1, 2);
sigmaY = nan(1, 2);

% x fit
X = sum(D,2);
X_STD = rssq(D_STD,2);
wx = (X_STD).^(-2);
maskX = ~isinf(wx);
Fx = fit(x(maskX)', X(maskX), 'gauss1', 'Weight', wx(maskX));
sigmaX(1)= Fx.c1/sqrt(2);
CI = confint(Fx);
sigmaX(2)= max(abs(CI(:,3) - Fx.c1))/sqrt(2);
    
% y fit
Y = sum(D,1);
Y_STD = rssq(D_STD,1);
wy = (Y_STD).^(-2);
maskY = ~isinf(wy);
Fy = fit(y(maskY)', Y(maskY)', 'gauss1', 'Weight', wy(maskY));
sigmaY(1)= Fy.c1/sqrt(2);
CI = confint(Fy);
sigmaY(2)= max(abs(CI(:,3) - Fy.c1))/sqrt(2);

end