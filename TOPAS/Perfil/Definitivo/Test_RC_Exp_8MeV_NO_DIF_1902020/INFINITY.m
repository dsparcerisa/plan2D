function [residue,polyX,polyY] = INFINITY(DoseFileName,COMGX,numbfig,numbsubfig)
%% Sigma Calculation
sigmaX = nan(6,2);
sigmaY = nan(6,2);
for i = 1 : 6;
    [Dose, Dose_STD, x, y] = importData(DoseFileName{i});
    [sigmaX(i,:), sigmaY(i,:)] = sigma_RC(Dose, Dose_STD, x, y);
end

%% Load Experimental Data
[z_exp,sigmaX_exp,sigmaY_exp] = Exp_8MeV_NO_DIF_1902020;
[polyX_exp,polyY_exp] = quadraticfit(z_exp,sigmaX_exp,sigmaY_exp);

%% Residue
wiX = (sigmaX_exp(:,2).^2+sigmaX(:,2).^2).^(-1);
resiX2 = wiX.*((sigmaX_exp(:,1)-sigmaX(:,1)).^2);
residueX = sqrt((sum(resiX2))/sum(wiX));

wiY = (sigmaY_exp(:,2).^2+sigmaY(:,2).^2).^(-1);
resiY2 = wiY.*(sigmaY_exp(:,1)-sigmaY(:,1)).^2;
residueY = sqrt((sum(resiY2))/sum(wiY)); 

residue = [residueX,residueY];


%% Linear Fit
[polyX,polyY] = quadraticfit(z_exp,sigmaX,sigmaY);


%% Figure
figura(z_exp,sigmaX_exp,sigmaY_exp,polyX_exp,polyY_exp,sigmaX,sigmaY,polyX,polyY,COMGX,numbfig,numbsubfig);
