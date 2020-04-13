clear all
close all
load('Resultados_STD.mat')


i = 1000;   %ELEGIR PLANO 

FValues = Edep_matrix_normalized(i,:);
Errorvalues = EdepSTD_matrix_normalized(i,:);
F1 = fit(RValues', FValues', 'gauss1');
F1_coefficients = [F1.a1 F1.b1 F1.c1]; 

modelFun = @(b,x) b(1)*exp(-((x-b(2))/(b(3))).^2);
w = (Errorvalues).^(-2);
Non_inf_w = find(w ~= inf); %Hay valores que de STD que son nulos y que al calcular w dan inf. Los he eliminado del ajuste

nlm = fitnlm(RValues(Non_inf_w),FValues(Non_inf_w),modelFun,F1_coefficients,'Weight',w(Non_inf_w));
nlm_coefficients = nlm.Coefficients.Estimate;

FValues_weighted = nlm_coefficients(1)*exp(-((RValues-nlm_coefficients(2))/nlm_coefficients(3)).^2);
SEdep_weighted = [nlm.Coefficients.Estimate(3);nlm.Coefficients.SE(3)]./sqrt(2);

figure
errorbar(RValues,FValues,Errorvalues)
hold on
plot(RValues,F1(RValues),'r')
plot(RValues,FValues_weighted,'g')
xlabel('R (cm)', 'FontSize',20 )
ylabel('E ', 'FontSize',20 )