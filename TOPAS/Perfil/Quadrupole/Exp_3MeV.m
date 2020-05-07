close all
clear all



[ZValues_exp,SEdepX_exp,SEdepY_exp,nlm_exp_X,nlm_exp_Y] = Exp_3MeV_Data;

zz = [4:0.01:12.5];

%% Figure experimental data
figure (3)
errorbar(ZValues_exp,SEdepX_exp(1,:),SEdepX_exp(2,:),'bo','MarkerSize',7);
hold on
plot(zz,feval(nlm_exp_X,zz),'b')
errorbar(ZValues_exp,SEdepY_exp(1,:),SEdepY_exp(2,:),'rx','MarkerSize',7);
hold on
plot(zz,feval(nlm_exp_Y,zz),'r')
grid on
hold on
xlabel('Z (cm)','FontSize',20)
ylabel('\sigma (mm)','FontSize',20)
legend('\sigma_x exp','poly \sigma_x','\sigma_y exp','poly \sigma_y','FontSize',15,'Location','NorthWest')
set((3),'Position', [0 0 800 600]);


