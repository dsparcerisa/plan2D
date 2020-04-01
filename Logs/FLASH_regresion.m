%% Carga
clear all
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
plot(shots, Time, '+');
grid on
% %%
% Mean = nan(50,2);
% for S = 1:50  %Numero de shots
%     ss = find(shots == S);
%     Mean(S,2) = mean(Time(ss));
%     Mean(S,1) = S;
% end
% 
% Mean2 = Mean(:,2);
% Flash_shots = find( Mean2>0 );
% Flash_time = Mean2(Flash_shots);
%% Fit
subplot(2,1,1)
lin = polyfit(shots, Time,1)
F = 0:0.01:50;
FF = polyval(lin,F);

plot(shots,Time,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
    
%% Residue

subplot(2,1,2);
residue = (Time - polyval(lin, shots)).^2; 
stdResidue = std(residue);
hold off;
plot(shots, residue, 'o');
outlierMask = residue>2*stdResidue;
hold on
plot(shots(outlierMask), residue(outlierMask), 'rx')
plot([1 50], [stdResidue stdResidue], 'k:');
        
    