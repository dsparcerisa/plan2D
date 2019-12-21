%% Import data from text file
% Script for importing data from the following text file:
%
%    filename: /Users/dani/Google Drive/Trabajo/UCM/01-Proyectos/20-FLASH/Sims_TOPAS/puntual/1MeV/Fluence.csv
%
% Auto-generated by MATLAB on 12-Dec-2019 12:55:22

% # Results for scorer Fluence
% # R in 100 bins of 0.01 cm
% # Phi in 1 bin  of 360 deg
% # Z in 2000 bins of 0.02 cm
% # Fluence ( /mm2 ) : Sum   

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

% Import the dat
tbl = readtable(fullfile('10MeV','Fluence.csv'), opts);
tbl2 = readtable(fullfile('10MeV', 'EnergyDep.csv'), opts);

%% Convert to output type
flu = tbl.D;
Edep = tbl2.D;

%%
NR = 100;
NZ = 2000;
dR = 0.01;
dZ = 0.02;
Rvalues = dR*(1:NR) - dR/2;
Zvalues = dZ*(1:NZ) - dZ/2;

flu = reshape(flu, [NZ NR]);
Edep = reshape(Edep, [NZ NR]);

%Choose the Z range for the Sigma interpolation
%% Fit
Sflu = nan(1, NZ);
SEdep = nan(1, NZ);
maxFitIgnored = 0;
for i=1:NZ
    try
        F1 = fit(Rvalues', flu(i,:)', 'gauss1');
        Sflu(i) = F1.c1 / sqrt(2);        
    catch
        maxFitIgnored = i;
    end
    i
end
maxFitIgnored = maxFitIgnored + 15;
Sflu(1:maxFitIgnored) = dR;
fprintf('Ignoring fits at positions Z <= %f... \n', Zvalues(maxFitIgnored));

% pflu=polyfit(Zvalues,Sflu,2); %% polyfit no permite restringir valores
F = fit(Zvalues', Sflu', 'poly2', 'Lower', [0 0 0]);
pflu = coeffvalues(F);
SfluInterp=polyval(pflu,Zvalues);
figure
plot(Zvalues, Sflu, 'r.')
hold on
plot(Zvalues,SfluInterp, 'b-')

ylabel('Sigma (cm)')
xlabel('Z (cm)')
title('Fluence')

%% Sigma for the Edep

for i=a:b
    F2 = fit(Rvalues', Edep(i,:)', 'gauss1');
    sse=F2.c1;
    SEdep=[SEdep,sse];
end
pEdep=polyfit(Zvalues(a:b),SEdep,2);
SEdepInterp=polyval(pEdep,Zvalues);
figure
plot(Zvalues,SEdepInterp)
ylabel('Sigma (cm)')
xlabel('Z (cm)')
title('Energy deposition')
%pruebacambio

