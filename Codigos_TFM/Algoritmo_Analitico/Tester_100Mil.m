clear all
close all

%% Topas data
[DT, DT_STD, x, y, HalfdTarget] = getTopasData('Resultados_Water/10millones/Dose-3-6.csv'); %%Cambiar

dx = abs(x(1)-x(2)); %mm
dy = abs(y(1)-y(2)); %mm
sizeX = abs(max(x))+abs(min(x)) + dx; %mm
sizeY = abs(max(y))+abs(min(y)) + dy; %mm
DT6 = DT.*10^6;
%% Input for the AA
load('polyFlu'); %Polynomials
% Tienen que coincidir con el de TOPAS
E0 = 3; % MeV
z = 6; %cm
Nprot = 1; %Protons

dTarget = 2*HalfdTarget; %cm
rho_Target = 1; %g/cm3
targetTh = dTarget*rho_Target; %g/cm2
targetSPR = 1;

%% getSigma
[sigmaXT, sigmaYT] = sigma_RC(DT, DT_STD, x, y);
[sigmaXAA, sigmaYAA] = getSigma(polyFluX,polyFluY, E0, z, dTarget);


%% getFluenceMap
[FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaXAA(1),sigmaYAA(1));

%% Dose Map
doseMap = getDoseMap(FluenceProfile, E0, z, Nprot, targetTh, targetSPR);

DAA6 = doseMap.data.*10^6;

%% Surface

[X,Y] = meshgrid(x,y);

figure (1)
subplot(1,2,1)
mesh(X,Y,DT6)
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
zlabel('Dose (Gy/10^{6} protons)','FontSize',15)
title ('TOPAS','FontSize',15)

subplot(1,2,2)
mesh(X,Y,DAA6)
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
zlabel('Dose (Gy/10^{6} protons)','FontSize',15)
title ('Algoritmo Analítico','FontSize',15)

set((1),'Position', [0 0 800 600]);

%% Plot 
figure (2)
subplot(3,2,[1 2])
contour(x,y,abs(DT6-DAA6),'LineWidth',2)
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
legend('|Dose_{T} - Dose_{AA}| (%)','FontSize',12)
title('a) |Dose_{T} - Dose_{AA}|','FontSize',15)
grid on

subplot(3,2,3)
plot(x,sum(DT6,2),'b','LineWidth',1)
hold on
grid on
xlabel('x (mm)','FontSize',15)
ylabel('Dose (Gy/10^{6} protons)','FontSize',15)
legend('Dose','FontSize',12)
axis([-10 10 0 10])
title('b) Topas','FontSize',15)

subplot(3,2,4)
plot(x,sum(DAA6,2),'r','LineWidth',1)
hold on
grid on
xlabel('y (mm)','FontSize',15)
ylabel('Dose (Gy/10^{6} protons)','FontSize',15)
legend('Dose','FontSize',12)
axis([-10 10 0 10])
title('c) Algoritmo Analítico','FontSize',15)

subplot(3,2,5)
plot(y,sum(DT6,1),'b','LineWidth',1)
hold on
grid on
xlabel('y (mm)','FontSize',15)
ylabel('Dose (Gy/10^{6} protons)','FontSize',15)
legend('Dose','FontSize',12)
axis([-10 10 0 10])
title('d) Topas','FontSize',15)

subplot(3,2,6)
plot(y,sum(DAA6,1),'r','LineWidth',1)
hold on
grid on
xlabel('y (mm)','FontSize',15)
ylabel('Dose (Gy/10^{6} protons)','FontSize',15)
legend('Dose','FontSize',12)
axis([-10 10 0 10])
title('e) Algoritmo Analítico','FontSize',15)

grid on
set((2),'Position', [0 0 800 800]);

%% Gamma 3

percent = 0.03*max(max(DT)); % Gy/proton
dta = 3 ; %mm

reference.start = [x(1) y(1)];
reference.width = [dx dy];
reference.data = [DT];

target.start = [doseMap.minX doseMap.minY];
target.width = [doseMap.dx doseMap.dy];
target.data = [DAA];

gamma = CalcGamma(reference, target, percent, dta, 'local', 0);