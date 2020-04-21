clear all
close all
%% SEdep en el Quadrupolo
EdepFileName = 'Edep_PhantomXY_Q.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY_Q.csv';
NZ = 50;
NXY = 100;
[SEdepX_Q,SEdepY_Q] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues_Q = 0.01:0.02:0.99;
Q_Y = [0:0.001:0.2];
Q_X = 1*ones(1,length(Q_Y));

%% SEdep después del Quadrupolo
EdepFileName = 'Edep_PhantomXY.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY.csv';
NZ = 250;
NXY = 100;
[SEdepX,SEdepY] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues = 1.01:0.02:5.99;

%% Figura
figure (10)
plot([ZValues_Q,ZValues],[SEdepX_Q(:,1);SEdepX(:,1)],'r+','MarkerSize',10);
hold on
plot([ZValues_Q,ZValues],[SEdepY_Q(:,1);SEdepY(:,1)],'b+','MarkerSize',10);
hold on
plot(Q_X,Q_Y,'k')
hold on
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (cm)','FontSize',20)
legend('\sigma_x Weighted','\sigma_y Weighted','FontSize',15,'Location','NorthWest')
set((10),'Position', [0 0 800 600]);

%% Fit Después del Quadrupole

SEdepR = sqrt(SEdepX(:,1).^2+SEdepY(:,1).^2);
SEdepR_STD = sqrt((2.*SEdepX(:,1).*SEdepX(:,2)).^2+(2.*SEdepY(:,1).*SEdepY(:,2)).^2);

modelFun = @(b,x) b(1)*x.^2 + b(2)*x + b(3); 

w = (SEdepR_STD).^(-2);
X = ZValues';
Y = SEdepR;
polyF = fit(X, Y,'poly2');
polyF = [polyF.p1 polyF.p2 polyF.p3];
nlm = fitnlm(X,Y,modelFun,polyF,'Weight',w);
polyEdep = nlm.Coefficients.Estimate'
