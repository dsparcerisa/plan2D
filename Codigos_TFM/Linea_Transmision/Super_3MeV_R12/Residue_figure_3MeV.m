clear all; close all

%%
load('DataX.mat')
RX1 = [reshape(ResX1,[length(MG21),length(SX1)])]';
RX2 = [reshape(ResX2,[length(MG22),length(SX2)])]';


figure (1)
subplot(1,2,1)
imagesc(SX1,MG21,RX1')
xlabel('\sigma_{x0} (mm)','FontSize',15)
ylabel('MG2 (tesla/cm)','FontSize',15)
c1 = colorbar;
c1.Label.String = 'Residue x (mm)';
c1.FontSize = 12;
title('a)','FontSize',12)

subplot(1,2,2)
imagesc(SX2,MG22,RX2')
xlabel('\sigma_{x0} (mm)','FontSize',15)
ylabel('MG2 (tesla/cm)','FontSize',15)
c2 = colorbar;
c2.Label.String = 'Residue x (mm)';
c2.FontSize = 12;
title('b)','FontSize',12)


set((1),'Position', [0 0 800 600]);

%%
load('DataY.mat')
RY1 = [reshape(ResY1,[length(MG11),length(SY1)])]';
RY2 = [reshape(ResY2,[length(MG12),length(SY2)])]';


figure (2)
subplot(1,2,1)
imagesc(SY1,MG11,RY1')
xlabel('\sigma_{y0} (mm)','FontSize',15)
ylabel('MG1 (tesla/cm)','FontSize',15)
c1 = colorbar;
c1.Label.String = 'Residue y (mm)';
c1.FontSize = 12;
title('a)','FontSize',12)

subplot(1,2,2)
imagesc(SY2,MG12,RY2')
xlabel('\sigma_{y0} (mm)','FontSize',15)
ylabel('MG1 (tesla/cm)','FontSize',15)
c2 = colorbar;
c2.Label.String = 'Residue y (mm)';
c2.FontSize = 12;
title('b)','FontSize',12)


set((2),'Position', [0 0 800 600]);