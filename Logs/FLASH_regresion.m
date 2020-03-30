clear all
load('tablas_logs_FLASH')
TABLA = who;
shots = [];
Time = [];
for i = 1:length(TABLA)
     tbl = evalin('base',TABLA{i});
     shots = [shots;tbl.FLASH_shots];
     Time = [Time;tbl.Cierre_s-tbl.Apertura_s];
end

Mean = nan(50,2);
for S = 1:50;  %Numero de shots
    ss = find(shots == S);
    Mean(S,2) = mean(Time(ss));
    Mean(S,1) = S;
end

Mean2 = Mean(:,2);
Flash_shots = find( Mean2>0 );
Flash_time = Mean2(Flash_shots);
lin = polyfit(Flash_shots,Flash_time,1)
F = 0:0.01:50;
FF = polyval(lin,F);

plot(Flash_shots,Flash_time,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
    
        
        
        
    