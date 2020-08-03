clear all; close all;

%% 1. Irradiar plan de calibración
% Irradiaciones 02-06

Log = 'irrLog_2020_02_06_18_49_50'; %CONV
sigmaPolyX = [0.004477 0.2586 -0.2693];
sigmaPolyY = [0.004065 0.2825 -0.3685];

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


limits = [-6 0 -4 0]; 
dose = getDoseFromPlanV2(doseCanvas, planStructure, dz, targetTh, targetSPR, factorImuestra, sigmaPolyX, sigmaPolyY);
dose.crop(limits);
figure (1)
subplot(2,1,1)
dose.plotSlice;
c = colorbar;
c.Label.String = 'Dose (Gy)';
c.Label.FontSize = 15;
caxis([0 15]);
xlabel('x (cm)','FontSize',15)
ylabel('y (cm)','FontSize',15)
title ('a)','FontSize',12)
grid on
%% Error
planStructureError = planStructure;
Outliers = planStructure.Shutter_Outlier;
planStructureError.numSpots = length(Outliers);
planStructureError.X = planStructure.X(Outliers);
planStructureError.Y = planStructure.Y(Outliers);
planStructureError.Z = planStructure.Z(Outliers); 
planStructureError.t_s = planStructure.t_s(Outliers);

subplot(2,1,2)
doseE = getDoseFromPlanV2(doseCanvas, planStructureError, dz, targetTh, targetSPR, factorImuestra, sigmaPolyX, sigmaPolyY);
doseE.crop(limits);
doseE.plotSlice;
c = colorbar;
c.Label.String = 'Dose (Gy)';
c.Label.FontSize = 15;
caxis([0 15]);
xlabel('x (cm)','FontSize',15)
ylabel('y (cm)','FontSize',15)
title ('b)','FontSize',12)
grid on
set((1),'Position', [0 0 800 600]);