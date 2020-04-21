clear all
close all

%% Prepare file names
EdepFileName = 'Edep_Phantom.csv';
Edep_STDFileName = 'Edep_STD_Phantom.csv';
EdepXYFileName = 'Edep_PhantomXY.csv';
EdepXY_STDFileName = 'Edep_STD_PhantomXY.csv';
SDFileName = 'QUADRUPOLE.txt';

%% Import length and bin number 
[NR,NZ,dR,dZ] = readData(EdepFileName,SDFileName);
%% Setup the Import Options
opts = delimitedTextImportOptions("NumVariables", 4);

% Specify range and delimiter
opts.DataLines = [9, Inf];
opts.Delimiter = ",";

% Specify column names and types
opts.VariableNames = ["A", "B", "C", "D"];
opts.VariableTypes = ["double", "double", "double", "double"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";

%% Read files for desired energy
tblEdepXY = readtable(fullfile(EdepXYFileName), opts);
tblEdepXY_STD = readtable(fullfile(EdepXY_STDFileName), opts);
% Create fluence and Edep matrices
%%
EdepXY_matrix = flipud(reshape(tblEdepXY.D, [NR NR]));
EdepXYSTD_matrix = flipud(reshape(tblEdepXY_STD.D, [NR NR]));

%%
XYValues = -1.495:0.01:1.495;
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
%%
SEdep
figure (8) 
subplot(2,2,[1,2])
imagesc(XYValues,XYValues,EdepXY_matrix)
xlabel('X (cm)')
ylabel('Y (cm)')
subplot(2,2,3)
errorbar(XYValues,EdepXY_normalized(1,:),EdepXYSTD_normalized(1,:))
xlabel('X (cm)')
ylabel('E')
hold on
plot(XYValues,FValues_weighted(1,:))
subplot(2,2,4)
errorbar(XYValues,EdepXY_normalized(2,:),EdepXYSTD_normalized(2,:))
hold on
plot(XYValues,FValues_weighted(2,:))
xlabel('Y (cm)')
ylabel('E')
set((8),'Position', [0 0 800 600]);