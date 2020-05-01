clear all
close all
%%
Q1_Y = [0:0.001:0.2];
Q1_X = 0.5*ones(1,length(Q1_Y));

Q2_Y = [0:0.001:0.2];
Q2_X = 1.5*ones(1,length(Q2_Y));

%% SEdep después del Quadrupolo
EdepFileName = 'Edep_PhantomXY.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY.csv';
NZ = 100;
NXY = 100;
[SEdepX,SEdepY] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues = 0.05:0.1:9.95;

%% Figura
figure (10)
plot(ZValues,SEdepX(:,1),'r+','MarkerSize',10);
hold on
plot(ZValues,SEdepY(:,1),'b+','MarkerSize',10);
hold on
plot(Q1_X,Q1_Y,'k',Q2_X,Q2_Y,'k')
hold on
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (cm)','FontSize',20)
legend('\sigma_x Weighted','\sigma_y Weighted','FontSize',15,'Location','NorthWest')
set((10),'Position', [0 0 800 600]);

%% Fit Después del Quadrupole
ZValues1 = ZValues(21:100);
SEdepX1 = SEdepX(21:100,:);
SEdepY1 = SEdepY(21:100,:);
SEdepR = sqrt(SEdepX1(:,1).^2+SEdepY1(:,1).^2);
SEdepR_STD = sqrt((2.*SEdepX1(:,1).*SEdepX1(:,2)).^2+(2.*SEdepY1(:,1).*SEdepY1(:,2)).^2);

modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3); 

w = (SEdepR_STD).^(-2);
X = ZValues1';
Y = SEdepR;
polyF = fit(X, Y,'poly2');
polyF = [polyF.p1 polyF.p2 polyF.p3];
nlm = fitnlm(X,Y,modelFun,polyF,'Weight',w);
polyEdep = nlm.Coefficients.Estimate'
