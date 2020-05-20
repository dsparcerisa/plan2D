function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_Cu_DIF_19022020

%% Experimental data
ZValues_exp = [5.1 6.6 8.1 9.6 11.1 12.6];
SEdepX_exp = [0.9221 1.3381 1.6884 2.1456 2.9426 3.2816; 0.0110 0.0211 0.0263 0.0765 0.1954 0.3594];
SEdepY_exp = [1.0597 1.4751 1.8560 2.9168 4.6886 6.5753; 0.0156 0.0394 0.0486 0.3695 0.7129 0.5053];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);