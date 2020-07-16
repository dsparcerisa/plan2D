function getFigure(z,sigmaX_exp,sigmaY_exp,polyX_exp,polyY_exp,sigmaX,sigmaY,polyX,polyY)
% Generates a figure
%%
zz = [4.5:0.1:11.5];

%% Figure
figure (1)
%Exp Sigma X
subplot(1,2,1)
errorbar(z,sigmaX_exp(:,1),sigmaX_exp(:,2),'mo','MarkerSize',5)
hold on
plot(zz,polyval(polyX_exp,zz),'m--','MarkerSize',5)
hold on
%Sim Sigma X
errorbar(z,sigmaX(:,1),sigmaX(:,2),'rx','MarkerSize',5);
hold on
plot(zz,polyval(polyX,zz),'r','MarkerSize',5)
hold on

grid on
xlabel('z (cm)','FontSize',15)
ylabel('\sigma (mm)','FontSize',15)
legend('\sigma_{X} Exp','P_{X} Exp','\sigma_{X} Sim','P_{Y} Sim','FontSize',10,'Location','northwest')
title('a)','FontSize',12)

subplot(1,2,2)
%Exp Sigma Y
errorbar(z,sigmaY_exp(:,1),sigmaY_exp(:,2),'co','MarkerSize',5);
hold on
plot(zz,polyval(polyY_exp,zz),'c--','MarkerSize',5)
hold on
%Sim Sigma Y
errorbar(z,sigmaY(:,1),sigmaY(:,2),'bx','MarkerSize',5);
hold on
plot(zz,polyval(polyY,zz),'b','MarkerSize',5)
hold on

grid on
title('b)','FontSize',12)
xlabel('z (cm)','FontSize',15)
ylabel('\sigma (mm)','FontSize',15)
legend('\sigma_{Y} Exp','P_{X} Exp','\sigma_{Y} Sim','P_{Y} Sim','FontSize',10,'Location','northwest')
set((1),'Position', [0 0 800 600]);

end