clear all
close all

SimulationNumber = input('Máquina qué simulacion es esta?') ; %Ir cambiando
[SEdep,SEdep_weighted,NR,NZ,dR,dZ,spreadX,spreadY,angularspreadX,angularspreadY,energy,N_histories] = loadEdep(SimulationNumber);
Direction = sprintf('%iMeV/Sim%i/Images/',energy,SimulationNumber);
etiqueta = sprintf('_%iMeV_Sim%i',energy,SimulationNumber);
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
    
    w = (SEdep_weighted_error).^(-2);
    
    % Fit
    X = (ZValues(minVal:maxVal))';
    Y = (SEdep_weighted(minVal:maxVal))';
    polyF = fit(X, Y,'poly2');
    polyF = [polyF.p1 polyF.p2 polyF.p3];
    nlm = fitnlm(X,Y,modelFun,polyF,'Weight',w(minVal:maxVal));
    polyW = nlm.Coefficients.Estimate';
    polyEdep = polyW
    
    % Plot

    figure (4)
    plot(ZValues(1:maxVal), modelFun(polyF,ZValues(1:maxVal)), 'r-');
    hold on
    plot(ZValues(1:maxVal), modelFun(polyW,ZValues(1:maxVal)), 'g-');
    xlabel('Z (cm)','FontSize',20)
    ylabel('\sigma (cm)','FontSize',20)
    legend('Unweighted Simulated Polynomial','Weighted Simulated Polynomial','Location','NorthWest','FontSize',15)
    grid on
    set((4),'Position', [0 0 800 600]);
    saveas(gcf,[Direction,'polynomials_weighted_unweighted',etiqueta,'.png'])
    %% Comparison polynomials
    
    [nlm_exp,Z_exp,Sigma_exp] = polExp;
    poly_exp = [nlm_exp.Coefficients.Estimate,nlm_exp.Coefficients.SE];
    poly_sim = [nlm.Coefficients.Estimate,nlm.Coefficients.SE];
    ZZ = 4:0.02:15;
    figure (5)
    plot(ZZ,polyval(poly_exp(:,1)',ZZ),'g');
    hold on
    plot(ZZ,polyval(poly_sim(:,1)',ZZ),'r')
    plot(Z_exp,Sigma_exp,'rx','MarkerSize',15)
    ylabel('\sigma (cm)','FontSize',20)
    xlabel('Z (cm)','FontSize',20)
    grid on
    set((5),'Position', [0 0 800 600]);

    hold on
    plot(Z_exp,polyval(poly_sim(:,1)',Z_exp),'bx','MarkerSize',15)
    hold on
    legend('Experimental Polynomial','Simulated Polynomial','Experimental Data','Interpolated Data','Location','NorthWest','FontSize',15)
    saveas(gcf,[Direction,'residues',etiqueta,'.png'])
    residue_i = (Sigma_exp-polyval(poly_sim(:,1)',Z_exp)).^2;
    residue = sum(residue_i);
    
    
    %[inliers] = interval_error(SEdep_exp', SEdep_exp_error', SEdep_sim', SEdep_sim_error')
    
    
    %% Save data and results
    Directory = sprintf('%iMeV/Sim%i',energy,SimulationNumber);
    save([Directory,'/Data.mat'],'NR','NZ','dR','dZ','energy','N_histories','SimulationNumber','spreadX','spreadY','angularspreadX','angularspreadY')
    save([Directory,'/Results.mat'],'polyEdep','nlm','nlm_exp','ZValues','RValues','SEdep','SEdep_weighted','SEdep_weighted_error','residue_i','residue')
    copyfile('SIN_DIFUSOR.txt',Directory);
    copyfile('Edep.csv',Directory);
    copyfile('Edep_STD.csv',Directory);
    

