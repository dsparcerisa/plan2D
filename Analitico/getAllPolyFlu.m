clear all
close all

%%
EE = 3 : 8;
Dtype = 2; %1:Energy Deposit 2:Fluence 3:Dose
FluFileName = {'Resultados/Flu-3.csv','Resultados/Flu-4.csv','Resultados/Flu-5.csv','Resultados/Flu-6.csv','Resultados/Flu-7.csv','Resultados/Flu-8.csv'};
polyFlu = nan(length(EE),3,2);
load('maxIndexEdep')
%%
for j = 1 : length(EE);
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
    [polyFlu(j,:,1), polyFlu(j,:,2)] = getQuadraticFit(z(maxIndex:NZ),sigmaX(maxIndex:NZ,:),sigmaY(maxIndex:NZ,:));
    %% Plot arrays
    zz=[0 :0.001: z(maxIndex)];
    YLabelD = {'Energy Deposit (%)', 'Fluence (%)', 'Dose (%)'};
    LegendD = {'Energy Deposit', 'Fluence', 'Dose'};


    %% Plot Dose distribution
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
    subplot (1,2,2)
    errorbar(z,sigmaX(:,1),sigmaX(:,2),'r.','MarkerSize',1)
    hold on
    errorbar(z,sigmaY(:,1),sigmaY(:,2),'b.','MarkerSize',1)
    hold on
    plot(zz,polyval(polyFlu(j,:,1),zz),'r','LineWidth',1)
    hold on
    plot(zz,polyval(polyFlu(j,:,2),zz),'b','LineWidth',1)
    grid on
    xlabel('z (cm)','FontSize',15)
    ylabel('\sigma (mm)','FontSize',15)
    legend('\sigma _{X}','\sigma _{Y}','P_{X}','P_{Y}','FontSize',15,'Location','northwest')

    set((E),'Position', [0 0 800 600]);
    
end