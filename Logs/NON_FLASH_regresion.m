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
validShots = shots(validPoints);
validTime = Time(validPoints);

lin = polyfit(validShots,validTime,1)
F = 0:0.01:50;
FF = polyval(lin,F);

plot(validShots,validTime,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
grid on

%% Ahora habría que usar de nuevo isoutlier (o un threshold en el residuo) para seleccionar los que se alejan de la curva