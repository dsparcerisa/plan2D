function [SEdep,SEdep_weighted,NR,NZ,dR,dZ,spreadX,spreadY,angularspreadX,angularspreadY,energy,N_histories] = loadEdep(SimulationNumber)
% Creates polinomial fit for sigma based on fluence and deposited energy
% in files within folder

%% Prepare file names
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
Direction = sprintf('%iMeV/Sim%i/Images/',energy,SimulationNumber);
etiqueta = sprintf('_%iMeV_Sim%i',energy,SimulationNumber);
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

%% Bragg Peak
%[R80D,R80D_error]=BraggPeak(ZValues,EdepZ,EdepSTDZ,energy,SimulationNumber)

%% Find maximum value ("range");
rangeIndex = find(EdepZ==0,1);
if isempty(rangeIndex)
    rangeIndex = NZ;
else
    rangeIndex = rangeIndex - 1;
end

%% Sigma for the Fluence
SEdep = nan(1, NZ);
SEdep_weighted = nan(2, NZ);
modelFun = @(b,x) b(1)*exp(-((x-b(2))/(b(3))).^2);
for i=1:rangeIndex
    try
        FValues = Edep_matrix_normalized(i,:);
        F1 = fit(RValues', FValues', 'gauss1');
        F1_coefficients = [F1.a1 F1.b1 F1.c1]; 
        SEdep(i) = F1.c1 / sqrt(2);
        Errorvalues = EdepSTD_matrix_normalized(i,:);
        w = (Errorvalues).^(-2);
        Non_inf_w = find(w ~= inf); %Hay valores que de STD que son nulos y que al calcular w dan inf. Los he eliminado del ajuste
        nlm = fitnlm(RValues(Non_inf_w),FValues(Non_inf_w),modelFun,F1_coefficients,'Weight',w(Non_inf_w));
        SEdep_weighted(:,i) = [nlm.Coefficients.Estimate(3);nlm.Coefficients.SE(3)]./sqrt(2);
    catch
        % minValidIndex = i;
    end
    
end
%%
figure(1)
imagesc(ZValues,RValues,Edep_matrix)
xlabel('Z (cm)','FontSize',20)
ylabel('R (cm)','FontSize',20)
set((1),'Position', [0 0 800 600]);
saveas(gcf,[Direction,'2D_Edep',etiqueta,'.png'])

figure (2)
plot(ZValues,SEdep,'+')
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (cm)','FontSize',20)
legend('\sigma Unweighted','Location','NorthWest','FontSize',15)
set((2),'Position', [0 0 800 600]);
saveas(gcf,[Direction,'SEdep_unweighted',etiqueta,'.png'])

%% Set maxValidIndex and minValidIndex manually or automatically

%Automatically
    %[~, maxPos] = max(SEdep);
    %maxValidIndex = min(maxPos, rangeIndex);
    %[~, minPos] = min(SEdep(10:round(maxValidIndex/2)));
    %minValidIndex = minPos+9;
    
%Manually
    zmax = 28.01;
    maxValidIndex = find(abs(ZValues-zmax)<0.01); 
    zmin = 2.01;
    minValidIndex = find(abs(ZValues-zmin)<0.01); 
%%
SEdep(1:minValidIndex) = nan;
SEdep(maxValidIndex:NZ) = nan;
SEdep_weighted(:,1:minValidIndex) = nan;
SEdep_weighted(:,maxValidIndex:NZ) = nan;

figure (3)
plot(ZValues,SEdep_weighted(1,:),'g',ZValues,SEdep_weighted(1,:)+SEdep_weighted(2,:),'r',ZValues,SEdep_weighted(1,:)-SEdep_weighted(2,:),'r')
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (cm)','FontSize',20)
legend('\sigma Weighted','\sigma Weighted + error','\sigma Weighted - error', 'Location','NorthWest','FontSize',15)
set((3),'Position', [0 0 800 600]);
saveas(gcf,[Direction,'SEdep_weighted',etiqueta,'.png'])