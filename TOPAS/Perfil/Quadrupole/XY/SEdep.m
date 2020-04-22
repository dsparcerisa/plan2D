clear all
close all
%% SEdep en el Quadrupolo 1
EdepFileName = 'Edep_PhantomXY_Q.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY_Q.csv';
NZ = 25;
NXY = 100;
[SEdepX_Q1,SEdepY_Q1] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues_Q1 = 0.01:0.02:0.49;
Q1_Y = [0:0.001:0.2];
Q1_X = 0.5*ones(1,length(Q1_Y));
%% SEdep en el Quadrupolo 2
EdepFileName = 'Edep_PhantomXY_Q2.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY_Q2.csv';
NZ = 25;
NXY = 100;
[SEdepX_Q2,SEdepY_Q2] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues_Q2 = 0.51:0.02:0.99;
Q2_Y = [0:0.001:0.2];
Q2_X = 1*ones(1,length(Q2_Y));

%% SEdep después del Quadrupolo
EdepFileName = 'Edep_PhantomXY.csv';
Edep_STDFileName = 'Edep_STD_PhantomXY.csv';
NZ = 250;
NXY = 100;
[SEdepX,SEdepY] = loadSEdep_XY(EdepFileName,Edep_STDFileName,NZ,NXY);
ZValues = 1.01:0.02:5.99;

%% Figura
figure (10)
plot([ZValues_Q1,ZValues_Q2,ZValues],[SEdepX_Q1(:,1);SEdepX_Q2(:,1);SEdepX(:,1)],'r+','MarkerSize',10);
hold on
plot([ZValues_Q1,ZValues_Q2,ZValues],[SEdepY_Q1(:,1);SEdepY_Q2(:,1);SEdepY(:,1)],'b+','MarkerSize',10);
hold on
plot(Q1_X,Q1_Y,'k',Q2_X,Q2_Y,'k')
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
