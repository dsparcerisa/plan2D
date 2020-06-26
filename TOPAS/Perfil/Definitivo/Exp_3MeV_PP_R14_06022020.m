function [ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_3MeV_PP_R14_06022020

%% Experimental data
ZValues_exp = [4.9000 6.4000 7.9000 9.4000 10.9000];
SEdepX_exp = [1.5171 1.9300 2.3397 2.6683 2.9955; 0.0193 0.0207 0.0210 0.0217 0.0293];
SEdepY_exp = [1.4768 1.8392 2.2319 2.5617 2.8292; 0.0257 0.0306 0.0263 0.0244 0.0417];

poly_exp_X = polyfit(ZValues_exp,SEdepX_exp(1,:),2);
w_X = ones(size(ZValues_exp)).*(SEdepX_exp(2,:).^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp_X = fitnlm(ZValues_exp,SEdepX_exp(1,:),modelFun,poly_exp_X,'Weight',w_X);

poly_exp_Y = polyfit(ZValues_exp,SEdepY_exp(1,:),2);
w_Y = ones(size(ZValues_exp)).*(SEdepY_exp(2,:).^-2);
nlm_exp_Y = fitnlm(ZValues_exp,SEdepY_exp(1,:),modelFun,poly_exp_Y,'Weight',w_Y);