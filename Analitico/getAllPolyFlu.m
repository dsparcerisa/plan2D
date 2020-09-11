clear all
close all
 
%%
EE = 1:8;
Dtype = 2; %1:Energy Deposit 2:Fluence 3:Dose
FluFileName = {'Resultados/Flu-1.csv','Resultados/Flu-2.csv','Resultados/Flu-3.csv','Resultados/Flu-4.csv','Resultados/Flu-5.csv','Resultados/Flu-6.csv','Resultados/Flu-7.csv','Resultados/Flu-8.csv'};
polyFluX = nan(length(EE),3,2);
polyFluY = nan(length(EE),3,2);
load('maxIndexEdep')

for j = 1%1: length(EE);
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
    DZ_max = DZ(:,1)./max(max(DZ(:,1)));
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
    plot(z,DZ_max(:,1).*100,'LineWidth',2)
    hold on
    xlabel('z (cm)','FontSize',15)
    ylabel(YLabelD{Dtype},'FontSize',15)
    legend(LegendD{Dtype},'Location','NorthEast','FontSize',15)
    title('a)','FontSize',12)
    grid on

    %% Plot Sigma Distribution
    %Algunos puntos se han ajustado con un error muy grande que afean las
    %gráficas
    if E == 1;
       sigmaY(385,:)=nan;
       sigmaX(491,:)=nan;
       sigmaX(495:498,:)=nan;
       sigmaX(278,:)=nan;
        sigmaY(486:487,:)=nan;
       sigmaY(475,:)=nan;
       sigmaY(479,:)=nan;
       sigmaY(491,:)=nan;
    elseif E == 6;
       sigmaX(231,:)=nan;
       sigmaX(257,:)=nan;
       sigmaX(259,:)=nan;
       sigmaX(278,:)=nan;
       sigmaY(222,:)=nan;
       sigmaY(258,:)=nan;
       sigmaY(286,:)=nan;
       sigmaY(222,:)=nan;
       sigmaY(259,:)=nan;
       sigmaY(293,:)=nan;
       sigmaY(299,:)=nan;
       sigmaY(313,:)=nan;
       sigmaX(392,:)=nan; %Activar para Edep de 6 MeV
       sigmaX(382,:)=nan;
       sigmaY(371,:)=nan; 
    elseif E== 7;
       sigmaX(186,:)=nan;
       sigmaX(194,:)=nan;
       sigmaX(195,:)=nan;
       sigmaX(229,:)=nan;
       sigmaX(252,:)=nan;
       sigmaX(255,:)=nan;
       sigmaY(208,:)=nan;
       sigmaY(222,:)=nan;
       sigmaY(237,:)=nan;
       sigmaY(250,:)=nan;
       sigmaY(269,:)=nan;
       sigmaY(277,:)=nan;
       sigmaY(281:282,:)=nan;
       sigmaY(310,:)=nan;
       sigmaY(326,:)=nan; %Activar para Edep de 4 MeV
       sigmaY(340,:)=nan;
       sigmaY(359,:)=nan;
       sigmaY(383,:)=nan;
    %elseif E == 5;
    %    sigmaY(443:446,:) = nan; %Activar para Edep de 5 MeV
    elseif E == 8;
       sigmaX(145,:) = nan;
       sigmaX(155,:) = nan;
       sigmaX(159,:) = nan;
       sigmaX(167,:) = nan;
       sigmaX(192,:) = nan;
       sigmaX(197,:) = nan;
       sigmaX(198,:) = nan;
       sigmaX(204,:) = nan;
       sigmaX(211,:) = nan;
       sigmaX(222,:) = nan;
       sigmaX(375,:) = nan;
       sigmaX(367,:) = nan;
       sigmaX(380,:) = nan;
       sigmaX(398,:) = nan;
       sigmaY(378,:) = nan;
       sigmaY(178,:) = nan;
       sigmaY(182,:) = nan;
       sigmaY(193,:) = nan;
       sigmaY(206,:) = nan;
       sigmaY(211,:) = nan;
       sigmaY(217,:) = nan;
       sigmaY(235,:) = nan;
       sigmaY(243,:) = nan;
       sigmaY(248,:) = nan;
       sigmaY(255,:) = nan;
       sigmaY(276,:) = nan;
       sigmaY(378,:) = nan;
       sigmaY(394,:) = nan;
       % sigmaY(369,:) = nan;
       % sigmaY(372,:) = nan;
       % sigmaY(370,:) = nan;
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
    title('b)','FontSize',12)

    set((E),'Position', [0 0 800 600]);
    
end