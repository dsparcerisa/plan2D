clear all
close all
%%
load('polyFlu.mat')

figure (1)
subplot(3,2,[3 5])
plot([0.05:0.1: getCSDA(1)], polyval(polyFluX(1,:,1),0.05:0.1:getCSDA(1)),'LineWidth',2);
subplot(3,2,[4 6])
plot([0.05:0.1:getCSDA(1)], polyval(polyFluY(1,:,1),0.05:0.1:getCSDA(1)),'LineWidth',2);
for i = 2 : 8;
    subplot(3,2,[3 5])
    hold on
    plot([0.05:0.1: getCSDA(i)], polyval(polyFluX(i,:,1),0.05:0.1:getCSDA(i)),'LineWidth',2);
    subplot(3,2,[4 6])
    hold on
    plot([0.05:0.1: getCSDA(i)], polyval(polyFluY(i,:,1),0.05:0.1:getCSDA(i)),'LineWidth',2);
end
subplot(3,2,[3 5])
legend('1 MeV', '2 MeV', '3 MeV', '4 MeV', '5 MeV','6 MeV','7 MeV','8 MeV','Location','NorthWest','FontSize',15)
grid on
xlabel('z (cm)','FontSize',15)
ylabel('\sigma_{x} (mm)','FontSize',15)
title('b)','FontSize',15)
subplot(3,2,[4 6])
legend('1 MeV', '2 MeV', '3 MeV', '4 MeV', '5 MeV','6 MeV','7 MeV','8 MeV','Location','NorthWest','FontSize',15)
grid on
xlabel('z (cm)','FontSize',15)
ylabel('\sigma_{y} (mm)','FontSize',15)
title('c)','FontSize',15)
set((1),'Position', [0 0 800 800]);
%%
EdepFileName = {'Edep-1.csv','Edep-2.csv','Edep-3.csv','Edep-4.csv','Edep-5.csv','Edep-6.csv','Edep-7.csv','Edep-8.csv'};
%
figure (1)
for j = 1:8;
    Edep = importEdep(EdepFileName{j});
    z=[0.05:0.1:99.95];
    subplot(3,2,[1 2])
    hold on
    plot(z,flip(Edep),'LineWidth',2)

end
subplot(3,2,[1 2])
xlabel('z (cm)','FontSize',15)
ylabel('Energy Deposit (MeV/proton)','FontSize',15)
legend('1 MeV', '2 MeV', '3 MeV', '4 MeV', '5 MeV','6 MeV','7 MeV','8 MeV','Location','NorthEast','FontSize',15)
title('a)','FontSize',15)
grid on
set((1),'Position', [0 0 800 800]);
%%
Edep5 = importEdep(EdepFileName{5});
z=[0.05:0.1:99.95];
hold on
[R80D]=BraggPeak(z,flipud(Edep5))