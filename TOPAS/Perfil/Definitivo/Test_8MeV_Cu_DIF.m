clear all
close all
EdepFileName = 'Edep_8MeV_Cu_DIF.csv';
Edep_STDFileName = 'Edep_STD_8MeV_Cu_DIF.csv';
CodeFileName = 'Test_8MeV_Cu_DIF.txt';

%% Import Data
[Edep, Edep_STD, NX, NY, NZ, dx, dy, dz, Spread, AngularSpread, MagneticGradient1,MagneticGradien2, energy] = importData(EdepFileName,Edep_STDFileName,CodeFileName);

%% Reshape 
Edep = permute(reshape(Edep, [NZ NY NX]), [3 2 1]);
Edep_STD = permute(reshape(Edep_STD, [NZ NY NX]), [3 2 1]);

%% Bin positions
x = dx * [-(NX/2-1/2):(NX/2-1/2)]*10;
y = dy * [-(NY/2-1/2):(NY/2-1/2)]*10;
z = dz * [NZ-1/2:-1:1/2];

%% Sigma Calculation
[sigmaX, sigmaY] = sigma(Edep, Edep_STD, x, y, z);

%% Polynomial Fit
z_Cannon = 66.2008; %z_Cannon is the length of the Cannon
z_Air = 3.5; %z_Air is the the distance between the nozzle and the point from where the polynomial interpolation will be executed
z0 = z_Cannon + 3.5;  %z0 is the point form where the polynomial interpolation will be executed 

[nlmX,nlmY] = poly_sigma(z ,sigmaX ,sigmaY ,z0);

%% Figure
figure_sigma(sigmaX,sigmaY,z)

%% Residue

[z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y] = Exp_8MeV_Cu_DIF_19022020;
residue = residue(z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y,nlmX,nlmY);

InputData = table(Spread,AngularSpread,MagneticGradient1,MagneticGradient2,residue)
