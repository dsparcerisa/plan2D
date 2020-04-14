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
    
    %% Comparison polynomials
    
    [nlm_exp,Z_exp,Sigma_exp] = polExp;
    poly_exp = [nlm_exp.Coefficients.Estimate,nlm_exp.Coefficients.SE];
    poly_sim = [nlm.Coefficients.Estimate,nlm.Coefficients.SE];
    ZZ = 4:0.02:15;
    SEdep_exp = polyval(poly_exp(:,1)',ZZ);
    SEdep_exp_error = sqrt(((ZZ.^2)*poly_exp(1,2)).^2+(ZZ.*poly_exp(2,2)).^2+(poly_exp(3,2)).^2+((2*poly_exp(1,1).*ZZ+poly_exp(2,1)).*(0.1)).^2);
    SEdep_sim = polyval(poly_sim(:,1)',ZZ);
    SEdep_sim_error = sqrt(((ZZ.^2)*poly_sim(1,2)).^2+(ZZ.*poly_sim(2,2)).^2+(poly_sim(3,2)).^2); 
    
    figure
    errorbar(ZZ,SEdep_exp,SEdep_exp_error,'g');
    hold on
    plot(ZZ,SEdep_exp)
    plot(Z_exp,Sigma_exp,'rx','MarkerSize',20)
    ylabel('\sigma (cm)','FontSize',20)
    xlabel('Z (cm)','FontSize',20)
    hold on
    errorbar(ZZ,SEdep_sim,SEdep_sim_error,'k');
    grid on
    %% Residue and interval error
    residue = (SEdep_exp-SEdep_sim).^2;
    stdResidue = std(residue);
    figure
    plot(ZZ, residue, 'o');
    outlierMask = residue>stdResidue;
    hold on
    plot(ZZ(outlierMask), residue(outlierMask), 'rx')
    plot([1 15], [stdResidue stdResidue], 'k:');
    
    [inliers] = interval_error(SEdep_exp', SEdep_exp_error', SEdep_sim', SEdep_sim_error');
    IN = (length(find(inliers==1)))/length(inliers)*100;
    OUT = 100-IN;
    Percentage_error = table(IN,OUT);
    
    %% Save data and results
    Directory = sprintf('%iMeV/Sim%i',energy,SimulationNumber);
    savefig([Directory,'/SEdep.fig'])
    save([Directory,'/Data.mat'],'NR','NZ','dR','dZ','energy','N_histories','SimulationNumber','spreadX','spreadY','angularspreadX','angularspreadY')
    save([Directory,'/Results.mat'],'polyEdep','polyF','ZValues','RValues','SEdep')
    copyfile('SIN_DIFUSOR.txt',Directory);
    copyfile('Edep.csv',Directory);
    copyfile('Edep_STD.csv',Directory);
    

