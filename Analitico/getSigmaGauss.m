function [sigmaX, sigmaY] = getSigmaGauss(Dose, Dose_STD, x, y)
% Fit the distribution to gaussiana


modelFun = @(b,x) b(1)*exp(-((x-b(2))/(b(3))).^2);
%%

% Normalization
X = sum(Dose,2);
X_STD = sum(Dose_STD,2);
X_norm = X./sum(X);
X_STD_norm = X_STD./sum(X_STD);
Y = sum(Dose,1);
Y_STD = sum(Dose_STD,1);
Y_norm = Y./sum(Y);
Y_STD_norm = Y_STD./sum(Y_STD);
    
% x fit
Fx = fit(x', X_norm, 'gauss1');
%sigmaX = Fx.c1/sqrt(2);
Fx_coefficients = [Fx.a1 Fx.b1 Fx.c1];    
wx = (X_STD_norm).^(-2);
Non_inf_wx = find(wx ~= inf); 
nlmx = fitnlm(x(Non_inf_wx),X_norm(Non_inf_wx),modelFun,Fx_coefficients,'Weight',wx(Non_inf_wx));
sigmaX(1,:) = [nlmx.Coefficients.Estimate(3),nlmx.Coefficients.SE(3)]./sqrt(2);
    
% y fit
Fy = fit(y', Y_norm', 'gauss1');
%sigmaY = Fy.c1/sqrt(2);
Fy_coefficients = [Fy.a1 Fy.b1 Fy.c1];    
wy = (Y_STD_norm).^(-2);
Non_inf_wy = find(wy ~= inf); 
nlmy = fitnlm(y(Non_inf_wy),Y_norm(Non_inf_wy),modelFun,Fy_coefficients,'Weight',wy(Non_inf_wy));
sigmaY(1,:) = [nlmy.Coefficients.Estimate(3),nlmy.Coefficients.SE(3)]./sqrt(2);   

