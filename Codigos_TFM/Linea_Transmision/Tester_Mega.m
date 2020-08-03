clear all; close all
%%
%DoseFileName = {'TOPAS/3MeV/Dose_49mm00.csv','TOPAS/3MeV/Dose_64mm00.csv','TOPAS/3MeV/Dose_79mm00.csv','TOPAS/3MeV/Dose_94mm00.csv','TOPAS/3MeV/Dose_109mm00.csv'};
%DoseFileName = {'TOPAS/3MeV/Dose_49mm0.csv','TOPAS/3MeV/Dose_64mm0.csv','TOPAS/3MeV/Dose_79mm0.csv','TOPAS/3MeV/Dose_94mm0.csv','TOPAS/3MeV/Dose_109mm0.csv'};
%DoseFileName = {'TOPAS/3MeV/Dose_49mmX1.csv','TOPAS/3MeV/Dose_64mmX1.csv','TOPAS/3MeV/Dose_79mmX1.csv','TOPAS/3MeV/Dose_94mmX1.csv','TOPAS/3MeV/Dose_109mmX1.csv'};
DoseFileName = {'TOPAS/3MeV/Dose_49mmX2.csv','TOPAS/3MeV/Dose_64mmX2.csv','TOPAS/3MeV/Dose_79mmX2.csv','TOPAS/3MeV/Dose_94mmX2.csv','TOPAS/3MeV/Dose_109mmX2.csv'};
% Sigma Calculation
sigmaX = nan(length(DoseFileName),2);
sigmaY = nan(length(DoseFileName),2);
for i = 1 : length(DoseFileName);
    [Dose, Dose_STD, x, y, ~] = getTopasData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = getSigma(Dose, Dose_STD, x, y);
end

% Load Experimental Data
[z,sigmaX_exp,sigmaY_exp] = getExperimentalData_3MeV_R12;
[polyX_exp,polyY_exp] = getQuadraticFit(z,sigmaX_exp,sigmaY_exp);

% Residue
[Res] = getResidue(sigmaX_exp, sigmaY_exp, sigmaX, sigmaY);

% Quadratic Fit
[polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);

% Figure
getFigure2(z,sigmaX_exp,sigmaY_exp,polyX_exp(:,:,1),polyY_exp(:,:,1),sigmaX,sigmaY,polyX(:,:,1),polyY(:,:,1));