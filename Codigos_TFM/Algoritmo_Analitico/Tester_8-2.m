clear all
close all

%% Topas data
[DT, DT_STD, x, y, HalfdTarget] = getTopasData('Resultados_Water/10millones/Dose-8-2.csv'); %%Cambiar

dx = abs(x(1)-x(2)); %mm
dy = abs(y(1)-y(2)); %mm
sizeX = abs(max(x))+abs(min(x)) + dx; %mm
sizeY = abs(max(y))+abs(min(y)) + dy; %mm

%% Input for the AA
load('polyFlu'); %Polynomials
% Tienen que coincidir con el de TOPAS
E0 = 8; % MeV
z = 2; %cm
Nprot = 1; %Protons

dTarget = 2*HalfdTarget; %cm
rho_Target = 1; %g/cm3
targetTh = dTarget*rho_Target; %g/cm2
targetSPR = 1;

%% getSigma
[sigmaXT, sigmaYT] = sigma_RC(DT, DT_STD, x, y)
[sigmaXAA, sigmaYAA] = getSigma(polyFluX,polyFluY, E0, z, dTarget)


%% getFluenceMap
[FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaXT(1),sigmaYT(1),0,0);

%% Dose Map
doseMap = getDoseMap(FluenceProfile, 7.943, z, Nprot, targetTh, targetSPR);

DAA = doseMap.data;

%% Surface

[X,Y] = meshgrid(x,y);

figure (1)
subplot(1,2,1)
mesh(X,Y,DT)
xlabel('x (mm)','FontSize',15)
ylabel('y(mm)','FontSize',15)
zlabel('Dose (Gy/proton)','FontSize',15)
title ('a)','FontSize',15)
xlim([-5 5])
ylim([-5 5])
zlim([0 6*10^-7])

subplot(1,2,2)
mesh(X,Y,DAA)
xlabel('x (mm)','FontSize',15)
ylabel('y(mm)','FontSize',15)
zlabel('Dose (Gy/proton)','FontSize',15)
title ('b)','FontSize',15)
xlim([-5 5])
ylim([-5 5])
zlim([0 6*10^-7])

set((1),'Position', [0 0 800 600]);

%% Plot 
figure (2)
subplot(3,2,1)
imagesc(x,y,DT')
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
title('a)','FontSize',12)
xlim([-5 5])
ylim([-5 5])
c1 = colorbar;
c1.Label.String = 'Dose (Gy/proton)';
c1.FontSize = 12;
grid on


subplot(3,2,2)
imagesc(x,y,DAA')
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
title('b)','FontSize',12)
xlim([-5 5])
ylim([-5 5])
c2 = colorbar;
c2.Label.String = 'Dose (Gy/proton)';
c2.FontSize = 12;
grid on

subplot(3,2,[3 5])
plot(x,sum(DT,2)./length(x),'g','LineWidth',1)
hold on
plot(x,sum(DAA,2)./length(x),'r','LineWidth',1)
grid on
xlabel('x (mm)','FontSize',15)
ylabel('Dose (Gy/proton)','FontSize',15)
legend('Dose T','Dose AA','FontSize',12)
title('c)','FontSize',12)
xlim([-5 5])
ylim([0 0.4*10^-7])

subplot(3,2,[4 6])
plot(y,sum(DT,1)./length(y),'g','LineWidth',1)
hold on
plot(y,sum(DAA,1)./length(y),'r','LineWidth',1)
xlabel('y (mm)','FontSize',15)
ylabel('Dose (Gy/proton)','FontSize',15)
legend('Dose T','Dose AA','FontSize',12)
title('d)','FontSize',12)
xlim([-5 5])
ylim([0 0.4*10^-7])
grid on
set((2),'Position', [0 0 800 800]);

%%
D_Dif=abs(DT-DAA);
figure (3)
contourf(x,y,D_Dif')
xlabel('x (mm)','FontSize',15)
ylabel('y (mm)','FontSize',15)
c1 = colorbar;
c1.Label.String = 'Dose (Gy/proton)';
c1.FontSize = 12;
grid on
set((3),'Position', [0 0 800 600]);
xlim([-3 3])
ylim([-3 3])
%%%% Diferencia en porcentaje de cada bin
DOSETN=DT./max(max(DT))*100;
DOSEAAN = DAA./max(max(DAA))*100;
DifN = abs(1-DOSEAAN./DOSETN)*100;
mask = DOSETN>5;
Mean_Dif = mean(DifN(mask))
%% Gamma 3

percent = 0.5*max(max(DT)); % Gy/proton
dta = 3 ; %mm

reference.start = [x(1) y(1)];
reference.width = [dx dy];
reference.data = [DT];

target.start = [doseMap.minX doseMap.minY];
target.width = [doseMap.dx doseMap.dy];
target.data = [DAA];

gamma = CalcGamma(reference, target, percent, dta, 'local', 0);