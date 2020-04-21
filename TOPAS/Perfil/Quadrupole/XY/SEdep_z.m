function [SEdepX,SEdepY] = SEdep_z(EdepXY_matrix,EdepXYSTD_matrix)

%%
XYValues = -0.495:0.01:0.495;
EdepX = sum(EdepXY_matrix,2);
EdepX_normalized = EdepX./sum(EdepX);
EdepX_STD = sum(EdepXYSTD_matrix,2);
EdepX_STD_normalized = EdepX_STD./sum(EdepX_STD);
EdepY = sum(EdepXY_matrix,1);
EdepY_normalized = EdepY./sum(EdepY);
EdepY_STD = sum(EdepXYSTD_matrix,1);
EdepY_STD_normalized = EdepY_STD./sum(EdepY_STD);
%%
EdepXY_normalized = [EdepX_normalized'; EdepY_normalized];
EdepXYSTD_normalized = [EdepX_STD_normalized'; EdepY_STD_normalized];



modelFun = @(b,x) b(1)*exp(-((x-b(2))/(b(3))).^2);
SEdep = nan(2,2);
FValues_weighted = [];
for i = 1:2;
    FValues = EdepXY_normalized(i,:);
    F1 = fit(XYValues', FValues', 'gauss1');
    F1_coefficients = [F1.a1 F1.b1 F1.c1];    
    Errorvalues = EdepXYSTD_normalized(i,:);
    w = (Errorvalues).^(-2);
    Non_inf_w = find(w ~= inf); %Hay valores que de STD que son nulos y que al calcular w dan inf. Los he eliminado del ajuste
    nlm = fitnlm(XYValues(Non_inf_w),FValues(Non_inf_w),modelFun,F1_coefficients,'Weight',w(Non_inf_w));
    SEdep(:,i) = [nlm.Coefficients.Estimate(3);nlm.Coefficients.SE(3)]./sqrt(2);
    nlm_coefficients = nlm.Coefficients.Estimate;
    FValues_weighted = [FValues_weighted; nlm_coefficients(1)*exp(-((XYValues-nlm_coefficients(2))/nlm_coefficients(3)).^2)];
    
end
SEdepX = SEdep(:,1)';
SEdepY = SEdep(:,2)';