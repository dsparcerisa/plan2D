clear all
dz = 0.01;
dx = 0.01;
dy = 0.01;
Xval = -0.5:dx:0.5;
Yval = -0.5:dy:0.5;
Xval = Xval';

% Condiciones de partida
sigmaR = 0.2; % 2 mm
relFluenceMatrix = exp( - (Xval./(sqrt(2).*sigmaR)).^2 - (Yval./(sqrt(2).*sigmaR)).^2);
relFluenceMatrix = relFluenceMatrix / sum(relFluenceMatrix(:));
N = 1e7; % numero protones
E0 = 3; %MeV
Zirradiacion = 2; % cm
Zvalues = 0:dz:Zirradiacion;
densTarget = 1; % g/cm3
thickness = 1e-3; % 10^-3 cm = 10 um

%% Cálculo de cosas
[energyA, stoppingPowerAir, stoppingPowerWater] = energyStoppingPower(E0, Zvalues);

%% Valores en el punto de irradiacion
E_irr = energyA(end);
S_irr = stoppingPowerWater(end);

E_Mev = N.*relFluenceMatrix.*S_irr*thickness;
figure;
subplot(1,2,1)
imagesc(Yval, Xval, E_Mev); colorbar;
title('E (MeV)');
xlabel('Y (cm)');
ylabel('X (cm)');
MeV2J = 1.602e-13;

E_J = E_Mev * MeV2J;
m_1voxel_g = (dx * dy * thickness) * densTarget;
m_1voxel_kg = m_1voxel_g / 1000;

D = E_J ./ m_1voxel_kg;
subplot(1,2,2); imagesc(Yval, Xval, D); colorbar
caxis([0 1]);
title('D (Gy)');
xlabel('Y (cm)');
ylabel('X (cm)');