%% load data
clear all
close all
load('tablas_logs_NON_FLASH')
TABLA = who;

%% Time-shots
shots = [];
Time = [];
for i = [1:37,39:length(TABLA)];
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.Tiempo_apertura_teorico_s];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];     
end
subplot(2,1,1)
validPoints = ~isoutlier(Time,'percentiles', [1 99]);
validShots = shots(validPoints);
validTime = Time(validPoints);

lin_T = polyfit(validShots,validTime,1)
F = 0:0.01:50;
FF = polyval(lin_T,F);

plot(validShots,validTime,'bx','MarkerSize',5)
hold on
plot(F,FF,':','LineWidth',1)

grid on

subplot(2,1,2)
residue = (validTime - polyval(lin_T, validShots)).^2; 
stdResidue_NON_FLASH = std(residue)
hold off;
plot(validShots, residue, 'bx','MarkerSize',5);
outlierMask = residue>2*stdResidue_NON_FLASH;
hold on
plot(validShots(outlierMask), residue(outlierMask), 'ro','MarkerSize',10)
plot([1 50], [stdResidue_NON_FLASH stdResidue_NON_FLASH], 'k:','LineWidth',1);

subplot(2,1,1)
hold on
plot(validShots(outlierMask), validTime(outlierMask), 'ro','MarkerSize',10)

subplot(2,1,1)
xlabel('t_{p} (cm)','FontSize',15)
ylabel('t_{r} (s)','FontSize',15)
legend('Spots','Linear fit','Outliers','FontSize',12,'Location','northeast')
title('a)','FontSize',12)
set((1),'Position', [0 0 800 600]);
grid on

subplot(2,1,2)
xlabel('t_{p} (s)','FontSize',15)
ylabel('Residue^2 (s^2)','FontSize',15)
legend('Spots','Outliers','\sigma','FontSize',12,'Location','northeast')
title('b)','FontSize',12)

grid on
%% Ahora habría que usar de nuevo isoutlier (o un threshold en el residuo) para seleccionar los que se alejan de la curva

for i = [1:37,39:length(TABLA)];
    tbl = evalin('base',TABLA{i});
    Teo_Time = [tbl.Tiempo_apertura_teorico_s];
    Time = [tbl.Cierre_s-tbl.Apertura_s];
    residue = (Time - polyval(lin_T, Teo_Time)).^2;
    outlier = residue>2*stdResidue_NON_FLASH;
    Numero_exposiciones = tbl.Numero_exposiciones;
    R = table(Numero_exposiciones,Time,Teo_Time,residue,outlier);
    Failed_Exposure = tbl.Numero_exposiciones(outlier);
    F = table(Failed_Exposure);
    eval([['res_',TABLA{i}],'=R;']);
    eval([['failed_exposures_',TABLA{i}],'=F;']);
end
%%
save('Linear_T_CONV.mat','lin_T','stdResidue_NON_FLASH');
save('residues_NON_FLASH.mat','res_*','stdResidue_NON_FLASH');
save('failed_exposures_NON_FLASH.mat','failed_e*');