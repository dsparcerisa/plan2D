function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_Au_DIF_19022020

%% Experimental data
ZValues_exp = [5.1 6.6 8.1 9.6 11.1 12.6];
SEdepX_exp = [0.7437 0.9416 1.1054 1.3617 1.6741 1.8830; 0.0175 0.0153 0.0197 0.0210 0.0560 0.0139];
SEdepY_exp = [0.9055 1.0908 1.2406 1.6629 1.8019 2.3270; 0.0256 0.0222 0.0250 0.1404 0.1171 0.2347];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);