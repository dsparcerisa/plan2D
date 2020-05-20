function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_3MeV_NO_PP_R12_06022020

%% Experimental data
ZValues_exp = [4.9000 6.4000 7.9000 9.4000 10.9000];
SEdepX_exp = [1.1213 1.5208 2.1003 2.5578 3.0605; 0.0171 0.0182 0.0209 0.0223 0.0331];
SEdepY_exp = [1.1188 1.5962 2.1149 2.6694 3.1227; 0.0209 0.0201 0.0214 0.0281 0.0709];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);