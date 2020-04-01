clear all
load('tablas_logs_NON_FLASH')
TABLA = who;
shots = [];
Time = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.Tiempo_apertura_teorico_s];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];
end

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
stdResidue = std(residue);
hold off;
plot(validShots, residue, 'o');
outlierMask = residue>stdResidue;
hold on
plot(validShots(outlierMask), residue(outlierMask), 'rx')
plot([1 50], [stdResidue stdResidue], 'k:');
subplot(2,1,1);
hold on
plot(validShots(outlierMask), validTime(outlierMask), 'rx')
%% Ahora habría que usar de nuevo isoutlier (o un threshold en el residuo) para seleccionar los que se alejan de la curva