function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_Data_Cu

%% Experimental data
ZValues_exp = [ 4.4 5.9 7.4 8.9 10.4 11.9];
SEdepX_exp = [0.922 01.349 1.665 2.175 2.867 2.999; 0.023 0.029 0.025 0.029 0.27 0.265];
SEdepY_exp = [1.067 1.468 1.765 3.158 4.371 5.742;0.029 0.011 0.012 0.035 0.038 0.031];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);