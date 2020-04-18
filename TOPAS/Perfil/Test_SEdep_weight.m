clear all
close all
SimulationNumber = input('Máquina qué simulacion es esta?') ; %Ir cambiando
EdepFileName = 'Edep.csv';
Edep_STDFileName = 'Edep_STD.csv';
SDFileName = 'SIN_DIFUSOR.txt';

%% Import length and bin number 
[NR,NZ,dR,dZ,spreadX,spreadY,angularspreadX,angularspreadY,energy,N_histories] = readData(EdepFileName,SDFileName);
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

tblEdep = readtable(fullfile(EdepFileName), opts);
tblEdep_STD = readtable(fullfile(Edep_STDFileName), opts);
% Create fluence and Edep matrices

Edep_matrix = flipud(reshape(tblEdep.D, [NZ NR]));
EdepSTD_matrix = flipud(reshape(tblEdep_STD.D, [NZ NR]));

%% Calculate and plot depth dose distribution

RMaxValues = dR * (1:NR);
RMinValues = RMaxValues - dR;
RValues = RMaxValues - dR/2;
ZMaxValues = dZ * (1:NZ);
ZMinValues = ZMaxValues - dZ;
ZValues = ZMaxValues - dZ/2;
EdepZ = sum(Edep_matrix,2);%Energy deposited per plane
EdepSTDZ = sum(EdepSTD_matrix,2);
EdepSTD_matrix_normalized = EdepSTD_matrix./EdepSTDZ;
Edep_matrix_normalized = Edep_matrix./EdepZ;


i = 2000;   %ELEGIR PLANO 
Zplane = sprintf('_%.2fcm',ZValues(i));
Direction = sprintf('%iMeV/Sim%i/Images/',energy,SimulationNumber);
etiqueta = sprintf('_%iMeV_Sim%i',energy,SimulationNumber);


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

figure (10)
errorbar(RValues,FValues,Errorvalues)
hold on
plot(RValues,F1(RValues),'r','LineWidth',2)
plot(RValues,FValues_weighted,'g','LineWidth',2)
xlabel('R (cm)', 'FontSize',20 )
ylabel('E ', 'FontSize',20 )
legend('Simulated Energy Deposition','Unwieghted Gaussian Fit','Weighted Gaussian Fit','Location','NorthEast','FontSize',15)
grid on
set((10),'Position', [0 0 800 600]);
saveas(gcf,[Direction,'gauss',Zplane,etiqueta,'.png'])
