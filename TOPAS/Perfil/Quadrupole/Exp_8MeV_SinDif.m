function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_SinDif

%% Experimental data
ZValues_exp = [ 4.4 5.9 7.4 8.9 10.4 11.9];
SEdepX_exp = [0.474 0.637 0.881 1.11 1.254 1.434; 0.014 0.022 0.021 0.02 0.01 0.039];
SEdepY_exp = [0.58 0.731 0.948 1.149 1.308 1.426; 0.016 0.022 0.023 0.024 0.021 0.036];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);