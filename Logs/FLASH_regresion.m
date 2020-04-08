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
plot(shots, Time, '+');
grid on

%% Fit
subplot(2,1,1)
lin = polyfit(shots, Time,1);
F = 0:0.01:50;
FF = polyval(lin,F);

plot(shots,Time,'+',F,FF)
xlabel('Number of Flash Shots')
ylabel('Time (s)')
    
%% Residue

subplot(2,1,2);
residue = (Time - polyval(lin, shots)).^2; 
stdResidue_FLASH = std(residue);
hold off;
plot(shots, residue, 'o');
outlierMask = residue>2*stdResidue_FLASH;
hold on
plot(shots(outlierMask), residue(outlierMask), 'rx')
plot([1 50], [stdResidue_FLASH stdResidue_FLASH], 'k:');

%%
for i = 1:length(TABLA);
    tbl = evalin('base',TABLA{i});
    shots_i = [tbl.FLASH_shots];
    Time = [tbl.Cierre_s-tbl.Apertura_s];
    residue = (Time - polyval(lin, shots_i)).^2;
    outlier = residue>stdResidue_FLASH;
    R = [tbl.Numero_exposiciones,Time,residue,outlier];
    Failed_Exposure = tbl.Numero_exposiciones(outlier);
    Percentage_Deviation = abs(1-residue(outlier)./stdResidue_FLASH).*100; %Mirar
    F = table(Failed_Exposure,Percentage_Deviation);
    eval([['res_',TABLA{i}],'=R;']);
    eval([['failed_exposures_',TABLA{i}],'=F;']);
end
clear tbl shots_i Time residue outlier R Failed_Exposure Percentage_Deviation F TABLA
save('residues_FLASH.mat','res_*','stdResidue_FLASH');
save('failed_exposures_FLASH.mat','failed_e*');
   