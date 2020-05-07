clear all
close all
EdepFileName = 'Edep_PhantomXY.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY.csv';
CodeFileName = 'Edep_V2.txt';

%% Import Data
[Edep, Edep_STD, NX, NY, NZ, dx, dy, dz, Spread, AngularSpread, MagneticGradient, energy, N_histories] = importData(EdepFileName,Edep_STDFileName,CodeFileName);

%% Reshape 
Edep = permute(reshape(Edep, [NZ NY NX]), [3 2 1]);
Edep_STD = permute(reshape(Edep_STD, [NZ NY NX]), [3 2 1]);

%% Bin positions
x = dx * [-(NX/2-1/2):(NX/2-1/2)]*10;
y = dy * [-(NY/2-1/2):(NY/2-1/2)]*10;
z = 30 - dz * (0:(NZ-1));

%% Sigma Calculation
[sigmaX, sigmaY] = sigma(Edep, Edep_STD, x, y, z);

%% Polynomial Fit
z0 = 2;
[nlmX,nlmY] = poly_sigma(z ,sigmaX ,sigmaY,z0);

%% Figure
figure_sigma(sigmaX,sigmaY,z,nlmX,nlmY)

%% Residue

[z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_SinDif;
residue = residue(z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y,nlmX,nlmY);

InputData = table(Spread,AngularSpread,MagneticGradient,residue)


