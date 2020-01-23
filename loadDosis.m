function [DoseZero,DoseWater]=loadDosis(energy,dZ)
%% Prepare file names
TOPASfile = 'TOPAS';
Verificacionfile = 'Verificacion_Dosis';
energy = uint8(energy);
energyString = sprintf('%iMeV',energy);
dZ = uint8(dZ);
dZString = sprintf('%ium',dZ);
DoseZero = 'DoseAtZero.csv';
DoseWater = 'DoseAtWater.csv';

%% Set voxel dimensions
% # Results for scorer Fluence
% # R in 100 bins of 0.01 cm
% # Phi in 1 bin  of 360 deg
% # Z in 2000 bins of 0.02 cm
% # Fluence ( /mm2 ) : Sum
% # Edep ( MeV ) : Sum

NX = 100;
NY = 100;

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
tblZero = readtable(fullfile(TOPASfile,Verificacionfile,energyString,dZString,DoseZero), opts);
tblWater = readtable(fullfile(TOPASfile,Verificacionfile,energyString,dZString,DoseWater), opts);

DoseZero = reshape(tblZero.D, [NX NY]);
DoseZero = DoseZero./sum(DoseZero(:));
DoseWater = reshape(tblWater.D, [NX NY]);
DoseWater = DoseWater./sum(DoseWater(:));