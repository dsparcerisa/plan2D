%% load data
clear all
close all
load('tablas_logs_NON_FLASH')
TABLA = who;

%% Time-shots
shots = [];
Time = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.Tiempo_apertura_teorico_s];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];     
end
figure
validPoints = ~isoutlier(Time,'percentiles', [1 99]);
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
%% Distances-Time
AX = [];
Time_AX = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     AX1 = tbl.XYZ_inicial_cm;
     [n,l] = size(AX1);
     AX1 = sum(abs(AX1(2:n,:)-AX1(1:n-1,:)),2);
     AX = [AX;AX1];
     Time_AX1 = [tbl.Tiempo_posicion_final_s-tbl.Tiempo_posicion_inicial_s];
     Time_AX = [Time_AX;Time_AX1(2:length(Time_AX1))];
     
end
figure
validPoints = ~isoutlier(Time_AX,'percentiles', [1 99]);
validAX = AX(validPoints);
validTime_AX = Time_AX(validPoints);

lin = polyfit(validAX,validTime_AX,1)
F = 0:0.01:15;
FF = polyval(lin,F);

subplot(2,1,1);
plot(validAX,validTime_AX,'+',F,FF)
xlabel('\DeltaX')
ylabel('Time (s)')
grid on
%Residue
subplot(2,1,2);
residue = (validTime_AX - polyval(lin, validAX)).^2; 
stdResidue_AX_NON_FLASH = std(residue);
hold off;
plot(validAX, residue, 'o');
outlierMask = residue>stdResidue_AX_NON_FLASH;
hold on
plot(validAX(outlierMask), residue(outlierMask), 'rx')
plot([1 15], [stdResidue_AX_NON_FLASH stdResidue_AX_NON_FLASH], 'k:');
subplot(2,1,1);
hold on
plot(validAX(outlierMask), validTime_AX(outlierMask), 'rx')




