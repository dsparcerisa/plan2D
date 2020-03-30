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


lin = polyfit(shots,Time,1)
F = 0:0.01:50;
FF = polyval(lin,F);

plot(shots,Time,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
    