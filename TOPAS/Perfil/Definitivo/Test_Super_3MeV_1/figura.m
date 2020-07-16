function figura(z_exp,sigmaX_exp,sigmaY_exp,linear_exp_X,linear_exp_Y,sigmaX,sigmaY,polyX,polyY,COMGX,numbfig,numbsubfig);
%%
%%
zz = [4.5:0.1:11.5];

%% Figure
figure (1)
%subplot(4,5,numbsubfig)
%Exp Sigma X
subplot(1,2,1)
errorbar(z_exp,sigmaX_exp(:,1),sigmaX_exp(:,2),'mo','MarkerSize',5)
hold on
plot(zz,polyval(linear_exp_X,zz),'m--','MarkerSize',5)
hold on
%Sim Sigma X
errorbar(z_exp,sigmaX(:,1),sigmaX(:,2),'rx','MarkerSize',5);
hold on
plot(zz,polyval(polyX,zz),'r','MarkerSize',5)
hold on
grid on
%title(COMGX)
xlabel('z (cm)','FontSize',15)
ylabel('\sigma (mm)','FontSize',15)
legend('\sigma_{X} Exp','P_{X} Exp','\sigma_{X} Sim','P_{Y} Sim','FontSize',10,'Location','northwest')
subplot(1,2,2)
%Exp Sigma Y
errorbar(z_exp,sigmaY_exp(:,1),sigmaY_exp(:,2),'co','MarkerSize',5);
hold on
plot(zz,polyval(linear_exp_Y,zz),'c--','MarkerSize',5)
hold on
%Sim Sigma Y
errorbar(z_exp,sigmaY(:,1),sigmaY(:,2),'bx','MarkerSize',5);
hold on
plot(zz,polyval(polyY,zz),'b','MarkerSize',5)
hold on
grid on
%title(COMGX)
xlabel('z (cm)','FontSize',15)
ylabel('\sigma (mm)','FontSize',15)
legend('\sigma_{Y} Exp','P_{X} Exp','\sigma_{Y} Sim','P_{Y} Sim','FontSize',10,'Location','northwest')
set((1),'Position', [0 0 800 600]);