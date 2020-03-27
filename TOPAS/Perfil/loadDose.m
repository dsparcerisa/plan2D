function [SDose] = loadDose(energy)
% Creates polinomial fit for sigma based on fluence and deposited energy
% in files within folder

%% Prepare file names
DoseFileName = 'Dose.csv';

energy = uint8(energy);
energyString = sprintf('%iMeV',energy);
%% Set voxel dimensions
% # Results for scorer Fluence
% # R in 100 bins of 0.01 cm
% # Phi in 1 bin  of 360 deg
% # Z in 2000 bins of 0.02 cm
% # Fluence ( /mm2 ) : Sum
% # Dose ( MeV/kg ) : Sum

NR = 100;
NZ = 2000;
dR = 0.01;
dZ = 0.02;

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

tblDose = readtable(fullfile(DoseFileName), opts);

% Create fluence and Edep matrices

dose = reshape(tblDose.D, [NZ NR]);

%% Calculate and plot depth dose distribution

RMaxValues = dR * (1:NR);
RMinValues = RMaxValues - dR;
RValues = RMaxValues - dR/2;
ZMaxValues = dZ * (1:NZ);
ZMinValues = ZMaxValues - dZ;
ZValues = ZMaxValues - dZ/2;
DoseZ = sum(dose,2);
DoseZ = DoseZ / sum(DoseZ);

% --> A partir de 5 MeV falla porque "no cabe" todo el haz dentro del scorer
% --> Habrá que recalcular las tablas con un scorer más ancho.
%% Find maximum value ("range");
rangeIndex = find(DoseZ==0,1);
if isempty(rangeIndex)
    rangeIndex = NZ;
else
    rangeIndex = rangeIndex - 1;
end

%% Sigma for the Fluence
SDose = nan(1, NZ);
for i=1:rangeIndex
    try
        Fvalues = dose(i,:);
        Fvalues = Fvalues / sum(Fvalues);
        F1 = fit(RValues', Fvalues', 'gauss1');
        SDose(i) = F1.c1 / sqrt(2);
    catch
        % minValidIndex = i;
    end
end
SDose=fliplr(SDose);
[~, maxPos] = max(SDose)
maxValidIndex = min(maxPos, rangeIndex);

[~, minPos] = min(SDose(1:round(maxValidIndex/2)));
minValidIndex = minPos;

SDose(1:minValidIndex) = nan;
SDose(maxValidIndex:NZ) = nan;