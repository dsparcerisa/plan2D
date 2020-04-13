
clear all
close all
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
%Edep_matrix = (reshape(tblEdep.D, [NZ NR]));
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

%Bragg Peak Analysis R80D
results = analyseBP(ZValues,EdepZ,'Method','full','AccuracySpline',0.001,'AccuracyBortfeld',0.001,'levelPoly',0.7);
R80D = mean([results.spline.R80D,results.poly3.R80D,results.bortfeld.R80D]);

%NSIT PSTAR data
Range = [4 2.839E-02;8 9.493E-02]; %[MeV, g/cm2)
rho_air =  0.00129; %g/cm3
R = Range(find(Range==energy),2)/rho_air; 

R80D_error = abs(1-R80D/R)*100;
sprintf('The simulated range is %.2fcm with an error of %.2f%%',R80D,R80D_error)

Vertical = linspace(0,EdepZ(find(abs(ZValues-R80D)<0.01)),100);
x_Vertical = R80D.*ones(1,length(Vertical));
figure 
subplot(2,1,1);
errorbar(ZValues,EdepZ,EdepSTDZ);
hold on
plot(x_Vertical,Vertical);
xlabel('Z (cm)')
ylabel('Edep MeV')
subplot(2,1,2);
imagesc(ZValues,RValues,Edep_matrix)
xlabel('Z (cm)')
ylabel('R (cm)')
%Directory = sprintf('%iMeV/Sim%i/',energy,SimulationNumber);
%figname = [Directory,'Range.fig'];
%savefig(figname)

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

figure
subplot(2,1,1)
plot(ZValues,SEdep,'+')
xlabel('Z (cm)')
ylabel('Sigm (cm)')

[~, maxPos] = max(SEdep);
maxValidIndex = min(maxPos, rangeIndex);

[~, minPos] = min(SEdep(10:round(maxValidIndex/2)));
minValidIndex = minPos+9;

SEdep(1:minValidIndex) = nan;
SEdep(maxValidIndex:NZ) = nan;
SEdep_weighted(:,1:minValidIndex) = nan;
SEdep_weighted(:,maxValidIndex:NZ) = nan;

subplot(2,1,2)
plot(ZValues,SEdep,'b',ZValues,SEdep_weighted(1,:),'g',ZValues,SEdep_weighted(1,:)+SEdep_weighted(2,:),'r',ZValues,SEdep_weighted(1,:)-SEdep_weighted(2,:),'r')
xlabel('Z (cm)')
ylabel('Sigm (cm)')
