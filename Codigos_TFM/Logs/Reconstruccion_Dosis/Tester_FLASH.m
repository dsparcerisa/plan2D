clear all; close all;

%% 1. Irradiar plan de calibración
% Irradiaciones 02-06
%Log = 'irrLog_2020_02_06_11_27_09'; %FLASH R12
%sigmaPolyX = [0.004477 0.2586 -0.2693];
%sigmaPolyY = [0.004065 0.2825 -0.3685];

% Irradiaciones 02-04
Log = 'irrLog_2020_02_04_22_00_29'; %FLASH
sigmaPolyX = [0.00758 0.2116 -0.2501];
sigmaPolyY = [0.00234 0.2993 -0.5561];

planStructure = readPlanLog(Log)
planStructure.E = 3;
dz = 0.01; % cm
targetTh = 0.0014; % 14 um
targetSPR = 1; % water-equivalent

dxy = 0.1; % 0.1 mm
sizeX = 20;
sizeY = 20;
doseCanvas = createEmptyCG2D(dxy, sizeX, sizeY);
factorImuestra = 1;


limits = [-10 0 -10 0]; 
dose = getDoseFromPlanV2(doseCanvas, planStructure, dz, targetTh, targetSPR, factorImuestra, sigmaPolyX, sigmaPolyY);
dose.crop(limits);
figure (1)
%subplot(2,1,1)
dose.plotSlice;
c = colorbar;
c.Label.String = 'Dose (Gy)';
c.Label.FontSize = 15;
%caxis([0 15]);
xlabel('x (cm)','FontSize',15)
ylabel('y (cm)','FontSize',15)
grid on
set((1),'Position', [0 0 800 600]);