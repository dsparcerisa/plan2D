clear all; close all

DoseFileName = {'TOPAS/3MeV/Dose_49mm.csv','TOPAS/3MeV/Dose_64mm.csv','TOPAS/3MeV/Dose_79mm.csv','TOPAS/3MeV/Dose_94mm.csv','TOPAS/3MeV/Dose_109mm.csv'};

%% Sigma Calculation
sigmaX = nan(length(DoseFileName),2);
sigmaY = nan(length(DoseFileName),2);
for i = 1 : length(DoseFileName);
    [Dose, Dose_STD, x, y, ~] = getTopasData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = getSigma(Dose, Dose_STD, x, y);
end

%% Load Experimental Data
[z,sigmaX_exp,sigmaY_exp] = getExperimentalData_3MeV_R12;
[polyX_exp,polyY_exp] = getQuadraticFit(z,sigmaX_exp,sigmaY_exp);

%% Residue
[Res] = getResidue(sigmaX_exp, sigmaY_exp, sigmaX, sigmaY);

%% Quadratic Fit
[polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);

%% Figure
getFigure(z,sigmaX_exp,sigmaY_exp,polyX_exp(:,:,1),polyY_exp(:,:,1),sigmaX,sigmaY,polyX(:,:,1),polyY(:,:,1));

