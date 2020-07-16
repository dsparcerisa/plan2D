 function [R80D]=BraggPeak(ZValues,EdepZ)

%Bragg Peak Analysis R80D
results = analyseBP(ZValues,EdepZ,'Method','full','AccuracySpline',0.001,'AccuracyBortfeld',0.001,'levelPoly',0.7);
R80D = mean([results.spline.R80D,results.poly3.R80D,results.bortfeld.R80D]);


Vertical = linspace(0,EdepZ(find(abs(ZValues-R80D)<0.05)-12),100);
x_Vertical = R80D.*ones(1,length(Vertical));
figure (7)
plot(ZValues(1:700),EdepZ(1:700),'b','LineWidth',2);
hold on
plot(x_Vertical,Vertical,'r','LineWidth',2);
xlabel('z (cm)','FontSize',15)
ylabel('Energy Deposit (MeV/proton)','FontSize',15)
legend('Energy Deposit','R80D','Location','NorthWest','FontSize',15)
grid on
set((7),'Position', [0 0 800 600]);

