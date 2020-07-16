clear all; close all; 
%% Datos
load('allDoses.mat')
load('polyR12.mat')
%Reordenar
allD_HD = {allD_HD{1},allD_HD{3},allD_HD{5},allD_HD{2},allD_HD{4}};
allD_LD = {allD_LD{1},allD_LD{3},allD_LD{5},allD_LD{2},allD_LD{4}};
zValues = [4.9:1.5:10.9];
% Datos
DExp_Ef = nan(5,1);
DA_A = nan(5,1);
Ef_RC = [1 0.986  0.967 0.941 0.899]'; %Eficiencia
dTarget = 14*10^-4; %cm
rho_Target = 1.2; %g/cm3
targetTh = dTarget*rho_Target; %g/cm2
targetSPR = 1;
% Activar High Dose
I = [1.2  2 1.65 2.05 2.2];
DOSE = allD_HD; Nprot = (10^-9*6*0.75*10^-3)/(1.6022*10^-19);
Title = {'6 Flash shots z = 4.9 cm','6 Flash shots z = 6.4 cm','6 Flash shots z = 7.9 cm','6 Flash shots z = 9.4 cm','6 Flash shots z = 10.9 cm'};

% Activar Low Dose
%DOSE = allD_LD;   Nprot = (6.4*10^-9*2*0.73*10^-3)/(1.6022*10^-19);
%Title = {'2 Flash shots z = 4.9 cm','2 Flash shots z = 6.4 cm','2 Flash shots z = 7.9 cm','2 Flash shots z = 9.4 cm','2 Flash shots z = 10.9 cm'};

for i =1;
    % Poner a cero los puntos experimentales menores que cero
    Dose = DOSE{i};
    %mask0 = Dose < 0;
    %Dose(mask0) = 0;
    Dose_Ef = Dose./Ef_RC(i);
    %% Dimensiones
    z = zValues(i); %cm
    [n,l]=size(Dose_Ef);
    sizeX = n/pixelsXcm*10;%mm
    sizeY = l/pixelsXcm*10;%mm
    dx = sizeX/n; %mm
    dy = sizeY/l; %mm
    beamProfile = createEmptyCG2D(dx,dy, sizeX, sizeY);
    x = beamProfile.getAxisValues('X');
    y = beamProfile.getAxisValues('Y');
    
    %% Sacar Sigma de los polinomios de interpolacion
    [sigmaX, sigmaY] = getSigma(polyXR12,polyYR12, 1, z, dTarget);
    
    %% Sacar origen
    FGX = fit(x',sum(Dose_Ef,2),'gauss1');
    X0 = FGX.b1; %mm
    FGY = fit(y',sum(Dose_Ef,1)','gauss1');
    Y0 = FGY.b1; %mm
    
    %% Perfil de Fluencia
    [FluenceProfile] = createFluenceProfile(dx,dy, sizeX, sizeY,sigmaX(1),sigmaY(1),X0,Y0);
    
    %% Mapa de dosis
    doseMap = getDoseMap(FluenceProfile, 3, z, Nprot*I(i), targetTh, targetSPR);
    DAA = doseMap.data;
    
    %% Dosis totales
    DExp_Ef(i,1) = (sum(sum(Dose_Ef)))/(n*l);
    DA_A(i,1) = (sum(sum(DAA)))/(n*l);
    %% Plot 
    figure (i)
    subplot(3,2,1)
    imagesc(x,y,Dose_Ef')
    xlabel('x (mm)','FontSize',15)
    ylabel('y (mm)','FontSize',15)
    title(['Exp ',Title{i}],'FontSize',15)
    grid on

    subplot(3,2,2)
    imagesc(x,y,DAA')
    xlabel('x (mm)','FontSize',15)
    ylabel('y (mm)','FontSize',15)
    title(['AA ',Title{i}],'FontSize',15)
    grid on

    subplot(3,2,[3 5])
    plot(x,sum(Dose_Ef,2)./n,'g','LineWidth',1)
    hold on
    plot(x,sum(DAA,2)./n,'r','LineWidth',1)
    grid on
    xlabel('x (mm)','FontSize',15)
    ylabel('Dose (Gy)','FontSize',15)
    legend('Dose Exp','Dose AA','FontSize',12)


    subplot(3,2,[4 6])
    plot(y,sum(Dose_Ef,1)./l,'g','LineWidth',1)
    hold on
    plot(y,sum(DAA,1)./l,'r','LineWidth',1)
    xlabel('y (mm)','FontSize',15)
    ylabel('Dose (Gy)','FontSize',15)
    legend('Dose Exp','Dose AA','FontSize',12)

    grid on
    set((i),'Position', [0 0 800 800]);
end
table(zValues',DExp_Ef,DA_A)

