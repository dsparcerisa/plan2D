%% Carga
clear all
close all
load('tablas_logs_FLASH')
TABLA = who;

%% Calculo de los tiempos y plot
shots = [];
Time = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.FLASH_shots];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];
end

%% Fit Time
figure (1)
grid on
validPoints = ~isoutlier(Time,'percentiles', [1 99]);
validShots = shots(validPoints);
validTime = Time(validPoints);
lin_T = polyfit(validShots, validTime,1)
F = 0:0.01:50;
FF = polyval(lin_T,F);

plot(shots,Time,'bx','MarkerSize',5)
hold on
plot(F,FF,':','LineWidth',1)
grid on
xlabel('Flash Shots','FontSize',15)
ylabel('t_{r} (s)','FontSize',15)
legend('Spots','Linear Fit','FontSize',12,'Location','northwest')
set((1),'Position', [0 0 800 600]);

%%    
save('Linear_T_FLASH.mat','lin_T')