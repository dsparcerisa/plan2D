clear all
close all

%% Topas data
[DT, DT_STD, x, y, HalfdTarget] = getTopasData('Analitico/Resultados_Water/Dose-8-2.csv');

dx = abs(x(1)-x(2)); %mm
dy = abs(y(1)-y(2)); %mm
sizeX = abs(max(x))+abs(min(x)) + dx; %mm
sizeY = abs(max(y))+abs(min(y)) + dy; %mm
DT_norm = DT./sum(sum(DT));

%% Input for the AA
load('polyFlu'); %Polynomials
E0 = 8; % MeV
z = 2; %cm
Nprot = 10^6; %Protons
dTarget = 2*HalfdTarget; %cm
rho_Target = 1; %g/cm3
targetTh = dTarget*rho_Target; %g/cm2
targetSPR = 1;

%% getSigma
[sigmaXT, sigmaYT] = sigma_RC(DT, DT_STD, x, y)
[sigmaXAA, sigmaYAA] = getSigma(polyFluX,polyFluY, E0, z, dTarget)


%% getFluenceMap
[FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaXAA(1),sigmaYAA(1));

%% Dose Map
doseMap = getDoseMap(FluenceProfile, E0, z, Nprot, targetTh, targetSPR);

DAA_norm = doseMap.data./sum(sum(doseMap.data));

%% Surface

[X,Y] = meshgrid(x,y);

figure (1)
subplot(1,2,1)
mesh(X,Y,DT_norm)
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
zlabel('Dose (%)','FontSize',15)
title ('TOPAS','FontSize',15)

subplot(1,2,2)
mesh(X,Y,DAA_norm)
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
zlabel('Dose (%)','FontSize',15)
title ('Algoritmo Analítico','FontSize',15)

set((1),'Position', [0 0 800 600]);

%% Gamma 3

percent = 3; %
dta = 3; %mm

reference.start = [x(1) y(1)];
reference.width = [dx dy];
reference.data = [DT_norm];

target.start = [doseMap.minX doseMap.minY];
target.width = [doseMap.dx doseMap.dy];
target.data = [DAA_norm];

gamma = CalcGamma(reference, target, percent, dta, 'local', 0);