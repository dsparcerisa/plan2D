clear all; close all

%%
load('DataX.mat')
RX0 = [reshape(ResX0,[length(MG20),length(SX0)])]';
RX1 = [reshape(ResX1,[length(MG21),length(SX1)])]';
RX2 = [reshape(ResX2,[length(MG22),length(SX2)])]';
MinRX0 = min(ResX0)
[a,b] = find(RX0 == min(ResX0));
MinSX0 = SX0(a)
MinMG2X0 = MG20(b)

MinRX = min(ResX2)
[a,b] = find(RX2 == min(ResX2));
MinSX = SX2(a)
MinMG2X = MG22(b)

figure (1)
subplot(1,2,1)
im=imagesc(SX0,MG20,RX0');
xlabel('SX0 (mm)','FontSize',15)
ylabel('MG2 (tesla/cm)','FontSize',15)
colormap(flipud(parula))
c1 = colorbar('Direction','reverse');
c1.Label.String = 'Residue x (mm)';
c1.FontSize = 12;
caxis([0.05 0.2])
title('a)','FontSize',12)

%subplot(1,3,2)
%imagesc(SX1,MG21,RX1')
%xlabel('\sigma_{x0} (mm)','FontSize',15)
%ylabel('MG2 (tesla/cm)','FontSize',15)
%c2 = colorbar;
%c2.Label.String = 'Residue x (mm)';
%c2.FontSize = 12;
%caxis([0 1])
%title('b)','FontSize',12)

subplot(1,2,2)
im=imagesc(SX2,MG22,RX2');
xlabel('SX0 (mm)','FontSize',15)
ylabel('MG2 (tesla/cm)','FontSize',15)
colormap(flipud(parula))
c1 = colorbar('Direction','reverse');
c1.Label.String = 'Residue x (mm)';
c1.FontSize = 12;
caxis([0.05 0.2])
title('b)','FontSize',12)


set((1),'Position', [0 0 800 600]);

%%
load('DataY.mat')
RY1a = [reshape(ResY1,[length(MG11),length(SY1)])]';
RY1b = [reshape(ResY1b,[length(MG11b),length(SY1)])]';
RY1 = [RY1a,RY1b];
RY2 = [reshape(ResY2,[length(MG12),length(SY2)])]';

MinRY1 = min(ResY1)
[a,b] = find(RY1 == min(ResY1));
MinSY1 = SY1(a)
MinMG2Y1 = MG11(b)

MinRY = min(ResY2)
[a,b] = find(RY2 == min(ResY2));
MinSY = SY2(a)
MinMG2Y = MG12(b)

figure (2)
subplot(1,2,1)
imagesc(SY1,[MG11,MG11b],RY1')
xlabel('SY0 (mm)','FontSize',15)
ylabel('MG1 (tesla/cm)','FontSize',15)
colormap(flipud(parula))
c1 = colorbar('Direction','reverse');
c1.Label.String = 'Residue y (mm)';
c1.FontSize = 12;
caxis([0.05 0.2])
title('a)','FontSize',12)

subplot(1,2,2)
imagesc(SY2,MG12,RY2')
xlabel('SY0 (mm)','FontSize',15)
ylabel('MG1 (tesla/cm)','FontSize',15)
colormap(flipud(parula))
c2 = colorbar('Direction','reverse');
c2.Label.String = 'Residue y (mm)';
c2.FontSize = 12;
caxis([0.05 0.2])
title('b)','FontSize',12)


set((2),'Position', [0 0 800 600]);