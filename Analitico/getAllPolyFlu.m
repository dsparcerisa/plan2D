clear all
close all

%%
EE = 1 : 8;
Dtype = 2; %1:Energy Deposit 2:Fluence 3:Dose
FluFileName = {'Resultados/Flu-1.csv','Resultados/Flu-2.csv','Resultados/Flu-3.csv','Resultados/Flu-4.csv','Resultados/Flu-5.csv','Resultados/Flu-6.csv','Resultados/Flu-7.csv','Resultados/Flu-8.csv'};
polyFluX = nan(length(EE),3,2);
polyFluY = nan(length(EE),3,2);
load('maxIndexEdep')
%%
for j = 1: length(EE);
    maxIndex = maxIndexEdep(j);
    E = EE(j);
    [D, D_STD, x, y, z] = getData(FluFileName{j});
    
    %% Normalization of the distribution
    NZ = length(z);
    DZ = nan(NZ,2);
    for i = 1 : NZ
        DZ(i,:) = [sum(sum(D(:,:,i))), sum(sum(D_STD(:,:,i)))];
    end
    DZ_norm = [DZ(:,1)./sum(DZ(:,1)),DZ(:,2)./sum(DZ(:,2))];
    DZV = DZ_norm(:,1);

    %% Index
      %The interpolation finishes at the maximum of energy deposition simulations
    %% Sigma Interpolation
    sigmaX = nan(NZ,2);
    sigmaY = nan(NZ,2);
    for i = maxIndex : NZ;
       try
       [sigmaX(i,:), sigmaY(i,:)] = getSigmaGauss(D(:,:,i), D_STD(:,:,i), x, y);
       catch
       end
    end
    %% Quadratic Fit
    [polyFluX(j,:,:), polyFluY(j,:,:)] = getQuadraticFit(z(maxIndex:NZ),sigmaX(maxIndex:NZ,:),sigmaY(maxIndex:NZ,:));
    %% Plot arrays
    zz=[0 :0.001: z(maxIndex)];
    YLabelD = {'Energy Deposit (%)', 'Fluence (%)', 'Dose (%)'};
    LegendD = {'Energy Deposit', 'Fluence', 'Dose'};


    %% Plot Fluence distribution
    figure (E)
    subplot(1,2,1)
    %errorbar(z,DoseZ_norm(:,1),DoseZ_norm(:,2),'MarkerSize',15);
    plot(z,DZ_norm(:,1),'LineWidth',2)
    hold on
    xlabel('z (cm)','FontSize',15)
    ylabel(YLabelD{Dtype},'FontSize',15)
    legend(LegendD{Dtype},'Location','NorthEast','FontSize',15)
    grid on

    %% Plot Sigma Distribution
    %Algunos puntos se han ajustado con un error muy grande que afean las
    %gráficas
    if E == 1;
        sigmaY(475,:)=nan; %Activar para Edep de 1 MeV
    elseif E== 4;
        sigmaX(448,:)=nan; %Activar para Edep de 4 MeV
    elseif E == 5;
        sigmaY(443:446,:) = nan; %Activar para Edep de 5 MeV
    elseif E == 8;
        sigmaY(421,:) = nan;
        sigmaY(449:450,:) = nan;%Activar para Edep de 8 MeV
    end

    subplot (1,2,2)
    errorbar(z,sigmaX(:,1),sigmaX(:,2),'r.','MarkerSize',1)
    hold on
    errorbar(z,sigmaY(:,1),sigmaY(:,2),'b.','MarkerSize',1)
    hold on
    plot(zz,polyval(polyFluX(j,:,1),zz),'r','LineWidth',1)
    hold on
    plot(zz,polyval(polyFluY(j,:,1),zz),'b','LineWidth',1)
    grid on
    xlabel('z (cm)','FontSize',15)
    ylabel('\sigma (mm)','FontSize',15)
    legend('\sigma _{X}','\sigma _{Y}','P_{X}','P_{Y}','FontSize',15,'Location','northwest')

    set((E),'Position', [0 0 800 600]);
    
end