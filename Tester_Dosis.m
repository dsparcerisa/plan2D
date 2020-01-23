clear all; close all

%Parámetros de geometría
sizeX = 1;
sizeY = 1;
NX=100;
NY=100;
dxy=sizeX/NX;
squareHalfSize = dxy/2;
D = createEmptyCG2D(dxy, sizeX, sizeY);
Xvalues = D.getAxisValues('X');
Yvalues = D.getAxisValues('Y');
Nprot=1e7;

%GetDoseMap parámetros
z = 10;
dz = 0.001;
targetSPR = 1;
N0 = createEmptyCG2D(dxy, sizeX, sizeY);
N0.data( (N0.getXindex(-squareHalfSize)):(N0.getXindex(squareHalfSize)), (N0.getYindex(-squareHalfSize)):(N0.getYindex(squareHalfSize))) = 1;
N0.data = N0.data ./ sum(N0.data(:));

%TOPAS
energy = [3,8]; %MeV
targetThum = [10,50,100]; %um
targetThcm = targetThum.*10^-4; %cm

MeanERROR = nan(length(energy),length(targetThum));
for i = 1:length(energy);
    meanErrorEnergy =nan(1,length(targetThum)); 
    for j = 1:length(targetThum);
        
        %Cargar Dosis
        [DoseZero,DoseWater] = loadDosis(energy(i),targetThum(j));
        DoseWater=Nprot.*DoseWater;
        
        %GetDoseMap
        P1 = getDoseMap(energy(i), z, dz, Nprot, targetThcm(j), targetSPR, N0);
        
        %Error
        ERROR = abs(P1.data-DoseWater)./DoseWater*100;
        h=find(ERROR~=Inf);
        meanErrorEnergy(j) = mean(mean(ERROR(h)));
        
        %Figuras
        
        figure
        subplot(1,2,1)
        imagesc(Xvalues,Yvalues,DoseWater);
        title(sprintf('TOPAS E0=%iMeV targetTh=%ium',energy(i),targetThum(j)))
        xlabel('X(cm)');
        ylabel('Y(cm)');
        subplot(1,2,2)
        imagesc(Xvalues,Yvalues,P1.data);
        title(sprintf('GetDoseMap E0=%iMeV targetTh=%ium',energy(i),targetThum(j)))
        xlabel('X(cm)');
        ylabel('Y(cm)');
        
    end
    MeanERROR(i,:) = meanErrorEnergy;
    %HISTOGRAMAS
    figure
    bar(targetThum,MeanERROR(i,:));
    title(sprintf('ERROR E0=%iMeV',energy(i)))
    xlabel('Target Thickness (um)');
    ylabel('Error (%)');
    
end









