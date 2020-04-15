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
figure (1)
validPoints = ~isoutlier(Time,'percentiles', [1 99]);
validShots = shots(validPoints);
validTime = Time(validPoints);

lin = polyfit(validShots,validTime,1)
F = 0:0.01:50;
FF = polyval(lin,F);

plot(validShots,validTime,'+',F,FF)
xlabel('Teo Time (s)','FontSize',20)
ylabel('Time (s)','FontSize',20)
grid on

%% Residue

figure (2)
residue = (validTime - polyval(lin, validShots)).^2; 
stdResidue_NON_FLASH = std(residue)
hold off;
plot(validShots, residue, 'o');
outlierMask = residue>2*stdResidue_NON_FLASH;
hold on
plot(validShots(outlierMask), residue(outlierMask), 'rx')
plot([1 50], [stdResidue_NON_FLASH stdResidue_NON_FLASH], 'k:');
xlabel('Teo Time (s)','FontSize',20)
ylabel('chi^2','FontSize',20)
figure (1)
hold on
plot(validShots(outlierMask), validTime(outlierMask), 'rx')
%% Ahora habría que usar de nuevo isoutlier (o un threshold en el residuo) para seleccionar los que se alejan de la curva

for i = [1:37,39:length(TABLA)];
    tbl = evalin('base',TABLA{i});
    Teo_Time = [tbl.Tiempo_apertura_teorico_s];
    Time = [tbl.Cierre_s-tbl.Apertura_s];
    residue = (Time - polyval(lin, Teo_Time)).^2;
    outlier = residue>2*stdResidue_NON_FLASH;
    Numero_exposiciones = tbl.Numero_exposiciones;
    R = table(Numero_exposiciones,Time,Teo_Time,residue,outlier);
    Failed_Exposure = tbl.Numero_exposiciones(outlier);
    F = table(Failed_Exposure);
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
     AX1 = tbl.Moving_to_cm;
     [n,l] = size(AX1);
     AX1 = sum(abs(AX1(2:n,:)-AX1(1:n-1,:)),2);
     AX = [AX;AX1];
     Time_AX1 = [tbl.Arrived_at_s-tbl.Moving_to_s];
     Time_AX = [Time_AX;Time_AX1(2:length(Time_AX1))];
     
end
figure
validPoints = ~isoutlier(Time_AX,'percentiles', [1 99]);
validAX = AX(validPoints);
validTime_AX = Time_AX(validPoints);

lin = polyfit(validAX,validTime_AX,1)
F = 0:0.01:15;
FF = polyval(lin,F);

figure (1)
plot(validAX,validTime_AX,'+',F,FF)
xlabel('\DeltaX','FontSize',20)
ylabel('Time (s)','FontSize',20)
grid on
figure (2)
residue = (validTime_AX - polyval(lin, validAX)).^2; 
stdResidue_AX_NON_FLASH = std(residue)
hold off;
plot(validAX, residue, 'o');
xlabel('\DeltaX','FontSize',20)
ylabel('chi^2','FontSize',20)
outlierMask = residue>2*stdResidue_AX_NON_FLASH;
hold on
plot(validAX(outlierMask), residue(outlierMask), 'rx')
plot([0 15], [stdResidue_AX_NON_FLASH stdResidue_AX_NON_FLASH], 'k:');
figure (1)
hold on
plot(validAX(outlierMask), validTime_AX(outlierMask), 'rx')
%%  Save distances-Time_residues
for i = [1:37,39:length(TABLA)];
    tbl = evalin('base',TABLA{i});
    AX1 = tbl.Moving_to_cm;
    [n,l] = size(AX1);
    AX = sum(abs(AX1(2:n,:)-AX1(1:n-1,:)),2);
    
    Time_AX = [tbl.Arrived_at_s-tbl.Moving_to_s];
    Time_AX = Time_AX(2:length(Time_AX));
    residue = (Time_AX - polyval(lin, AX)).^2;
    outlier = residue>2*stdResidue_AX_NON_FLASH;
    Numero_exposiciones = tbl.Numero_exposiciones;
    Numero_exposiciones = Numero_exposiciones(2:length(Numero_exposiciones));
    R = table(Numero_exposiciones,residue,outlier);
    Failed_Exposure = Numero_exposiciones(outlier);
    F = table(Failed_Exposure);
    eval([['res_AX_',TABLA{i}],'=R;']);
    eval([['failed_exposures_AX_',TABLA{i}],'=F;']);
end
clear tbl AX Time_AX residue outlier R Failed_Exposure F TABLA
save('residues_AX_NON_FLASH.mat','res_AX_*','stdResidue_AX_NON_FLASH');
save('failed_exposures_AX_NON_FLASH.mat','failed_exposures_AX_*');



