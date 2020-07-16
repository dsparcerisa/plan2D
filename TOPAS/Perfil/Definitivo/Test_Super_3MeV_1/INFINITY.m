function [residue,linearX,linearY,X0,Y0] = INFINITY(DoseFileName,COMGX,numbfig,numbsubfig)
%% Sigma Calculation
sigmaX = nan(5,2);
sigmaY = nan(5,2);
for i = 1 : 5;
    [Dose, Dose_STD, x, y] = importData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = sigma_RC(Dose, Dose_STD, x, y);
end

%% Load Experimental Data
[z_exp,sigmaX_exp,sigmaY_exp] = Exp_3MeV_NO_PP_R12_06022020;
[linearX_exp,linearY_exp] = linearfit(z_exp,sigmaX_exp,sigmaY_exp);

%% Residue
wiX = (sigmaX_exp(:,2).^2+sigmaX(:,2).^2).^(-1);
resiX2 = wiX.*((sigmaX_exp(:,1)-sigmaX(:,1)).^2);
residueX = sqrt((sum(resiX2))/sum(wiX));

wiY = (sigmaY_exp(:,2).^2+sigmaY(:,2).^2).^(-1);
resiY2 = wiY.*(sigmaY_exp(:,1)-sigmaY(:,1)).^2;
residueY = sqrt((sum(resiY2))/sum(wiY)); 

residue = [residueX,residueY];


%% Linear Fit
[linearX,linearY] = linearfit(z_exp,sigmaX,sigmaY);

X0 = -linearX(2)/linearX(1);
Y0 = -linearY(2)/linearY(1);
%% Figure
figura(z_exp,sigmaX_exp,sigmaY_exp,linearX_exp,linearY_exp,sigmaX,sigmaY,linearX,linearY,COMGX,numbfig,numbsubfig);
