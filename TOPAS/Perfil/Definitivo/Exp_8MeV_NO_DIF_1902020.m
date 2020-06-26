function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_NO_DIF_1902020

%% Experimental data
ZValues_exp = [5.1 6.6 8.1 9.6 11.1 12.6];
SEdepX_exp = [0.4751 0.6395 0.8991 1.0751 1.2551 1.4783; 0.0143 0.0220 0.0239 0.0165 0.0087 0.0255];
SEdepY_exp = [0.5826 0.7317 0.9592 1.1505 1.3370 1.5052; 0.0156 0.0208 0.0220 0.0179 0.0235 0.0309];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);