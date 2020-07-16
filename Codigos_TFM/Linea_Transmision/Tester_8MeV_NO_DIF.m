clear all; close all

DoseFileName = {'TOPAS/8MeV/Dose_51mm.csv','TOPAS/8MeV/Dose_66mm.csv','TOPAS/8MeV/Dose_81mm.csv','TOPAS/8MeV/Dose_96mm.csv','TOPAS/8MeV/Dose_111mm.csv','TOPAS/8MeV/Dose_126mm.csv'};
%% Sigma Calculation
sigmaX = nan(length(DoseFileName),2);
sigmaY = nan(length(DoseFileName),2);
for i = 1 : length(DoseFileName);
    [Dose, Dose_STD, x, y, ~] = getTopasData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = getSigma(Dose, Dose_STD, x, y);
end

%% Load Experimental Data
[z,sigmaX_exp,sigmaY_exp] = getExperimentalData_8MeV_NO_DIF;
[polyX_exp,polyY_exp] = getQuadraticFit(z,sigmaX_exp,sigmaY_exp);

%% Residue
[Res] = getResidue(sigmaX_exp, sigmaY_exp, sigmaX, sigmaY);

%% Quadratic Fit
[polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);

%% Figure
getFigure(z,sigmaX_exp,sigmaY_exp,polyX_exp(:,:,1),polyY_exp(:,:,1),sigmaX,sigmaY,polyX(:,:,1),polyY(:,:,1));