clear all
close all
EdepFileName = 'Edep_3MeV_NO_PP.csv';
Edep_STDFileName = 'Edep_STD_3MeV_NO_PP.csv';
CodeFileName = 'Test_3MeV_NO_PP.txt';

%% Import Data
[Edep, Edep_STD, NX, NY, NZ, dx, dy, dz, Spread, AngularSpread, MagneticGradient1,MagneticGradient2, energy] = importData(EdepFileName,Edep_STDFileName,CodeFileName);

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

[nlmX,nlmY] = poly_sigma(z ,sigmaX ,sigmaY , z_Cannon,z_Air);

%% Figure
figure_sigma(sigmaX,sigmaY,z)

%% Residue

[z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y] = Exp_3MeV_NO_PP_R12_06022020;
residue = residue(z_exp,sigmaX_exp,sigmaY_exp,nlm_exp_X,nlm_exp_Y,nlmX,nlmY);

InputData = table(Spread,AngularSpread,MagneticGradient1,MagneticGradient2,residue)