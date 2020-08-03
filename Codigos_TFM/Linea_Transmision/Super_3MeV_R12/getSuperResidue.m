function [Res,polyX,polyY] = getSuperResidue(DoseFileName)
%% Sigma Calculation
sigmaX = nan(length(DoseFileName),2);
sigmaY = nan(length(DoseFileName),2);
for i = 1 : length(DoseFileName);
    [Dose, Dose_STD, x, y, ~] = getTopasData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = getSigma(Dose, Dose_STD, x, y);
end

%% Load Experimental Data
[z,sigmaX_exp,sigmaY_exp] = getExperimentalData_3MeV_R12;

%% Residue
[Res] = getResidue(sigmaX_exp, sigmaY_exp, sigmaX, sigmaY);

%% Quadratic Fit
[polyX,polyY] = getQuadraticFit(z,sigmaX,sigmaY);

[polyX_exp,polyY_exp] = getQuadraticFit(z,sigmaX_exp,sigmaY_exp);
getFigure(z,sigmaX_exp,sigmaY_exp,polyX_exp(:,:,1),polyY_exp(:,:,1),sigmaX,sigmaY,polyX(:,:,1),polyY(:,:,1))

