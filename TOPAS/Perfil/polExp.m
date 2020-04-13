function [nlm_exp] = polExp;
%Medidas experimentales para sigma en funcion de Z de para el cañon de
%protones del CMMA a una energia de 8 MeV
Z = [4.4 5.9 7.4 8.9 10.4 11.9]; %cm
Sigma = [0.53 0.69 0.92 1.12 1.29 1.46].*0.1; %cm

error_Sigma = 0.001; %Error sistematico de medida  
poly_exp = polyfit(Z,Sigma,2);
w = ones(size(Z)).*(error_Sigma^-2);
modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);
nlm_exp = fitnlm(Z,Sigma,modelFun,poly_exp,'Weight',w);
