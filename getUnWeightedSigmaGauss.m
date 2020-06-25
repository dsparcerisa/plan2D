function [sigmaX, sigmaY] = getUnWeightedSigmaGauss(Dose, x, y)
% Fit the distribution to gaussiana
%%

% Normalization
X = sum(Dose,1);
X_norm = X./sum(X);
Y = sum(Dose,2);
Y_norm = Y./sum(Y);

    
% x fit
Fx = fit(x', X_norm', 'gauss1');
sigmaX = Fx.c1/sqrt(2);

    
% y fit
Fy = fit(y', Y_norm, 'gauss1');
sigmaY = Fy.c1/sqrt(2);
  