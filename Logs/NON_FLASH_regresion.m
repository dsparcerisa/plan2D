clear all
close all
load('tablas_logs_NON_FLASH')
TABLA = who;
shots = [];
Time = [];
%AX = [];
%Time_AX = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.Tiempo_apertura_teorico_s];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];
     %AX = [AX;sum(abs(tbl.XYZ_final_cm-tbl.XYZ_inicial_cm),2)];
     %Time_AX = [Time_AX;tbl.Tiempo_posicion_final_s-tbl.Tiempo_posicion_inicial_s]
     
end
figure
%plot(AX,Time_AX)
validPoints = ~isoutlier(Time,'percentiles', [1 99]);
%validPoints = 1:numel(Time);
validShots = shots(validPoints);
validTime = Time(validPoints);

lin = polyfit(validShots,validTime,1)
F = 0:0.01:50;
FF = polyval(lin,F);

subplot(2,1,1);
plot(validShots,validTime,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
grid on

%% Residue

subplot(2,1,2);
residue = (validTime - polyval(lin, validShots)).^2; 
stdResidue_NON_FLASH = std(residue);
hold off;
plot(validShots, residue, 'o');
outlierMask = residue>stdResidue_NON_FLASH;
hold on
plot(validShots(outlierMask), residue(outlierMask), 'rx')
plot([1 50], [stdResidue_NON_FLASH stdResidue_NON_FLASH], 'k:');
subplot(2,1,1);
hold on
plot(validShots(outlierMask), validTime(outlierMask), 'rx')
%% Ahora habría que usar de nuevo isoutlier (o un threshold en el residuo) para seleccionar los que se alejan de la curva

for i = 1:length(TABLA);
    tbl = evalin('base',TABLA{i});
    shots_i = [tbl.Tiempo_apertura_teorico_s];
    Time = [tbl.Cierre_s-tbl.Apertura_s];
    residue = (Time - polyval(lin, shots_i)).^2;
    outlier = residue>stdResidue_NON_FLASH;
    R = [tbl.Numero_exposiciones,Time,residue,outlier];
    Failed_Exposure = tbl.Numero_exposiciones(outlier);
    Percentage_Deviation = abs(1-residue(outlier)./stdResidue_NON_FLASH).*100;
    F = table(Failed_Exposure,Percentage_Deviation);
    eval([['res_',TABLA{i}],'=R;']);
    eval([['failed_exposures_',TABLA{i}],'=F;']);
end
save('residues_NON_FLASH.mat','res_*','stdResidue_NON_FLASH');
save('failed_exposures_NON_FLASH.mat','failed_e*');




