clear all
close all

SimulationNumber = input('Máquina qué simulacion es esta?') ; %Ir cambiando
[SEdep,SEdep_weighted,NR,NZ,dR,dZ,spreadX,spreadY,angularspreadX,angularspreadY,energy,N_histories] = loadEdep(SimulationNumber);
SEdep_weighted_error = SEdep_weighted(2,:);
SEdep_weighted = SEdep_weighted(1,:);
RMaxValues = dR * (1:NR);
RMinValues = RMaxValues - dR;
RValues = RMaxValues - dR/2;
ZMaxValues = dZ * (1:NZ);
ZMinValues = ZMaxValues - dZ;
ZValues = ZMaxValues - dZ/2;

%% Fit and plot  
    allSteps = 1:NZ;
    modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);


    minVal = find(~isnan(SEdep_weighted),1);
    maxVal = find(~isnan(SEdep),1,'last');
    
    % Probar el peso como (1 + x - minVal).^(-2);
    w = (SEdep_weighted_error).^(-2);
    % plot(w)
    
    % Fit
    X = (ZValues(minVal:maxVal))';
    Y = (SEdep_weighted(minVal:maxVal))';
    polyF = fit(X, Y,'poly2');
    polyF = [polyF.p1 polyF.p2 polyF.p3];
    nlm = fitnlm(X,Y,modelFun,polyF,'Weight',w(minVal:maxVal));
    polyW = nlm.Coefficients.Estimate';
    polyEdep = polyW
    
    % Plot

    hold on
    plot(ZValues(1:maxVal), modelFun(polyF,ZValues(1:maxVal)), 'r-');
    plot(ZValues(1:maxVal), modelFun(polyW,ZValues(1:maxVal)), 'g-');
    
    %%
    
    %% Save data and results
    Directory = sprintf('%iMeV/Sim%i',energy,SimulationNumber);
    savefig([Directory,'/SEdep.fig'])
    save([Directory,'/Data.mat'],'NR','NZ','dR','dZ','energy','N_histories','SimulationNumber','spreadX','spreadY','angularspreadX','angularspreadY')
    save([Directory,'/Results.mat'],'polyEdep','polyF','ZValues','RValues','SEdep')
    copyfile('SIN_DIFUSOR.txt',Directory);
    copyfile('Edep.csv',Directory);
    copyfile('Edep_STD.csv',Directory);
    

