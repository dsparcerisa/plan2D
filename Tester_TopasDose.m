clear all
close all

%% Input
E0 = 3.5;
DoseFileName = {'Analitico/Resultados/Dose-3.5.csv'};
Z = 10.1; %cm
dTarget = 0.2; %cm 200um
rho = 0.001225; %aire  g/cm3
Nprot = 10^6;
%% TOPAS
[Dose, Dose_STD, x, y, z] = getTopasData(DoseFileName{1});
zIndex = find(abs(z-Z)<0.01 );
DoseTopas = Dose(:,:,zIndex)';%OJO!! que en TOPAS las filas corresponden a X y las columnas a Y. En el c�clulo anal�tico es al rev�s
DoseTopas_norm = DoseTopas./(sum(sum(DoseTopas)));
[sigmaX_T, sigmaY_T] = getUnWeightedSigmaGauss(DoseTopas, x, y);
%% 
[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0, 0:0.0001:Z);
targetTh = rho*dTarget;
targetSPR = stoppingPowerAir(end)/stoppingPowerWater(end);
dx = 0.1; %mm
dy = 0.1; %mm
sizeX = 40; %mm
sizeY = 40; %mm
doseMap = getDoseMap(dx, dy, sizeX, sizeY, E0, Z, Nprot, targetTh, targetSPR);
DoseAA_norm = doseMap.data./(sum(sum(doseMap.data)));
[sigmaX_AA, sigmaY_AA] = getUnWeightedSigmaGauss(doseMap.data, x, y);

DoseTopas_normProfile = createEmptyCG2D(dx,dy, sizeX, sizeY);
DoseTopas_normProfile.data = DoseTopas_norm;
DoseAA_normProfile = createEmptyCG2D(dx,dy, sizeX, sizeY);
DoseAA_normProfile.data = DoseAA_norm;
%%
[G] = Gamma3(DoseTopas_normProfile,DoseAA_normProfile);
