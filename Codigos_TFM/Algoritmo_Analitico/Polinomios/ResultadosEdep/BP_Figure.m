clear all
close all
%%
EdepFileName = {'Edep-1.csv','Edep-2.csv','Edep-3.csv','Edep-4.csv','Edep-5.csv','Edep-6.csv','Edep-7.csv','Edep-8.csv'};
%
figure (1)
for j = 1:8;
    Edep = importEdep(EdepFileName{j});
    z=[0.05:0.1:99.95];
    hold on
    plot(z,flip(Edep),'LineWidth',2)

end
hold on
xlabel('z (cm)','FontSize',15)
ylabel('Energy Deposit (MeV/proton)','FontSize',15)
legend('1 MeV', '2 MeV', '3 MeV', '4 MeV', '5 MeV','6 MeV','7 MeV','8 MeV','Location','NorthEast','FontSize',15)
grid on
set((1),'Position', [0 0 800 600]);
%%
Edep5 = importEdep(EdepFileName{5});
z=[0.05:0.1:99.95];
hold on
[R80D]=BraggPeak(z,flipud(Edep5))