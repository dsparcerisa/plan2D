clear all
close all
%% Import experimental data
[z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_Cu_DIF_19022020;
%% Dose FileNames
DoseFileName = {'Dose_51mm.csv','Dose_66mm.csv','Dose_81mm.csv','Dose_96mm.csv','Dose_111mm.csv','Dose_126mm.csv'};
%% Sigma Calculation
sigmaX = nan(6,2);
sigmaY = nan(6,2);
for i = 1 : 6;
    [Dose, Dose_STD, x, y] = importData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = sigma_RC(Dose, Dose_STD, x, y);
end
%% Residue anf Figure
[residue] = residue(z_exp,sigmaX_exp',sigmaY_exp',sigmaX,sigmaY)    
