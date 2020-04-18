function [R80D,R80D_error]=BraggPeak(ZValues,EdepZ,EdepSTDZ,energy,SimulationNumber)

Direction = sprintf('%iMeV/Sim%i/Images/',energy,SimulationNumber);
etiqueta = sprintf('_%iMeV_Sim%i',energy,SimulationNumber);

%Bragg Peak Analysis R80D
results = analyseBP(ZValues,EdepZ,'Method','full','AccuracySpline',0.001,'AccuracyBortfeld',0.001,'levelPoly',0.7);
R80D = mean([results.spline.R80D,results.poly3.R80D,results.bortfeld.R80D]);

%NSIT PSTAR data
Range = [4 2.839E-02;8 9.493E-02]; %[MeV, g/cm2)
rho_air =  0.00129; %g/cm3
R = Range(find(Range==energy),2)/rho_air; 

R80D_error = abs(1-R80D/R)*100;
sprintf('The simulated range is %.2fcm with an error of %.2f%%',R80D,R80D_error)

Vertical = linspace(0,EdepZ(find(abs(ZValues-R80D)<0.01)),100);
x_Vertical = R80D.*ones(1,length(Vertical));
figure (7)
errorbar(ZValues,EdepZ,EdepSTDZ);
hold on
plot(x_Vertical,Vertical);
xlabel('Z (cm)','FontSize',20)
ylabel('E (MeV)','FontSize',20)
legend('Simulated Energy Deposition','R80D','Location','NorthWest','FontSize',15)
set((7),'Position', [0 0 800 600]);
saveas(gcf,[Direction,'Range',etiqueta,'.png'])

