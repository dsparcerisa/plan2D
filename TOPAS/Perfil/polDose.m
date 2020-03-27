dR = 0.01;
dZ = 0.02;
NR = 100;
NZ = 2000;
RMaxValues = dR * (1:NR);
RMinValues = RMaxValues - dR;
RValues = RMaxValues - dR/2;
ZMaxValues = dZ * (1:NZ);
ZMinValues = ZMaxValues - dZ;
ZValues = ZMaxValues - dZ/2;
[SDose] = loadDose(8);
%% Fit and plot  
    allSteps = 1:NZ;
    modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3);


    minVal = find(~isnan(SDose),1);
    maxVal = find(~isnan(SDose),1,'last');
    
    % Probar el peso como (1 + x - minVal).^(-2);
    w = (1 + minVal + allSteps).^(-2);
    w(isnan(SDose)) = nan;
    % plot(w)
    
    % Fit
    X = (ZValues(minVal:maxVal))';
    Y = (SDose(minVal:maxVal))';
    F = fit(X, Y, 'poly2');
    polyF = [F.p1 F.p2 F.p3];
    nlm = fitnlm(X,Y,modelFun,polyF,'Weight',w(minVal:maxVal));
    polyW = nlm.Coefficients.Estimate';
    polyDose = polyW;
    
    % Plot
    plot(X,Y,'b.');
    hold on
    plot(ZValues(1:maxVal), modelFun(polyF,ZValues(1:maxVal)), 'r-');
    plot(ZValues(1:maxVal), modelFun(polyW,ZValues(1:maxVal)), 'g-');    
    

